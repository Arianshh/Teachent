from flask_wtf import Form
from wtforms.fields import StringField
from wtforms.fields.html5 import URLField
from wtforms.validators import DataRequired, url

class BookmarkForm(Form):
    url = URLField('The URL for your bookmark:', validators=[DataRequired(), url()])
    description = StringField('Add an optional description:')

    class BookmarkForm(Form):
        description = StringField('Your Search Content:')

    def validate(self):
        if not self.url.data.startswith("http://") or\
            self.url.data.startswith("https://"):
            self.url.data = "http://" + self.url.data

        if not Form.validate(self):
            return False

        if not self.description.data:
            self.description.data = self.url.data

        return True