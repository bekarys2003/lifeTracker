from .forms import ScheduleForm, DailyProgressForm
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import Schedule, DailyProgress, ThreeDModel
from django.urls import reverse
from django.utils import timezone
from datetime import timedelta
from django.contrib import messages
import json
from django.http import JsonResponse



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
    today = timezone.now().date()

    # Count how many schedules have been completed today
    completed_today_count = Schedule.objects.filter(
        profile=request.user.profile,  # Filter by the current user's profile
        completed_at__date=today  # Filter by today's date
    ).count()

    total_schedules_count = schedules.count()

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
        'completed_today_count': completed_today_count,
        'total_schedules_count': total_schedules_count,
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
    schedule = get_object_or_404(Schedule, pk=pk, profile=request.user.profile)

    # Delete the schedule
    schedule.delete()

    # Redirect to a different page after deletion (e.g., the schedule list page)
    return redirect(reverse('schedule_list'))


@login_required
def mark_schedule_completed(request, pk):
    schedule = get_object_or_404(Schedule, pk=pk, profile=request.user.profile)

    # Mark the schedule as completed
    schedule.completed_at = timezone.now()  # Set the current date and time
    schedule.save()

    # Redirect back to the schedule detail page
    return redirect('schedule_detail', pk=schedule.uuid)


@login_required
def schedule_detail(request, pk):
    schedule = get_object_or_404(Schedule, pk=pk, profile=request.user.profile)

    # Get today's progress entry (if it exists)
    today = timezone.now().date()
    daily_progress, created = DailyProgress.objects.get_or_create(
        schedule=schedule,
        date=today,
        defaults={'duration_completed': 0, 'effort_percentage': 0}
    )

    if request.method == 'POST':
        form = DailyProgressForm(request.POST, instance=daily_progress)
        if form.is_valid():
            form.save()
            return redirect('schedule_detail', pk=schedule.uuid)
    else:
        form = DailyProgressForm(instance=daily_progress)

    # Get progress data for the last 7 days
    progress_data = DailyProgress.objects.filter(
        schedule=schedule,
        date__gte=today - timezone.timedelta(days=6)  # Last 7 days
    ).order_by('date')

    return render(request, 'tracker/schedule_detail.html', {
        'schedule': schedule,
        'form': form,
        'progress_data': progress_data,  # Pass progress data to the template
    })



# ----------Three.js------------
def get_models(request):
    models = ThreeDModel.objects.all()
    data = [{
        'name': model.name,
        'file_path': model.file_path,
        'description': model.description,
    } for model in models]
    return JsonResponse(data, safe=False)



