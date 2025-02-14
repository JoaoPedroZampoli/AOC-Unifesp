import tkinter as tk
from tkinter import ttk, scrolledtext
from PIL import Image, ImageTk
import subprocess
import os

class MIPSSimulatorGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("MIPS Simulator GUI")
        
        # Configure grid weights for root
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        
        # Create main frame
        self.main_frame = ttk.Frame(root, padding="10")
        self.main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Configure grid weights for main frame
        self.main_frame.columnconfigure(0, weight=1)
        self.main_frame.rowconfigure(1, weight=1)
        self.main_frame.rowconfigure(4, weight=1)
        
        # Code editor
        self.code_label = ttk.Label(self.main_frame, text="MIPS Code:")
        self.code_label.grid(row=0, column=0, sticky=tk.W)
        
        self.code_editor = scrolledtext.ScrolledText(self.main_frame, width=50, height=20)
        self.code_editor.grid(row=1, column=0, padx=5, pady=5, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Default MIPS code
        self.code_editor.insert(tk.END, """
.data
    message: .asciiz "Hello from MIPS!"

.text
main:
    li $v0, 4
    la $a0, message
    syscall
    
    li $v0, 10
    syscall
        """)
        
        # Buttons of the UI
        self.button_frame = ttk.Frame(self.main_frame)
        self.button_frame.grid(row=2, column=0, pady=10)
        
        self.run_button = ttk.Button(self.button_frame, text="Run MIPS", command=self.run_mips)
        self.run_button.grid(row=0, column=0, padx=5)
        
        self.clear_button = ttk.Button(self.button_frame, text="Clear", command=self.clear_output)
        self.clear_button.grid(row=0, column=1, padx=5)
        
        # Output area with tabs (for future usage of text and image outputs)
        self.output_label = ttk.Label(self.main_frame, text="Output:")
        self.output_label.grid(row=3, column=0, sticky=tk.W)
        
        self.output_notebook = ttk.Notebook(self.main_frame)
        self.output_notebook.grid(row=4, column=0, padx=5, pady=5, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        self.text_output_frame = ttk.Frame(self.output_notebook)
        self.image_output_frame = ttk.Frame(self.output_notebook)
        
        self.output_notebook.add(self.text_output_frame, text="Text Output")
        self.output_notebook.add(self.image_output_frame, text="Image Output")
        
        self.output_area = scrolledtext.ScrolledText(self.text_output_frame, width=50, height=10)
        self.output_area.grid(row=0, column=0, padx=5, pady=5, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        self.image_label = ttk.Label(self.image_output_frame)
        self.image_label.grid(row=0, column=0, padx=5, pady=5, sticky=(tk.W, tk.E, tk.N, tk.S))
    
    def run_mips(self):
        # Save MIPS code to temporary file
        temp_file = "temp.asm"
        with open(temp_file, "w") as f:
            f.write(self.code_editor.get("1.0", tk.END))
        
        try:
            # This part tries to run the MARS simulator with the temporary file
            # Replace 'Mars45.jar' path with the MARS simulator path
            result = subprocess.run(
                ["java", "-jar", "Mars45.jar", "nc", temp_file],
                capture_output=True,
                text=True
            )
            
            # Display text output
            self.output_area.delete("1.0", tk.END)
            self.output_area.insert(tk.END, result.stdout)
            if result.stderr:
                self.output_area.insert(tk.END, "\nErrors:\n" + result.stderr)
                
            # Display image output if it exists, ##still not working :(
            image_path = "output.bmp"  # Replace with actual image path if applicable
            if os.path.exists(image_path):
                image = Image.open(image_path)
                photo = ImageTk.PhotoImage(image)
                self.image_label.config(image=photo)
                self.image_label.image = photo
                
        except FileNotFoundError:
            self.output_area.delete("1.0", tk.END)
            self.output_area.insert(tk.END, "Error: MARS simulator not found. Please check the path.")
        except Exception as e:
            self.output_area.delete("1.0", tk.END)
            self.output_area.insert(tk.END, f"Error: {str(e)}")
        finally:
            # Clean up temporary file
            if os.path.exists(temp_file):
                os.remove(temp_file)
    
    def clear_output(self):
        self.output_area.delete("1.0", tk.END)
        self.image_label.config(image='')

# Create and run the application
if __name__ == "__main__":
    root = tk.Tk()
    app = MIPSSimulatorGUI(root)
    root.mainloop()