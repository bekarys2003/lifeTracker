from django.dispatch import receiver
from django.contrib.auth.signals import user_logged_in
from allauth.socialaccount.signals import social_account_added
from django.shortcuts import redirect
from django.urls import reverse
from .models import Profile


@receiver(social_account_added)
@receiver(user_logged_in)
def redirect_if_no_profile(sender, request, user, **kwargs):
    """
    Signal handler to redirect users based on whether they have a profile.
    """
    print(f"Signal: User {user.username} logged in.")  # Debug statement

    # Check if the user has a profile
    if hasattr(user, 'profile'):  # User already has a profile
        print(f"Signal: User {user.username} has a profile. Setting redirect flag.")  # Debug statement
        request.session['redirect_to'] = 'public_profile'  # Set the redirect flag
        request.session['redirect_username'] = user.username  # Store the username
    else:  # User does not have a profile
        print(f"Signal: User {user.username} does not have a profile. Flag set.")  # Debug statement
        request.session['redirect_to_create_profile'] = True  # Set the session flag
        print(f"Session flag: {request.session.get('redirect_to_create_profile')}")  # Debug session flag
