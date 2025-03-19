from .models import Schedule, DailyProgress
from django import forms

class ScheduleForm(forms.ModelForm):
    class Meta:
        model = Schedule
        fields = ['title', 'description', 'start_time', 'end_time', 'duration']
        widgets = {
            'start_time': forms.TimeInput(attrs={'type': 'time'}),
            'end_time': forms.TimeInput(attrs={'type': 'time'}),
        }



class DailyProgressForm(forms.ModelForm):
    class Meta:
        model = DailyProgress
        fields = ['duration_completed', 'effort_percentage']