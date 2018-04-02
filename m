Return-Path: <martink@posteo.de>
X-Google-Smtp-Source: AIpwx4+2C2Wd472+q4jKuVFOJwjjZFEspI9p8LDfI96q36gGsY9Goa05q0Wh5T/Y/850x3ZVFGyh
ARC-Seal: i=1; a=rsa-sha256; t=1522673787; cv=none;
        d=google.com; s=arc-20160816;
        b=rUK3L+c+INP5ekrxt0XSP5evskHfyBcWIgKOC0D4QrIYhuiQRP/DXM1oglBCEdrIOA
         tjQVuqDsj8R3ueaYCDobH9o8eGyZfOa4ByvuyHDVR952tSIFHDg6Y9FKohIJsl2+H8Xx
         aNRXgebjaIwf/tM4l/7Pdy0WLIJZymk34gO+GqB9rypqxrBRVK5k+/Z9+G4rb8UlaU7b
         lwwBZZ2rj6e/jbkCPmL+I4hL7t0+GSTI4ZALhrhhB+RClxjk1jYyzcIQ5KNK5+5DpKNE
         trVgqeyezHkMyw11yLQXt28V62V7K6d/k8yLhYm4dYDRM2pJrn373tNLYOMvv/6pOzyj
         Ln3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=8PGO6llNut7Vj9zBBIcDooAcrs2HC+nHeeFLqoSiJ9s=;
        b=S3So9M9+lCkK4aSBT3471IamFu38BiPniQbbHo2XU28TFnBbMig9Sq9/jywlGiYt45
         Se+u0B02rjGYNZBytqigLu/AM1DryeA+3/U3SxL2Es+Tk3EEvYn2/wBMh9M2SfCrBdA8
         gQP84ityZ10GkPS4av41nnD1WQpWY2/cinoouBjHwOxW7ZXk5qyZ2YJGw6UEuoyZUC0w
         9/JPA1wUt4L7crarRAfGG5ARabFOstPlOTJ0BzzBz8quszxGHXLjodBlPoYzIglOYUcM
         F6UzV1VAla8F7F+zpZegh1N16X2HaCgjXKpf+j+1ViU0RpVGIAUJhS5EMd3ZGUWPq+oB
         BELA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@posteo.de header.s=2017 header.b=h+BrfPCJ;
       spf=pass (google.com: domain of martink@posteo.de designates 185.67.36.65 as permitted sender) smtp.mailfrom=martink@posteo.de;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=posteo.de
Authentication-Results: mx.google.com;
       dkim=pass header.i=@posteo.de header.s=2017 header.b=h+BrfPCJ;
       spf=pass (google.com: domain of martink@posteo.de designates 185.67.36.65 as permitted sender) smtp.mailfrom=martink@posteo.de;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=posteo.de
From: Martin Kepplinger <martink@posteo.de>
To: corbet@lwn.net,
	dmitry.torokhov@gmail.com
Cc: gregkh@linuxfoundation.org,
	logang@deltatee.com,
	stefanha@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/2] Input: mk712: update documentation web link
Date: Mon,  2 Apr 2018 14:55:50 +0200
Message-Id: <20180402125551.13641-1-martink@posteo.de>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596639189437434101?=
X-GMAIL-MSGID: =?utf-8?q?1596639189437434101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

At the mentioned address there's nothing found. By searching information
on the controller chip still can be found, so update the link to the
resulting page.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/touchscreen/mk712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mk712.c b/drivers/input/touchscreen/mk712.c
index bd5352824f77..c179060525ae 100644
--- a/drivers/input/touchscreen/mk712.c
+++ b/drivers/input/touchscreen/mk712.c
@@ -17,7 +17,7 @@
  * found in Gateway AOL Connected Touchpad computers.
  *
  * Documentation for ICS MK712 can be found at:
- *	http://www.idt.com/products/getDoc.cfm?docID=18713923
+ *	https://www.idt.com/general-parts/mk712-touch-screen-controller
  */
 
 /*
-- 
2.16.2
