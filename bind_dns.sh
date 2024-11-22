#!/bin/bash

# 創建 zones 目錄（如果尚未存在）
sudo mkdir -p /etc/bind/zones

# 輸出腳本的路徑
SCRIPT_PATH="/etc/bind/create-zone-files-with-cname.sh"

# 使用 EOF 寫入腳本內容到指定的腳本檔案
sudo tee $SCRIPT_PATH > /dev/null << 'EOF'
#!/bin/bash

# 確保 /etc/bind/zones 目錄存在
sudo mkdir -p /etc/bind/zones

# 基本的 SOA 和 NS 記錄
BASE_CONTENT='$TTL 21600

@   IN  SOA ns-gcp-private.googledomains.com. cloud-dns-hostmaster.google.com. (
    1          ; Serial
    21600      ; Refresh (6 hours)
    3600       ; Retry (1 hour)
    259200     ; Expire (3 days)
    300        ; Minimum TTL (5 minutes)
)

@   IN  NS  ns-gcp-private.googledomains.com.'
  
# 需要 CNAME 記錄的域名列表
CNAME_DOMAINS=(
    "aiplatform-notebook.cloud.google.com"
    "aiplatform-notebook.googleusercontent.com"
    "appspot.com"
    "backupdr.cloud.google.com"
    "backupdr.googleusercontent.com"
    "cloudfunctions.net"
    "cloudproxy.app"
    "composer.cloud.google.com"
    "composer.googleusercontent.com"
    "datafusion.cloud.google.com"
    "datafusion.googleusercontent.com"
    "dataproc.cloud.google.com"
    "dataproc.googleusercontent.com"
    "gcr.io"
    "googleapis.com"
    "gke.goog"
    "gstatic.com"
    "kernels.googleusercontent.com"
    "ltsapis.goog"
    "notebooks.cloud.google.com"
    "notebooks.googleusercontent.com"
    "pkg.dev"
    "pki.goog"
    "run.app"
)

# 域名檔案列表
FILES=(
    "accounts.google.com.db"
    "aiplatform-notebook.cloud.google.com.db"
    "aiplatform-notebook.googleusercontent.com.db"
    "appengine.google.com.db"
    "appspot.com.db"
    "backupdr.cloud.google.com.db"
    "backupdr.googleusercontent.com.db"
    "cloudfunctions.net.db"
    "cloudproxy.app.db"
    "composer.cloud.google.com.db"
    "composer.googleusercontent.com.db"
    "datafusion.cloud.google.com.db"
    "datafusion.googleusercontent.com.db"
    "dataproc.cloud.google.com.db"
    "dataproc.googleusercontent.com.db"
    "dl.google.com.db"
    "gcr.io.db"
    "googleapis.com.db"
    "gke.goog.db"
    "gstatic.com.db"
    "kernels.googleusercontent.com.db"
    "ltsapis.goog.db"
    "notebooks.cloud.google.com.db"
    "packages.cloud.google.com.db"
    "pkg.dev.db"
    "pki.goog.db"
    "run.app.db"
    "source.developers.google.com.db"
    "storage.cloud.google.com.db"
)

# 創建檔案並寫入內容
for FILE in "${FILES[@]}"; do
    sudo touch "/etc/bind/zones/$FILE"

    DOMAIN=$(basename "$FILE" .db)

    # 生成 A 記錄
    A_RECORDS="
$DOMAIN.  IN   A    199.36.153.8;
$DOMAIN.  IN   A    199.36.153.9;
$DOMAIN.  IN   A    199.36.153.10;
$DOMAIN.  IN   A    199.36.153.11;"

    # 初始化內容
    CONTENT="$BASE_CONTENT

$A_RECORDS"

    # 如果是需要 CNAME 的域名，加入 CNAME 記錄
    if [[ " ${CNAME_DOMAINS[@]} " =~ " ${DOMAIN} " ]]; then
        CNAME_RECORD="*.$DOMAIN.  IN   CNAME $DOMAIN."
        CONTENT="$CONTENT
$CNAME_RECORD"
    fi

    # 將內容寫入檔案
    echo "$CONTENT" | sudo tee "/etc/bind/zones/$FILE" > /dev/null
done

echo "所有檔案已成功創建並寫入內容。"
EOF

# 給新創建的腳本加上執行權限
sudo chmod +x $SCRIPT_PATH

# 執行腳本
sudo $SCRIPT_PATH

# 重新啟動 bind9 服務
sudo systemctl restart bind9

echo "操作完成，檔案已創建並寫入，bind9 服務已重新啟動。"
