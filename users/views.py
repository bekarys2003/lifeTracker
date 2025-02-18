from django.shortcuts import render, redirect
from django.contrib.auth import get_user_model, login as auth_login, logout
from .forms import UserRegistrationForm, UserLoginForm, SetPasswordForm
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


def home(request):
    return render(request, 'home.html')

@user_not_authenticated
def register(request):

    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.is_active=False
            user.save()
            activateEmail(request, user, form.cleaned_data.get('email'))
            # auth_login(request, user, backend='allauth.account.auth_backends.AuthenticationBackend')
            # messages.success(request, f"New account created {user.username}")
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
            next_url = request.GET.get('next', '/')  # Redirect to 'next' or home
            return redirect(next_url)
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






from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from .forms import ProfileForm
from .models import Profile

@login_required
def profile_update(request):
    profile = request.user.profile
    if request.method == 'POST':
        form = ProfileForm(request.POST, instance=profile)
        if form.is_valid():
            form.save()
            return redirect('profile')  # Redirect to the profile page
    else:
        form = ProfileForm(instance=profile)
    return render(request, 'users/profile_update.html', {'form': form})


from django.shortcuts import render, get_object_or_404
from django.contrib.auth import get_user_model
from .models import Profile

User = get_user_model()

def public_profile(request, username):
    # Get the user object or return a 404 error if not found
    user = get_object_or_404(User, username=username)
    # Get the profile of the user
    profile = get_object_or_404(Profile, user=user)
    # Render the profile template with the profile data
    return render(request, 'users/profile.html', {'profile': profile})



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