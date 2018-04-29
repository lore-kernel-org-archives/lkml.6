Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525024391; cv=none;
        d=google.com; s=arc-20160816;
        b=iLWrq0f12mhk0N1DCKe0XSlOWoZgS9ZCuJLebJF2s03DBrqC8j5Dxd++l/ddDDTN+s
         BrMJWCU3jw2o53+HusHDprlwERw0K7OLu1LbV89WBETihbbXiA46D1vLVrytdxJovEwl
         aoB3L3Nldov0XIejK5X7kC4E1jWh0nbSH6YMeFI01C/NReSZL3Y2kPxWRG41XjsNV2t+
         9gbCV8OaIr3E8Z+QvYUvhed3NOuHPRssOKIdbpI1C5+My1uh/jJW4T8zSqLnypzwd0mk
         DqUSvY6mX9jPwPZ9KrYmNR420PxcRWDVebAzcV5WzlfhYwL0afLiDTjOdlNz7Q1ijfkn
         eD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=+bND22sCQ/vpNH01oprZNR+XQD7f9xV8l+l44kAlLfE=;
        b=crkeQwCcfWuHvQQI49LNwchApwe9wH1Cj8DuB+NEMgaMVyd+R5Idm2bn8y3EDYgQfp
         W4MyOhJ01aRbe8/CKsCdomZY6g/25y04Z+teQ/1GbucTaY79DzB/UUqCC3lCjT8foOcE
         Ebbkr46cgMLQQhjOrifBUObL4IVDTZ7td4DeiqAYeijkA1IKaV8gw7SfInvuFpdjfHr9
         7BCOGWiQkHQfYFs2yDdOqSmfc/smHSdLAc39nVwWkTnRIVVvabqugNV3cynVMkvqfOjb
         KoWUqm7UKNtj8ITCZyIx3r/QXuxAecl0NhS3Nxyc91kvKov0qenqE7mG3xewXK4ru7v9
         jhLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gID593ah;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gID593ah;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrfx1ob12tPTWJvpPD0YjWBpy9bCdc4wmP2y8sF6hYnpyGKmw9UJQBxPKrao1y7IZ3Xb/dA6A==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-fbdev@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] staging: sm750fb: add drm development branch details
Date: Sun, 29 Apr 2018 18:53:07 +0100
Message-Id: <1525024387-8678-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599103976508270251?=
X-GMAIL-MSGID: =?utf-8?q?1599103976508270251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sm750 driver in staging has no future as new framebuffer driver
will not be added to fbdev anymore. A drm driver is being prepared, and
the details added to the TODO file. This sm750fb driver will be removed
as soon as the drm driver is ready. Also, remove my old email.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/staging/sm750fb/TODO | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
index f710ab1..aeb2df3 100644
--- a/drivers/staging/sm750fb/TODO
+++ b/drivers/staging/sm750fb/TODO
@@ -9,8 +9,11 @@ TODO:
 - must be ported to the atomic kms framework in the drm subsystem (which will
   give you a basic fbdev driver for free)
 
+Note:
+- This driver will be removed from staging after the drm driver is ready
+- The drm driver is getting ready at https://gitlab.com/sudipm/sm750/tree/sm750
+
 Please send any patches to
 	Greg Kroah-Hartman <greg@kroah.com>
 	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 	Teddy Wang <teddy.wang@siliconmotion.com>
-	Sudip Mukherjee <sudip@vectorindia.org>
-- 
1.9.1
