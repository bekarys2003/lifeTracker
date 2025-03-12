from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import get_user_model, login as auth_login, logout
from .forms import UserRegistrationForm, UserLoginForm, SetPasswordForm, PasswordResetForm
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.contrib.auth import get_backends
from .decorators import user_not_authenticated
from .tokens import account_activation_token
from django.template.loader import render_to_string
from django.contrib.sites.shortcuts import get_current_site
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.core.mail import EmailMessage
from django.db.models.query_utils import Q
from .forms import ProfileForm
from django.contrib.auth import login as auth_login
from django.urls import reverse
from .models import Profile
from .forms import ProfileCreateForm
import google.generativeai as genai
from decouple import config
from .forms import CommentForm
from .models import Post, Like, Profile, Comment
from .forms import PostForm
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.http import HttpResponseRedirect
# -------Email Activation--------
def activate(request, uidb64, token):
    User = get_user_model()
    try:
        uid = force_str(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except:
        user = None
    if user is not None and account_activation_token.check_token(user, token):
        user.is_active = True
        user.save()
        messages.success(request, "Email Confirmed. Now you can login")
        return redirect('login')
    else:
        messages.error(request, "Activation link is invalid")
    return redirect('/')



def activateEmail(request, user, to_email):
    mail_subject = 'activate your user account. '
    message = render_to_string("users/template_activate_account.html", {
        'user': user.username,
        'domain': get_current_site(request).domain,
        'uid': urlsafe_base64_encode(force_bytes(user.pk)),
        'token': account_activation_token.make_token(user),
        'protocol': 'https' if request.is_secure() else 'http'
    })
    email = EmailMessage(mail_subject, message, to=[to_email])
    if email.send():
        messages.success(request, f'please check your email {to_email}')
    else:
        messages.error(request, f"Problem sending email to {to_email}.")



# -------Home--------
def home(request):
    return render(request, 'home.html')



# -------Registration/Login--------
@user_not_authenticated
def register(request):

    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.is_active=False
            user.save()
            activateEmail(request, user, form.cleaned_data.get('email'))
            return redirect('/')
        else:
            for error in list(form.errors.values()):
                messages.error(request, error)

    else:
        form = UserRegistrationForm()

    return render(
        request=request,
        template_name='users/signup.html',
        context={'form': form}
    )



@login_required
def custom_logout(request):
    logout(request)
    messages.info(request, "Logged out successfully")
    return redirect("/")



@user_not_authenticated
def custom_login(request):
    if request.method == 'POST':
        form = UserLoginForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)  # Log the user in
            messages.success(request, f"Welcome back, {user.username}!")

            # Check if the user has a profile
            try:
                profile = Profile.objects.get(user=user)
                # Redirect to the user's profile page
                return redirect(reverse('public_profile', kwargs={'username': user.username}))
            except Profile.DoesNotExist:
                # Redirect to the profile update page if no profile exists
                return redirect('profile_create')

        else:
            # Display form errors
            for key, error in list(form.errors.items()):
                if key == 'captcha' and error[0] == 'This field is required.':
                    messages.error(request, 'You must pass the reCAPTCHA test')
                    continue
                messages.error(request, error)
    else:
        form = UserLoginForm()

    return render(
        request=request,
        template_name='users/login.html',
        context={'form': form}
    )



