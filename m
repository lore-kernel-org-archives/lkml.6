Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979200; cv=none;
        d=google.com; s=arc-20160816;
        b=boWBVchc2MZyIBszGXZu7bPsnqoy1C1iLnHSvK0y9F3cMAPykop2kvoxmu/M0xYzYo
         LbzqbYSUkc4WStd1lvujvcCcYiqrB89jtdfYo2kfHEthD3NI72vhO4vG9k/aBxESyHXi
         9XcbBScLraMEqTszZ+z/pyoIDYlJ/5YHDfA4OuLr7AwFisyLAnRyu+YOX9YDQL5b6EXv
         Kn75EDgBE8lgsGCRGXzz1tXYucRZSYnxEdqlcu4l0A6GIaJ3FOIJ+PnkXsnjhKp2PTf6
         +hFDvbud2lMqBs/MAd6sf/GNg/6lkKmdbtXA6zx7W6B0+i0QRy3A4tkbARh5SFVgJIp2
         meww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=u/sDUCrQLQOgyVq6L7Ulu0kCtuLbvxmaQJ/1Nsyl/cw=;
        b=C6fNqWHgdDeEB+IanhFSI0w+/A4fxi/K/scOeqZ2ZfpPJBk7PwPOpE8SxN/XPrhTSI
         PztAm8WzVrNFl0FNt6A1S+ZKrPNzH2/ORFjJXvObcXH1eyDKryBs8seeh32aZuA3Mj0w
         oy1kK9hMMzfGR13E0MdFG0b+ncV7nGLOvKwJgsscUTsMm7X3fD338dZPRfMySQ+j6h8E
         OT0aFSCwYaav65Agi3LGyk9muVmA0Bj3GF0SZpYi0fPbQX7WovfudkKux9rlPSQlw41A
         fdjWp7k03qLJSFwmCXezDr1ad+i/bpxq+GJUukhiKbvE2gdiKWwULis32eWpQp/gPzeX
         hHfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nqYrCGhx;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nqYrCGhx;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/u1hQjn5WWxWq2wcUYO/CP0KPwJTpclYGX0zqJby/vjkoWVxU0va3dYMQEvqgsHutz2/I2gQ==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 4/9] firmware: use () to terminate kernel-doc function names
