from django.shortcuts import render, redirect
from django.contrib.auth import get_user_model, login as auth_login, logout
from .forms import UserRegistrationForm
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.contrib.auth import get_backends
from django.contrib.auth.forms import AuthenticationForm
from django.views.decorators.cache import never_cache

#def activateEmail(request, user, to_email):
    #messages.success(request, f'please check your email {to_email}')


def home(request):
    return render(request, "home.html")


def register(request):
    if request.user.is_authenticated:
        return redirect('/')

    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            auth_login(request, user, backend='allauth.account.auth_backends.AuthenticationBackend')
            messages.success(request, f"New account created {user.username}")
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


@never_cache
@login_required
def custom_logout(request):
    logout(request)
    messages.info(request, "Logged out successfully")
    return redirect("/")


@never_cache
def custom_login(request):
    # Redirect authenticated users
    if request.user.is_authenticated:
        return redirect("/")

    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)  # Log the user in
            messages.success(request, f"Welcome back, {user.username}!")
            next_url = request.GET.get('next', '/')  # Redirect to 'next' or home
            return redirect(next_url)
        else:
            # Display form errors
            for error in list(form.errors.values()):
                messages.error(request, error)
    else:
        form = AuthenticationForm()

    return render(
        request=request,
        template_name='users/login.html',
        context={'form': form}
    )