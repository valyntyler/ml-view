import sys
from PySide6.QtCore import Qt
from PySide6.QtWidgets import QApplication, QLabel

from rendercanvas.auto import RenderCanvas, loop
from rendercanvas.utils.cube import setup_drawing_sync


canvas = RenderCanvas(
    title="The wgpu cube example on $backend", update_mode="continuous"
)
draw_frame = setup_drawing_sync(canvas)
canvas.request_draw(draw_frame)

loop.run()
