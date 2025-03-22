from .models import Schedule, DailyProgress, ThreeDModel
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


class ThreeDModelForm(forms.ModelForm):
    class Meta:
        model = ThreeDModel
        fields = ['name', 'file_path', 'description', 'camera_position_z']