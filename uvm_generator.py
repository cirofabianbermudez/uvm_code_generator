import os
import shutil
import yaml
import jinja2

def template_routine(template_dir = "templates", output_dir_sufix = ""):

    # Define the template directory
    #template_dir = "templates/uvc_template/"

    # Define YAML file
    yaml_file = "example/uvc.yaml"

    # Read information from YAML file
    with open(yaml_file, mode = "r", encoding = "utf-8") as file:
        yaml_data = yaml.safe_load(file)

    # Create a list of all template files
    entries = os.listdir(template_dir)
    file_list = []
    for entry in entries:
        full_path = os.path.join(template_dir, entry)
        if os.path.isfile(full_path):
            file_list.append(entry)

    print(file_list)

    # Create output directory
    output_dir = os.path.join(yaml_data["name"], output_dir_sufix)
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
    os.makedirs(output_dir)

    # Create jinja2 environment
    env = jinja2.Environment(
        loader = jinja2.FileSystemLoader(template_dir)
    )

    for file in file_list:
        template = env.get_template(file)
        filename = yaml_data["name"] + "_" + file
        filename = os.path.join(output_dir, filename)
        content = template.render(yaml_data)
        #print(content)

        with open(filename, mode = "w", encoding = "utf-8") as output:
            output.write(content)
            print(f"{filename:35} generated")

def main():
    template_routine("templates/uvc_template", "")
    template_routine("templates/uvc_template/seqlib", "seqlib")

if __name__ == "__main__":
    main()
