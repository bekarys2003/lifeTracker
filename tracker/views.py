from .forms import ScheduleForm
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import Schedule
from django.urls import reverse
from django.utils import timezone
from datetime import timedelta
from django.contrib import messages


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
    return render(request, 'tracker/schedule_form.html', {'form': form})



@login_required
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

    return render(request, 'tracker/schedule_list.html', {
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
    return render(request, 'tracker/schedule_form.html', {'form': form})


@login_required
def delete_schedule(request, pk):
    # Get the schedule object or return a 404 if it doesn't exist
    schedule = get_object_or_404(Schedule, pk=pk)

    # Delete the schedule
    schedule.delete()

    # Redirect to a different page after deletion (e.g., the schedule list page)
    return redirect(reverse('schedule_list'))



@login_required
def schedule_detail(request, pk):
    # Fetch the schedule object or return a 404 error if not found
    schedule = get_object_or_404(Schedule, pk=pk)


    # Render the schedule detail template with the schedule, comments, and form
    return render(request, 'tracker/schedule_detail.html', {
        'schedule': schedule,
    })



@login_required
def mark_schedule_completed(request, pk):
    schedule = get_object_or_404(Schedule, pk=pk, profile=request.user.profile)
    print(f"Current Streak: {schedule.streak}")
    print(f"Last Updated: {schedule.updated_at.date()}")
    print(f"Today: {timezone.now().date()}")
    # Check if the schedule was last updated yesterday (to maintain the streak)
    if schedule.streak == 0 and schedule.updated_at.date() == timezone.now().date():
        schedule.streak = 1 # Start the streak
        messages.success(request, 'Success')

    else:
        # Check if the schedule was last updated today
        if schedule.updated_at.date() == timezone.now().date():
            messages.error(request, 'the streak already completed today')
        else:
            # Check if the schedule was last updated yesterday (to maintain the streak)
            if schedule.updated_at.date() == (timezone.now() - timedelta(days=1)).date():
                messages.success(request, 'Success')
                schedule.streak += 1  # Increment streak
            else:
                messages.success(request, 'Streak is lost :(')
                schedule.streak = 1  # Reset streak if more than one day has passed

    schedule.updated_at = timezone.now()  # Update the last updated timestamp
    schedule.save()  # Save the updated streak
    return redirect('schedule_list')