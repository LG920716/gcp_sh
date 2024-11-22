gcloud dns managed-zones create accounts-dns \
    --description="DNS for accounts.google.com" \
    --dns-name="accounts.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create accounts.google.com. \
    --zone="accounts-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create aiplatform-notebook-dns \
    --description="DNS for *.aiplatform-notebook.cloud.google.com" \
    --dns-name="aiplatform-notebook.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.aiplatform-notebook.cloud.google.com." \
    --zone="aiplatform-notebook-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="aiplatform-notebook.cloud.google.com."

gcloud dns record-sets create aiplatform-notebook.cloud.google.com. \
    --zone="aiplatform-notebook-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create aiplatform-notebook-googleusercontent-dns \
    --description="DNS for *.aiplatform-notebook.googleusercontent.com" \
    --dns-name="aiplatform-notebook.googleusercontent.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.aiplatform-notebook.googleusercontent.com." \
    --zone="aiplatform-notebook-googleusercontent-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="aiplatform-notebook.googleusercontent.com."

gcloud dns record-sets create aiplatform-notebook.googleusercontent.com. \
    --zone="aiplatform-notebook-googleusercontent-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create appengine-dns \
    --description="DNS for appengine.google.com" \
    --dns-name="appengine.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create appengine.google.com. \
    --zone="appengine-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create appspot-dns \
    --description="DNS for *.appspot.com" \
    --dns-name="appspot.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.appspot.com." \
    --zone="appspot-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="appspot.com."

gcloud dns record-sets create appspot.com. \
    --zone="appspot-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create backupdr-cloud-google-dns \
    --description="DNS for *.backupdr.cloud.google.com" \
    --dns-name="backupdr.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.backupdr.cloud.google.com." \
    --zone="backupdr-cloud-google-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="backupdr.cloud.google.com."

gcloud dns record-sets create backupdr.cloud.google.com. \
    --zone="backupdr-cloud-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create backupdr-googleusercontent-dns \
    --description="DNS for *.backupdr.googleusercontent.com" \
    --dns-name="backupdr.googleusercontent.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.backupdr.googleusercontent.com." \
    --zone="backupdr-googleusercontent-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="backupdr.googleusercontent.com."

gcloud dns record-sets create backupdr.googleusercontent.com. \
    --zone="backupdr-googleusercontent-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create cloudfunctions-dns \
    --description="DNS for *.cloudfunctions.net" \
    --dns-name="cloudfunctions.net." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.cloudfunctions.net." \
    --zone="cloudfunctions-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="cloudfunctions.net."

gcloud dns record-sets create cloudfunctions.net. \
    --zone="cloudfunctions-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create cloudproxy-dns \
    --description="DNS for *.cloudproxy.app" \
    --dns-name="cloudproxy.app." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.cloudproxy.app." \
    --zone="cloudproxy-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="cloudproxy.app."

gcloud dns record-sets create cloudproxy.app. \
    --zone="cloudproxy-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create composer-cloud-google-dns \
    --description="DNS for *.composer.cloud.google.com" \
    --dns-name="composer.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.composer.cloud.google.com." \
    --zone="composer-cloud-google-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="composer.cloud.google.com."

gcloud dns record-sets create composer.cloud.google.com. \
    --zone="composer-cloud-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create composer-googleusercontent-dns \
    --description="DNS for *.composer.googleusercontent.com" \
    --dns-name="composer.googleusercontent.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.composer.googleusercontent.com." \
    --zone="composer-googleusercontent-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="composer.googleusercontent.com."

gcloud dns record-sets create composer.googleusercontent.com. \
    --zone="composer-googleusercontent-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create datafusion-cloud-google-dns \
    --description="DNS for *.datafusion.cloud.google.com" \
    --dns-name="datafusion.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.datafusion.cloud.google.com." \
    --zone="datafusion-cloud-google-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="datafusion.cloud.google.com."

gcloud dns record-sets create datafusion.cloud.google.com. \
    --zone="datafusion-cloud-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create datafusion-googleusercontent-dns \
    --description="DNS for *.datafusion.googleusercontent.com" \
    --dns-name="datafusion.googleusercontent.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.datafusion.googleusercontent.com." \
    --zone="datafusion-googleusercontent-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="datafusion.googleusercontent.com."

gcloud dns record-sets create datafusion.googleusercontent.com. \
    --zone="datafusion-googleusercontent-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"


gcloud dns managed-zones create dataproc-cloud-google-dns \
    --description="DNS for *.dataproc.cloud.google.com" \
    --dns-name="dataproc.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.dataproc.cloud.google.com." \
    --zone="dataproc-cloud-google-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="dataproc.cloud.google.com."