@login_required
def password_change(request):
    user = request.user
    if request.method == 'POST':
        form = SetPasswordForm(user, request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Your password has been changed")
            return redirect('login')
        else:
            for error in list(form.errors.values()):
                messages.error(request, error)
    form = SetPasswordForm(user)
    return render(request, 'users/password_reset_confirm.html', {'form': form})



@user_not_authenticated
def password_reset_request(request):
    if request.method == 'POST':
        form = PasswordResetForm(request.POST)
        if form.is_valid():
            user_email = form.cleaned_data['email']
            associated_user = get_user_model().objects.filter(Q(email=user_email)).first()
            if associated_user:
                subject = 'Password Reset Request'
                message = render_to_string("users/email/template_reset_password.html", {
                    'user': associated_user,
                    'domain': get_current_site(request).domain,
                    'uid': urlsafe_base64_encode(force_bytes(associated_user.pk)),
                    'token': account_activation_token.make_token(associated_user),
                    'protocol': 'https' if request.is_secure() else 'http'
                    })
                email = EmailMessage(subject, message, to=[associated_user.email])
                if email.send():
                    messages.success(request, f'please check your email')
                else:
                    messages.error(request, f"Problem sending email.")


            return redirect('/')

            for key, error in list(form.errors.items()):
                if key == 'captcha' and error[0] == 'This field is required.':
                    messages.error(request, 'You must pass the reCAPTCHA test')
                    continue

    form = PasswordResetForm()
    return render(
        request=request,
        template_name='users/password_reset.html',
        context={'form': form}
        )




def passwordResetConfirm(request, uidb64, token):
    User = get_user_model()
    try:
        uid = force_str(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except:
        user = None

    if user is not None and account_activation_token.check_token(user, token):
        if request.method == 'POST':
            form = SetPasswordForm(user, request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, "Your password has been changed successfully")
                return redirect('/')
            else:
                for error in list(form.errors.values()):
                    messages.error(request, error)
        form = SetPasswordForm(user)

        return render(request, 'users/password_reset_confirm.html', {'form': form})
    else:
        messages.error(request, 'link is expired')
    messages.error(request, 'something went wrong')
    return redirect('/')



# -------Profile--------
@login_required
def profile_update(request):
    profile = request.user.profile
    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES, instance=profile)  # Include request.FILES
        if form.is_valid():
            form.save()
            return redirect(reverse('public_profile', kwargs={'username': profile.user.username}))
    else:
        form = ProfileForm(instance=profile)
    return render(request, 'users/profile_update.html', {'form': form})


User = get_user_model()



def public_profile(request, username):
    user = get_object_or_404(User, username=username)
    profile = get_object_or_404(Profile, user=user)
    posts = Post.objects.filter(profile=user).order_by('-created_at')  # Fetch the user's posts

    return render(request, 'users/profile.html', {
        'profile': profile,
        'posts': posts,  # Pass the posts to the template
    })



def create_profile(request):
    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES)  # Include request.FILES
        if form.is_valid():
            profile = form.save(commit=False)
            profile.user = request.user  # Associate the profile with the logged-in user
            profile.save()
            messages.success(request, 'Profile created successfully!')
            return redirect(reverse('public_profile', kwargs={'username': profile.user.username}))
    else:
        form = ProfileForm()
    return render(request, 'users/profile_create.html', {'form': form})



def analyze_profile_with_ai(profile):
    # Configure the Gemini API
    genai.configure(api_key=config('GEMINI_API_KEY'))

    # Initialize the Gemini model
    model = genai.GenerativeModel('gemini-pro')

    # Prepare the prompt using profile data
    prompt = f"""
    Analyze the following profile and provide a summary of the person's characteristics:
    - Bio: {profile.bio}
    - Date of Birth: {profile.date_of_birth}
    - Location: {profile.location}
    """

    # Call the Gemini API
    response = model.generate_content(prompt)

    # Return the generated text
    return response.text




# ---------Posts-------------

def post_detail(request, post_id):
    post = get_object_or_404(Post, uuid=post_id)
    comments = post.post_comments.all().order_by('-created_at')  # Get all comments for the post

    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.user = request.user  # Set the comment's user to the logged-in user
            comment.post = post  # Associate the comment with the post
            comment.save()
            return redirect('post_detail', post_id=post_id)  # Redirect to the same post page
    else:
        form = CommentForm()

    return render(request, 'users/post_detail.html', {
        'post': post,
        'comments': comments,
        'form': form,
    })


@login_required
def post_list(request):
    posts = Post.objects.all().order_by('-created_at')

    profile = get_object_or_404(Profile, user=request.user)
    # Add a flag to each post indicating whether the current user has liked it
    for post in posts:
        post.user_has_liked = Like.objects.filter(user=request.user, post=post).exists()

    return render(request, 'users/post_list.html', {
        'posts': posts,
        'profile': profile,
    })


@login_required
@csrf_exempt
def like_post(request, post_id):
    if request.method == 'POST':
        post = get_object_or_404(Post, uuid=post_id)
        like, created = Like.objects.get_or_create(user=request.user, post=post)
        if not created:
            like.delete()  # Unlike the post if the like already exists
        return JsonResponse({
            'likes_count': post.post_likes.count(),  # Use post_likes instead of likes
        })
    return JsonResponse({'error': 'Invalid request'}, status=400)




@login_required # Temporarily disable CSRF for debugging; re-enable later
def delete_post(request, post_id):
    if request.method == 'POST':
        try:
            # Ensure the post belongs to the current user
            post = Post.objects.get(uuid=post_id, profile=request.user)
            print(post)
            post.delete()
        except Post.DoesNotExist:
            messages.error(request, 'Error Deleting The Post')
            return redirect(reverse('public_profile', kwargs={'username': request.user.username}))
        messages.success(request, 'Post Deleted Successfully!')

    return redirect(reverse('public_profile', kwargs={'username': request.user.username}))

@login_required
def create_post(request):
    if request.method == 'POST':
        form = PostForm(request.POST, request.FILES)
        if form.is_valid():
            post = form.save(commit=False)
            post.profile = request.user
            post.save()
            return redirect(reverse('public_profile', kwargs={'username': request.user.username}))
    else:
        form = PostForm()
    return render(request, 'users/post_create.html', {'form': form})


def add_comment(request, post_id):
    post = get_object_or_404(Post, id=post_id)
    if request.method == 'POST':
        content = request.POST.get('content')
        Comment.objects.get(user=request.user, post=post, content=content)
    return render(request, 'users/post_create.html', {'form': form})



