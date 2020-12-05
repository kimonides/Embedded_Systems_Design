import plotly.express as px
import os
import numpy as np
import pandas as pd

df=pd.DataFrame( [],columns=['time','questionNumber'] )

for filename in os.listdir("./logs"):
    with open("./logs/"+filename,'r') as file:
        for line in file:
            row = pd.DataFrame([[int(line), int(filename)]], columns=['time','questionNumber'] )
            df = df.append(row,ignore_index=True)

fig=px.box(df,y='time',x='questionNumber')
fig.show()
