Return-Path: <yashomer0007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518806565; cv=none;
        d=google.com; s=arc-20160816;
        b=V3Bn622AoL4YgRt7B+PS5YdgS91OglDZZBmCmyrJluojSjXcqA63mPYo+Xc8h7lAn4
         0jEbBD0ak3YLfXpxfQG0t7UN6UpqgrqeiUYwdAwykMbXy+BHQzzhTFY+ct0E/jKNyqxW
         vmZ12T5OIK4GJZn3WvZI56iNHFL6+QRweqOE3JF6+Zemj7cKQUP5/cl2eWIhmsh5K37w
         I+hi1QjajHx0EtmPSxA4oOI1PIrorDITgVFiIGI4s2gNACsEHIPvWjWBxbgrRkxCUuf2
         Mg3rSuMc26HK77H0xG+N4iAMijgb49yrUBznbqJ0LZzuPPJsJmF10YywXX0qJjBHzoFh
         RFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xzUXPoTWNriet4+q4y7jS0sUp6qD3XQZHYgnLl7ERiM=;
        b=qM85nEg+ZVbwNx67XPp6pvXxexxpLfVslKZAUeUqB4jeMjKJP6ejV0lOchy8UXIhjZ
         GWSubanYmw7XYB/fmHAaV0ViaL3kSy56pUj7cU79jD0+yVkyIb6dAW5Ki7ZMbEHqrkqo
         bWiiSb7yvy9EFIW2dSinCzWlaKjSL1ab4m84rHfINZpuVuWMPKfgLZ/4jv0Z8/53lLkw
         QmBoQ+MvldtY5+Q6wS6W8eyOhW7q/r+lR6OyGrYPyVDypC/zgCvy4I23eFziy2/8kAYW
         HVFqgzxksEWsslYSX5tvE5sCkn5v2i2ufRaNXRexAD6cP1CbhscC6PaombWGJAbKbOY6
         waOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hMmMkCG1;
       spf=pass (google.com: domain of yashomer0007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yashomer0007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hMmMkCG1;
       spf=pass (google.com: domain of yashomer0007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yashomer0007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225q6Nn90vucUei7Gzeb51i1Oc/haF0kShMUqpyRpkyjpdC4ea8LXjVsz6HdywQn2yr8vnamig==
From: Yash Omer <yashomer0007@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Larry.Finger@lwfinger.net,
	driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: xgifb: fix lines should not end with open parenthesis in vb_setmode.c
Date: Sat, 17 Feb 2018 00:12:36 +0530
Message-Id: <20180216184236.10963-1-yashomer0007@gmail.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592584112560952966?=
X-GMAIL-MSGID: =?utf-8?q?1592584112560952966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes up line should not end with open parenthesis found by checkpatch.pl script.

Signed-off-by: Yash Omer <yashomer0007@gmail.com>
---
 drivers/staging/xgifb/vb_setmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/xgifb/vb_setmode.c b/drivers/staging/xgifb/vb_setmode.c
index 1fa0dc66406e..1d6ac724fd61 100644
--- a/drivers/staging/xgifb/vb_setmode.c
+++ b/drivers/staging/xgifb/vb_setmode.c
@@ -1228,8 +1228,8 @@ static void const *XGI_GetLcdPtr(struct XGI330_LCDDataTablStruct const *table,
 	return table[i].DATAPTR;
 }
 
-static struct SiS_TVData const *XGI_GetTVPtr(
-	unsigned short ModeIdIndex,
+static struct SiS_TVData const *XGI_GetTVPtr
+(unsigned short ModeIdIndex,
 	unsigned short RefreshRateTableIndex,
 	struct vb_device_info *pVBInfo)
 {
-- 
2.14.3
