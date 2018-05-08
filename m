Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZruMnUuYhzlj6jqevITgAygTO1zabU7S0w5ySeTOJ0DLhbXSGPInEEvqyY2gO4p1hz84oW4
ARC-Seal: i=1; a=rsa-sha256; t=1525803190; cv=none;
        d=google.com; s=arc-20160816;
        b=RAUmx+fvaYbaPd+zqb+3gLBELmtozdYMgnkXo96NfYupFN8AIgssqDy1h5vZFPumHz
         LrVW6REz9kJOetg5/2WXPmLi5zCqYUOwySZW8ma1onJo//+HpWe/mNo6e9W8tIuw9ir/
         BY+yKHsRjXK2gtiJetJefGlQxOoNL2VX/alqijnMJx8wWzMCKnrff5LaPBh87Bc2nYQ5
         c/7t7SXSxb+XbH0SPUqiOaOhIvEK3c7DU1wmFlVzL4LkscC/xU1qEDz2oL4Uio/z+6Uc
         J0B0sLa3l9r88alTFomB26c26+jv1uiAjCjFx5UFeJ9Yyzyh8oQ2n9YQPqj/XbvwBF8q
         JIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=BxrQTlXE/rbdfk9UYBocWWQBdSqLVLIhbWDnrD/4L3o=;
        b=aSdUmhbvd3LiY0mL/htQ9P9xKQTkdN9lQJUQ/7xLRF4Dsy8h+nG5HQ3kebfR1YcxjB
         skYWngvoYQa9AGPWHbbepYqTNJE9GZywABd68j8BTJJRKI6VoPHPe9eXTY3fMktkJp4b
         45sX+xp8e+ydhBpGoybGiyfO6MMGSRqvzLOPugJ+7IKWm2ikK3GypBYHe6IhIdB6m120
         f/KC930p3dL75gB+RVk9RUUDaP7YWO1Cu5zdINEhMJc6RJYJOdIy/sNJUY1jA31ZdiLC
         XQKxD/n5OZmvcdnOo0SKqqzz8BP3uWd5ecjh9/XVVj/PrzO8WD1jARQizWPN+sCOS30V
         Rmvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GlYxvr34;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GlYxvr34;
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
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 11/13] Documentation: fix few typos and clarifications for the firmware loader
Date: Tue,  8 May 2018 11:12:45 -0700
Message-Id: <20180508181247.19431-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920605966512508?=
X-GMAIL-MSGID: =?utf-8?q?1599920605966512508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a few typos, and clarify a few sentences.

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
