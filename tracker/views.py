from .forms import ScheduleForm
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import Schedule
from django.urls import reverse


@login_required
def schedule_create(request):
    if request.method == 'POST':
        form = ScheduleForm(request.POST)
        if form.is_valid():
            schedule = form.save(commit=False)  # Don't save yet
            schedule.profile = request.user.profile  # Assign the profile
            schedule.save()  # Now save
            return redirect('schedule_list')
    else:
        form = ScheduleForm()
    return render(request, 'users/schedule_form.html', {'form': form})



@login_required  # Ensure the user is logged in
def schedule_list(request):
    schedules = Schedule.objects.filter(profile=request.user.profile)  # Filter schedules by the current user's profile
    if request.method == 'POST':
        form = ScheduleForm(request.POST)
        if form.is_valid():
            schedule = form.save(commit=False)  # Don't save the form yet
            schedule.profile = request.user.profile  # Set the profile to the current user's profile
            schedule.save()  # Now save the schedule
            return redirect('schedule_list')  # Redirect to refresh the page
    else:
        form = ScheduleForm()

    return render(request, 'users/schedule_list.html', {
        'schedules': schedules,
        'form': form,
    })


@login_required
def schedule_update(request, pk):
    # Get the schedule item to edit
    schedule = get_object_or_404(Schedule, pk=pk, profile=request.user.profile)  # Ensure the user owns the schedule item
    if request.method == 'POST':
        form = ScheduleForm(request.POST, instance=schedule)  # Bind the form to the existing schedule item
        if form.is_valid():
            form.save()  # Save the updated schedule item
            return redirect('schedule_list')  # Redirect to the schedule list page
    else:
        form = ScheduleForm(instance=schedule)  # Pre-fill the form with the existing schedule item
    return render(request, 'users/schedule_form.html', {'form': form})



def delete_schedule(request, schedule_id):
    # Get the schedule object or return a 404 if it doesn't exist
    schedule = get_object_or_404(Schedule, id=schedule_id)

    # Delete the schedule
    schedule.delete()

    # Redirect to a different page after deletion (e.g., the schedule list page)
    return redirect(reverse('schedule_list'))
