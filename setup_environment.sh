rm -fr picam_venv
python3 -m venv picam_venv
. picam_venv/bin/activate
pip3 install -r requirements.txt
echo -e "\n------------------------------------------------------------\n"
echo ". picam_venv/bin/activate (to use environment)"
echo "deactivate (to tear down environment)"
