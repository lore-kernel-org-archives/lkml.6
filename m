Return-Path: <martink@posteo.de>
X-Google-Smtp-Source: AIpwx48CTHHaSUE9yH34vI8YzE38etvDPNJxQ3Wow7u9FRA5+Ij30iJF8UlL2AZHG/ZjbK9ATz7g
ARC-Seal: i=1; a=rsa-sha256; t=1522673787; cv=none;
        d=google.com; s=arc-20160816;
        b=Dq3+YuZkjDPXp8s3VMOOAXjTKNoinFUa8IxzoDslnm6K5qIjJCtzLzEuGOrcZ2iYiV
         o7EpBizeGxJ8NNK1Cwn0QKhn5Nw6gyqzb64qyOnXfRJi7ux3ahuXZ1fRiUU2t4n5vLbv
         g7Jeu4RgwmCiA8zTliBVjffgWBWrgJRneq9Bhqfm+6ANRdLVLvkPg+8uq6Ag7FQkqLCw
         z//EyG8Ur1F16bXL7hCVcv3MwR3tT5p2vqfJp+i35K1w6xgFTYHpgg0K9d2S1ljJxIxV
         s2Gijy5cUzPlAi/bI/HWnrp0fLvDq1HZ2WvK0Ms197FbYwEAZ70TfFIMPlLivYzDM/d0
         Y3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=i0/hd/o8HrakCCF45aaAIxIp9LAO1nYUYbo+Ghd/q4M=;
        b=vK2F7HucH6KnNra/6i3ahKuvlFaZ5PKUQ49a6GeTdkHlGMWC04Pmh/gTFU21Af6P3S
         lziV0IQ3fuf03wyvJ2oKVlVlDwPfIMrHHDKHjXLkbeXazok1bMJTCAMeQ+B8ufIsUsIA
         0WqFPGpOBRqmI+3Vce2zXKtawF6Qfzx82n3fqbpe9lyoN3oxQ3UeXSBWllMhoDVfjLyx
         i7KgkpG9DdnJO0zP13x3TCNcFQJDnQmrIgZ1xPVjj5lA3r3lF3lCCa61gKHbsxVoErQQ
         3uj52i0WircnFMBGAZ9yz/t6aPTTyRh6veSweYaAdWsLRe+rDLNlrfNDweW9IpHtSSmH
         iD3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@posteo.de header.s=2017 header.b=Vmlj+kHL;
       spf=pass (google.com: domain of martink@posteo.de designates 185.67.36.65 as permitted sender) smtp.mailfrom=martink@posteo.de;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=posteo.de
Authentication-Results: mx.google.com;
       dkim=pass header.i=@posteo.de header.s=2017 header.b=Vmlj+kHL;
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
Subject: [PATCH 2/2] Documentation: devices.txt: remove the mk712 touchscreen device from the list
Date: Mon,  2 Apr 2018 14:55:51 +0200
Message-Id: <20180402125551.13641-2-martink@posteo.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180402125551.13641-1-martink@posteo.de>
References: <20180402125551.13641-1-martink@posteo.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596639188800698682?=
X-GMAIL-MSGID: =?utf-8?q?1596639188800698682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The input/touchscreen/mk712.c driver has been rewritten for the common
input event system. in 2005. There shouldn't a special device node be
created anymore.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

Please review this by looking at the driver too. Thanks,

                    martin



 Documentation/admin-guide/devices.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 4ec843123cc3..fb39bbf0789a 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -259,7 +259,6 @@
 		 11 = /dev/vrtpanel	Vr41xx embedded touch panel
 		 13 = /dev/vpcmouse	Connectix Virtual PC Mouse
 		 14 = /dev/touchscreen/ucb1x00  UCB 1x00 touchscreen
-		 15 = /dev/touchscreen/mk712	MK712 touchscreen
 		128 = /dev/beep		Fancy beep device
 		129 =
 		130 = /dev/watchdog	Watchdog timer port
-- 
2.16.2
