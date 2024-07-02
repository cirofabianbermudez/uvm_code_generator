import os
import shutil
import yaml
import jinja2

def main():

    # Define the template directory
    template_dir = "templates/uvc_template/"

    # Define YAML file
    yaml_file = "example/uvc.yaml"

    # Read information from YAML file
    with open(yaml_file, mode = "r", encoding = "utf-8") as file:
        yaml_data = yaml.safe_load(file)

    #for key, value in yaml_data.items():
    #    print(f"{key:8}: {value}")

    #keys = list( yaml_data.keys() )
    #print(f"This is the key {keys[0]} and this is inside {yaml_data[keys[0]] } ")

    #templates = [f for f in os.listdir(template_dir) if os.path.isfile(os.path.join(template_dir, f))]
    #print(templates)

    # Create a list of all template files
    entries = os.listdir(template_dir)
    file_list = []
    for entry in entries:
        full_path = os.path.join(template_dir, entry)
        if os.path.isfile(full_path):
            file_list.append(entry)

    #print(file_list)

    # Create output directory
    output_dir = yaml_data["name"]
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
    os.makedirs(output_dir)

    # Create jinja2 environment
    env = jinja2.Environment(
        loader = jinja2.FileSystemLoader(template_dir)
    )

    for file in file_list:
        template = env.get_template(file)
        filename = output_dir + "/" + yaml_data["name"] + "_" + file
        content = template.render(yaml_data)

        with open(filename, mode = "w", encoding = "utf-8") as output:
            output.write(content)
            print(f"{filename:35} generated")

if __name__ == "__main__":
    main()
