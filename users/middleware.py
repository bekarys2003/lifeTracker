from django.shortcuts import redirect

class ProfileCheckMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):

        # Check if the user needs to be redirected to their profile page
        if 'redirect_to' in request.session:
            redirect_to = request.session.pop('redirect_to')
            username = request.session.pop('redirect_username', None)
            if redirect_to == 'public_profile' and username:
                print(f"Middleware: Redirecting to public profile page for {username}.")  # Debug statement
                return redirect('public_profile', username=username)

        # Check if the user needs to be redirected to the profile creation page
        if request.session.get('redirect_to_create_profile'):
            print("Middleware: Redirecting to profile creation page.")  # Debug statement
            del request.session['redirect_to_create_profile']  # Clear the flag
            return redirect('profile_create')  # Redirect to the profile creation page

        response = self.get_response(request)
        return response