gcloud dns record-sets create dataproc.cloud.google.com. \
    --zone="dataproc-cloud-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create dataproc-googleusercontent-dns \
    --description="DNS for *.dataproc.googleusercontent.com" \
    --dns-name="dataproc.googleusercontent.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.dataproc.googleusercontent.com." \
    --zone="dataproc-googleusercontent-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="dataproc.googleusercontent.com."

gcloud dns record-sets create dataproc.googleusercontent.com. \
    --zone="dataproc-googleusercontent-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create dl-google-dns \
    --description="DNS for dl.google.com" \
    --dns-name="dl.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create dl.google.com. \
    --zone="dl-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create gcr-dns \
    --description="DNS for *.gcr.io" \
    --dns-name="gcr.io." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.gcr.io." \
    --zone="gcr-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="gcr.io."

gcloud dns record-sets create gcr.io. \
    --zone="gcr-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create googleapis-dns \
    --description="DNS for *.googleapis.com" \
    --dns-name="googleapis.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.googleapis.com." \
    --zone="googleapis-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="googleapis.com."

gcloud dns record-sets create googleapis.com. \
    --zone="googleapis-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create gke-goog-dns \
    --description="DNS for *.gke.goog" \
    --dns-name="gke.goog." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.gke.goog." \
    --zone="gke-goog-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="gke.goog."

gcloud dns record-sets create gke.goog. \
    --zone="gke-goog-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create gstatic-dns \
    --description="DNS for *.gstatic.com" \
    --dns-name="gstatic.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.gstatic.com." \
    --zone="gstatic-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="gstatic.com."

gcloud dns record-sets create gstatic.com. \
    --zone="gstatic-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create kernels-googleusercontent-dns \
    --description="DNS for *.kernels.googleusercontent.com" \
    --dns-name="kernels.googleusercontent.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.kernels.googleusercontent.com." \
    --zone="kernels-googleusercontent-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="kernels.googleusercontent.com."

gcloud dns record-sets create kernels.googleusercontent.com. \
    --zone="kernels-googleusercontent-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create ltsapis-goog-dns \
    --description="DNS for *.ltsapis.goog" \
    --dns-name="ltsapis.goog." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.ltsapis.goog." \
    --zone="ltsapis-goog-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="ltsapis.goog."

gcloud dns record-sets create ltsapis.goog. \
    --zone="ltsapis-goog-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create notebooks-cloud-google-dns \
    --description="DNS for *.notebooks.cloud.google.com" \
    --dns-name="notebooks.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.notebooks.cloud.google.com." \
    --zone="notebooks-cloud-google-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="notebooks.cloud.google.com."

gcloud dns record-sets create notebooks.cloud.google.com. \
    --zone="notebooks-cloud-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create packages-cloud-google-dns \
    --description="DNS for packages.cloud.google.com" \
    --dns-name="packages.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create packages.cloud.google.com. \
    --zone="packages-cloud-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create pkg-dev-dns \
    --description="DNS for *.pkg.dev" \
    --dns-name="pkg.dev." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.pkg.dev." \
    --zone="pkg-dev-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="pkg.dev."

gcloud dns record-sets create pkg.dev. \
    --zone="pkg-dev-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create pki-goog-dns \
    --description="DNS for *.pki.goog" \
    --dns-name="pki.goog." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.pki.goog." \
    --zone="pki-goog-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="pki.goog."

gcloud dns record-sets create pki.goog. \
    --zone="pki-goog-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create run-app-dns \
    --description="DNS for *.run.app" \
    --dns-name="run.app." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create "*.run.app." \
    --zone="run-app-dns" \
    --type="CNAME" \
    --ttl="300" \
    --rrdatas="run.app."

gcloud dns record-sets create run.app. \
    --zone="run-app-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create source-developers-google-dns \
    --description="DNS for source.developers.google.com" \
    --dns-name="source.developers.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create source.developers.google.com. \
    --zone="source-developers-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"

gcloud dns managed-zones create storage-cloud-google-dns \
    --description="DNS for storage.cloud.google.com" \
    --dns-name="storage.cloud.google.com." \
    --visibility="private" \
    --networks="dns-test1"

gcloud dns record-sets create storage.cloud.google.com. \
    --zone="storage-cloud-google-dns" \
    --type="A" \
    --ttl="300" \
    --rrdatas="199.36.153.8,199.36.153.9,199.36.153.10,199.36.153.11"