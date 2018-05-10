Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZqfFNMBqqNtKtdxdZooUVbyUjrWJi9L/drf6rHhoJa0tzPgN5ixwn0QfhxKh8Zwv/Zn+K9B
ARC-Seal: i=1; a=rsa-sha256; t=1525982953; cv=none;
        d=google.com; s=arc-20160816;
        b=wFECCM1cDPANwQCGUTpSZ2CuDZsdn3lnfhfmxfT22ByUGKJL0HPMr8yUsns23dOn51
         AXlY6FuDO5kEag0FzNsxL1G4K421qduIe8roMOjI7yOCV2uCTb8D0s3C0TeaBDLI3h+f
         cXS/UwaqEz3H7nnI49YmluXHwghXKbZSak8+Ey+1LUOAoBBrWFeqvtQ41cAiSe5ek/Pz
         fsoQzvEnRrbxxZ+xJlQ7OaWf+qPBZ7HyxLlSsBQmpo6xIrN3RSPtYPS9D4Nx2puxba10
         DMBd9PHlxrmtUV1rVUUFqTupBOxN/ahWX2mjFBag4+2g3X4U9wL98Wyc4Lj95j6D0tpl
         P5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HUYssJpWJpxyMUFDzxc8btvA3tGjnLJ4MdBswden4YE=;
        b=Z9J89M1/FI63mGbZ+uBGvioDcvGNhaegZh/apBPOzs1P0dHTElwy+1KsYdCjOx01Ah
         T4k4UmSCqCZjBlaLdpT0OUU6UiKmpx/SCAa7ar7lSxBQIpqyhJw7ssn1IyKSF0R2mGgV
         bFALlVQ7vc1l9h6cZ/IHWWkdntMIlngdeCJxFs7XrvNZTebsIRIFybaBzYIXRa4/M36F
         55barpc1zjPR0EBKXzfEiHf+wcU5d1M3cTJMiWlhIjCF7Ybb1Ci3ehT1mzAzrXNFw///
         tm+yyqqWU7a/KPxTOPrmZ1nOMS8UZlviuc3X+QQ+q/M1H5kisFE9VY8XKjWKLPgXKEMa
         hikg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HidKEe+n;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HidKEe+n;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 12/14] Documentation: fix few typos and clarifications for the firmware loader
Date: Thu, 10 May 2018 13:08:48 -0700
Message-Id: <20180510200850.5958-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109099932794138?=
X-GMAIL-MSGID: =?utf-8?q?1600109099932794138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a few typos, and clarify a few sentences.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/driver-api/firmware/fallback-mechanisms.rst | 5 +++--
 Documentation/driver-api/firmware/firmware_cache.rst      | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index f353783ae0be..a39323ef7d29 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -83,7 +83,7 @@ and a file upload firmware into:
   * /sys/$DEVPATH/data
 
 To upload firmware you will echo 1 onto the loading file to indicate
-you are loading firmware. You then cat the firmware into the data file,
+you are loading firmware. You then write the firmware into the data file,
 and you notify the kernel the firmware is ready by echo'ing 0 onto
 the loading file.
 
@@ -136,7 +136,8 @@ by kobject uevents. This is specially exacerbated due to the fact that most
 distributions today disable CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
 
 Refer to do_firmware_uevent() for details of the kobject event variables
-setup. Variables passwdd with a kobject add event:
+setup. The variables currently passed to userspace with a "kobject add"
+event are:
 
 * FIRMWARE=firmware name
 * TIMEOUT=timeout value
diff --git a/Documentation/driver-api/firmware/firmware_cache.rst b/Documentation/driver-api/firmware/firmware_cache.rst
index 2210e5bfb332..c2e69d9c6bf1 100644
--- a/Documentation/driver-api/firmware/firmware_cache.rst
+++ b/Documentation/driver-api/firmware/firmware_cache.rst
@@ -29,8 +29,8 @@ Some implementation details about the firmware cache setup:
 * If an asynchronous call is used the firmware cache is only set up for a
   device if if the second argument (uevent) to request_firmware_nowait() is
   true. When uevent is true it requests that a kobject uevent be sent to
-  userspace for the firmware request. For details refer to the Fackback
-  mechanism documented below.
+  userspace for the firmware request through the sysfs fallback mechanism
+  if the firmware file is not found.
 
 * If the firmware cache is determined to be needed as per the above two
   criteria the firmware cache is setup by adding a devres entry for the
-- 
2.17.0