Date: Tue, 17 Apr 2018 11:33:02 -0400
Message-Id: <20180417153307.3693-5-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008014188968321?=
X-GMAIL-MSGID: =?utf-8?q?1598008014188968321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel-doc spec dictates a function name ends in ().

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_loader/fallback.c |  8 ++++----
 drivers/base/firmware_loader/main.c     | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index ecc49a619298..e75928458489 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -124,7 +124,7 @@ static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
 }
 
 /**
- * firmware_timeout_store - set number of seconds to wait for firmware
+ * firmware_timeout_store() - set number of seconds to wait for firmware
  * @class: device class pointer
  * @attr: device attribute pointer
  * @buf: buffer to scan for timeout value
@@ -238,7 +238,7 @@ static int map_fw_priv_pages(struct fw_priv *fw_priv)
 }
 
 /**
- * firmware_loading_store - set value in the 'loading' control file
+ * firmware_loading_store() - set value in the 'loading' control file
  * @dev: device pointer
  * @attr: device attribute pointer
  * @buf: buffer to scan for loading control value
@@ -430,7 +430,7 @@ static int fw_realloc_pages(struct fw_sysfs *fw_sysfs, int min_size)
 }
 
 /**
- * firmware_data_write - write method for firmware
+ * firmware_data_write() - write method for firmware
  * @filp: open sysfs file
  * @kobj: kobject for the device
  * @bin_attr: bin_attr structure
@@ -536,7 +536,7 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
 }
 
 /**
- * fw_load_sysfs_fallback - load a firmware via the sysfs fallback mechanism
+ * fw_load_sysfs_fallback() - load a firmware via the sysfs fallback mechanism
  * @fw_sysfs: firmware sysfs information for the firmware to load
  * @opt_flags: flags of options, FW_OPT_*
  * @timeout: timeout to wait for the load
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 5baadad3012d..d028cd3257f7 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -597,7 +597,7 @@ _firmware_request(const struct firmware **firmware_p, const char *name,
 }
 
 /**
- * firmware_request: - send firmware request and wait for it
+ * firmware_request() - send firmware request and wait for it
  * @firmware_p: pointer to firmware image
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
@@ -632,7 +632,7 @@ firmware_request(const struct firmware **firmware_p, const char *name,
 EXPORT_SYMBOL(firmware_request);
 
 /**
- * firmware_request_direct: - load firmware directly without usermode helper
+ * firmware_request_direct() - load firmware directly without usermode helper
  * @firmware_p: pointer to firmware image
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
@@ -657,7 +657,7 @@ int firmware_request_direct(const struct firmware **firmware_p,
 EXPORT_SYMBOL_GPL(firmware_request_direct);
 
 /**
- * firmware_request_cache: - cache firmware for suspend so resume can use it
+ * firmware_request_cache() - cache firmware for suspend so resume can use it
  * @name: name of firmware file
  * @device: device for which firmware should be cached for
  *
@@ -681,7 +681,7 @@ int firmware_request_cache(struct device *device, const char *name)
 EXPORT_SYMBOL_GPL(firmware_request_cache);
 
 /**
- * firmware_request_into_buf - load firmware into a previously allocated buffer
+ * firmware_request_into_buf() - load firmware into a previously allocated buffer
  * @firmware_p: pointer to firmware image
  * @name: name of firmware file
  * @device: device for which firmware is being loaded and DMA region allocated
@@ -713,7 +713,7 @@ firmware_request_into_buf(const struct firmware **firmware_p, const char *name,
 EXPORT_SYMBOL(firmware_request_into_buf);
 
 /**
- * firmware_release: - release the resource associated with a firmware image
+ * firmware_release() - release the resource associated with a firmware image
  * @fw: firmware resource to release
  **/
 void firmware_release(const struct firmware *fw)
@@ -755,7 +755,7 @@ static void firmware_request_work_func(struct work_struct *work)
 }
 
 /**
- * firmware_request_nowait - asynchronous version of firmware_request
+ * firmware_request_nowait() - asynchronous version of firmware_request
  * @module: module requesting the firmware
  * @uevent: sends uevent to copy the firmware image if this flag
  *	is non-zero else the firmware copy must be done manually.
@@ -824,7 +824,7 @@ EXPORT_SYMBOL(firmware_request_nowait);
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
 /**
- * cache_firmware - cache one firmware image in kernel memory space
+ * cache_firmware() - cache one firmware image in kernel memory space
  * @fw_name: the firmware image name
  *
  * Cache firmware in kernel memory so that drivers can use it when
@@ -866,7 +866,7 @@ static struct fw_priv *lookup_fw_priv(const char *fw_name)
 }
 
 /**
- * uncache_firmware - remove one cached firmware image
+ * uncache_firmware() - remove one cached firmware image
  * @fw_name: the firmware image name
  *
  * Uncache one firmware image which has been cached successfully
@@ -1042,7 +1042,7 @@ static void __device_uncache_fw_images(void)
 }
 
 /**
- * device_cache_fw_images - cache devices' firmware
+ * device_cache_fw_images() - cache devices' firmware
  *
  * If one device called firmware_request or its nowait version
  * successfully before, the firmware names are recored into the
@@ -1075,7 +1075,7 @@ static void device_cache_fw_images(void)
 }
 
 /**
- * device_uncache_fw_images - uncache devices' firmware
+ * device_uncache_fw_images() - uncache devices' firmware
  *
  * uncache all firmwares which have been cached successfully
  * by device_uncache_fw_images earlier
@@ -1092,7 +1092,7 @@ static void device_uncache_fw_images_work(struct work_struct *work)
 }
 
 /**
- * device_uncache_fw_images_delay - uncache devices firmwares
+ * device_uncache_fw_images_delay() - uncache devices firmwares
  * @delay: number of milliseconds to delay uncache device firmwares
  *
  * uncache all devices's firmwares which has been cached successfully
-- 
2.14.1
