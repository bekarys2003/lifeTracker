from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, SetPasswordForm, PasswordResetForm
from django.contrib.auth import get_user_model
from captcha.widgets import ReCaptchaV2Checkbox
from captcha.fields import ReCaptchaField
from allauth.socialaccount.forms import SignupForm
from django.core.exceptions import ValidationError
from .models import Profile
from .models import Schedule
from .models import Post

class UserRegistrationForm(UserCreationForm):
    email = forms.EmailField(help_text='A valid email address, please', required=True)

    class Meta:
        model = get_user_model()
        fields = ['username', 'email', 'password1', 'password2']

    def save(self, commit=True):
        user = super(UserRegistrationForm, self).save(commit=False)
        user.email = self.cleaned_data['email']
        if commit:
            user.save()
            Profile.objects.create(user=user)
        return user



class UserLoginForm(AuthenticationForm):
    def __init__(self, *args, **kwargs):
        super(UserLoginForm, self).__init__(*args, **kwargs)

    username = forms.CharField(widget=forms.TextInput(
        attrs={'class': 'form-control', 'placeholder': 'Username or Email'}),
        label='Username or Email'
    )
    password = forms.CharField(widget=forms.PasswordInput(
        attrs={'class': 'form-control', 'placeholder': 'Password'})
    )

    captcha = ReCaptchaField(widget=ReCaptchaV2Checkbox())


from django import forms
from allauth.socialaccount.forms import SignupForm
from django.core.exceptions import ValidationError
from django.contrib.auth import get_user_model

User = get_user_model()

class CustomSocialSignupForm(SignupForm):
    username = forms.CharField(
        label="Username",
        max_length=150,
        required=True,
        help_text="Required. 150 characters or fewer. Letters, digits, and @/./+/-/_ only.",
    )
    email = forms.EmailField(
        label="Email",
        disabled=True,
        required=False,
    )

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if 'email' in self.sociallogin.account.extra_data:
            self.fields['email'].initial = self.sociallogin.account.extra_data['email']
        else:
            raise ValidationError("The social provider did not provide an email address. Please use a different signup method.")

    def clean_email(self):
        email = self.cleaned_data.get('email')
        if not email:
            raise ValidationError("Email is required.")
        return email

    def clean_username(self):
        username = self.cleaned_data['username']
        if User.objects.filter(username=username).exists():
            raise ValidationError("A user with that username already exists.")
        return username

    def save(self, request):
        # Save the user
        user = super().save(request)
        user.username = self.cleaned_data['username']
        user.save()

        # Set a session flag to indicate the user needs to create a profile
        request.session['redirect_to_create_profile'] = True
        print(f"Session flag set for user: {user.username}")  # Debug statement

        return user



class SetPasswordForm(SetPasswordForm):
    class Meta:
        model = get_user_model()
        fields = ['new_password1', 'new_password2']



class PasswordResetForm(PasswordResetForm):
    def __init__(self, *args, **kwargs):
        super(PasswordResetForm, self).__init__(*args, **kwargs)

    captcha = ReCaptchaField(widget=ReCaptchaV2Checkbox())





class ProfileForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ['gender', 'height', 'weight', 'body_fat', 'date_of_birth', 'location', 'profile_picture']

class ProfileCreateForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ['gender', 'height', 'weight', 'body_fat', 'date_of_birth', 'location', 'profile_picture']


    # Add any additional fields or logic for profile creation
    agree_to_terms = forms.BooleanField(
        required=True,
        widget=forms.CheckboxInput(attrs={'class': 'form-check-input'}),
        label="I agree to the terms and conditions",
    )



# Schedules




class ScheduleForm(forms.ModelForm):
    class Meta:
        model = Schedule
        fields = ['title', 'description', 'start_time', 'end_time']
        widgets = {
            'start_time': forms.TimeInput(attrs={'type': 'time'}),
            'end_time': forms.TimeInput(attrs={'type': 'time'}),
        }



class PostForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = ['content']