Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527154974-2-5094753296321091221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-asciiro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527154973; b=Y0S6sNgmwHxqvHciD5qB9HAoO07RnP76LrbZyIhmvEEe6kFo4s
    zuzdgCVRE6QpY+wbEr4Cy3quWx0Cbb5OJxvJM9hkhAVG/Gr9hh22UqJ9oyT/Ym/i
    m2UEeM4AjvFWZUNANtj24CWJSNtk29un0RnZxQWfQ4ux2dsGwInMKKCu2PKZDTyr
    E5b5yhWY/XwBmFkvtHmAz5a+7XL4HNejdZBN5+YjK6xINPupbaMevi2E/21d7bgc
    535S43ZP7qG+w+SOYyGN6ENH9zro+xfk9Q1JEqfxUI8IG43MkEM1b+t+H3Wv6IoD
    k4QMl70++3a+ql4+Ia2BeOvkGJiRss29Qj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154973; bh=gdGbqOjdN5CTB4kcsOXlW1FEQTyOPc
    HH3RP90sLyb0o=; b=ThVmsBmKOYZWPzI9hLvC90SSO81eSEwmbBqv7Vga0JuGFN
    Zmf+s2JHuXMCJD2Hwa2SL3/9BIprF6g+E+ZU8PVYuOJrwtUxvV9KvQQeOYWrUKgE
    U37xFMXFYRln1R2NZ3BuckpoBy8ywETEpzXLjisYKumhLQplAi8XM2ditNkm8Uoz
    A2qDstWfflT6XzpxHBuj0moIBZIwql2t1Hlya36dy3MWy9cgeeqCmPR167rJdrMj
    0DCJJIUzUxcGKnOeQti6Mc1BIFlOcqYGdB6vslovOrydzm8B3CFDtYMs3SHttY2u
    7XFujlxQLwuR5pcpWECuk4NKagkM6+gKVR2SyiBw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ndyaUcVn x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ndyaUcVn x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDY8ZVtmug1laXfUUqlFXZPny+Ud5bN8aWZ9PAJCqagSd/UlfczH7rVsXk1j7WiqYNKMm729bObRVfZ7U83iTYkuBhf1//UruH0om2XarIweLAlLZFUS
    /2cBviH44goMH8ruFRT7GwWpTo6Li7DOtDgnzhAyTZPVmQ8adK0G2QCNjnGr/2ryqW3JpO//5Jq9vub+X0XPVsnNnAf5qB23o7jW3KOEaIXFDirCW4lwcEx/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=HbzxQ8OLHbVZuys3Ot8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966392AbeEXJmt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966382AbeEXJmp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 3.18 25/45] usbip: usbip_host: run rebind from exit when module is removed
Date: Thu, 24 May 2018 11:38:33 +0200
Message-Id: <20180524093123.846686858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 7510df3f29d44685bab7b1918b61a8ccd57126a9 upstream.

After removing usbip_host module, devices it releases are left without
a driver. For example, when a keyboard or a mass storage device are
bound to usbip_host when it is removed, these devices are no longer
bound to any driver.

Fix it to run device_attach() from the module exit routine to restore
the devices to their original drivers. This includes cleanup changes
and moving device_attach() code to a common routine to be called from
rebind_store() and usbip_host_exit().

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c  |    6 ----
 drivers/usb/usbip/stub_main.c |   60 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 14 deletions(-)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -459,12 +459,8 @@ static void stub_disconnect(struct usb_d
 	busid_priv->sdev = NULL;
 	stub_device_free(sdev);
 
-	if (busid_priv->status == STUB_BUSID_ALLOC) {
+	if (busid_priv->status == STUB_BUSID_ALLOC)
 		busid_priv->status = STUB_BUSID_ADDED;
-	} else {
-		busid_priv->status = STUB_BUSID_OTHER;
-		del_match_busid((char *)udev_busid);
-	}
 }
 
 #ifdef CONFIG_PM
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -28,6 +28,7 @@
 #define DRIVER_DESC "USB/IP Host Driver"
 
 struct kmem_cache *stub_priv_cache;
+
 /*
  * busid_tables defines matching busids that usbip can grab. A user can change
  * dynamically what device is locally used and what device is exported to a
@@ -184,6 +185,51 @@ static ssize_t store_match_busid(struct
 static DRIVER_ATTR(match_busid, S_IRUSR | S_IWUSR, show_match_busid,
 		   store_match_busid);
 
+static int do_rebind(char *busid, struct bus_id_priv *busid_priv)
+{
+	int ret;
+
+	/* device_attach() callers should hold parent lock for USB */
+	if (busid_priv->udev->dev.parent)
+		device_lock(busid_priv->udev->dev.parent);
+	ret = device_attach(&busid_priv->udev->dev);
+	if (busid_priv->udev->dev.parent)
+		device_unlock(busid_priv->udev->dev.parent);
+	if (ret < 0) {
+		dev_err(&busid_priv->udev->dev, "rebind failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void stub_device_rebind(void)
+{
+#if IS_MODULE(CONFIG_USBIP_HOST)
+	struct bus_id_priv *busid_priv;
+	int i;
+
+	/* update status to STUB_BUSID_OTHER so probe ignores the device */
+	spin_lock(&busid_table_lock);
+	for (i = 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv = &(busid_table[i]);
+			busid_priv->status = STUB_BUSID_OTHER;
+		}
+	}
+	spin_unlock(&busid_table_lock);
+
+	/* now run rebind */
+	for (i = 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv = &(busid_table[i]);
+			do_rebind(busid_table[i].name, busid_priv);
+		}
+	}
+#endif
+}
+
 static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 				 size_t count)
 {
@@ -204,16 +250,9 @@ static ssize_t rebind_store(struct devic
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
 
-	/* device_attach() callers should hold parent lock for USB */
-	if (bid->udev->dev.parent)
-		device_lock(bid->udev->dev.parent);
-	ret = device_attach(&bid->udev->dev);
-	if (bid->udev->dev.parent)
-		device_unlock(bid->udev->dev.parent);
-	if (ret < 0) {
-		dev_err(&bid->udev->dev, "rebind failed\n");
+	ret = do_rebind((char *) buf, bid);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* delete device from busid_table */
 	del_match_busid((char *) buf);
@@ -339,6 +378,9 @@ static void __exit usbip_host_exit(void)
 	 */
 	usb_deregister_device_driver(&stub_driver);
 
+	/* initiate scan to attach devices */
+	stub_device_rebind();
+
 	kmem_cache_destroy(stub_priv_cache);
 }
 
