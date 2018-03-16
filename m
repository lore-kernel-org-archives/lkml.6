Return-Path: <pratik.jain0509@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521197319-2-9190842826056173399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.66', Host='mail-pl0-f66.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pratik.jain0509@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521197319; b=Uc1WYVeOKVSyZMZkoQ4xutNyBEhcO/R2L/5RCdqbqrPjtUs
    SyeopiHmtW1ksUohadz5brx3xyrTlSvwPN6Xk75Y34yJ+aHRW982spmu/GUy75g8
    tWUAs9GUh3pU+FyCpudnSRtLiV3XFK3w+XFJ3EGDec45CLNgEv2LFrJJv2ogP7/P
    wU0dB52ORXsND8w1Z25g6xIh0gMa0FnFbEw7uGGk7C01y9n4G4vFLsrKv56sdAX8
    AI0UylVBArhq7M4B/9LKsdqZVsAElrmz9pRvdDUEKnZGw2QXEjNrqm2ZUH8b/mtz
    Vgn4xI9N8SQupKJaFxw/+Ynyc/6OaIzARPY7OOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521197319; bh=17MBA51bDv0
    QylFPMDiWMo/AugOv7Wyfjueg5ySF5NU=; b=VZYqNiA1aexJC1Bb1YurE2MSDBg
    TVOCSHwidJvwtavps3pCnZYnwlQTyfVeMstDjrXnCRJPSBZ5Tn7AdmuEuGTMPDMV
    O+HkCNO1PSDKEdUGp9mCL4IRluL4aHMEd0IOSQfTgh/Y9/71JPcI+D1muPH3d0u/
    QYBrPHDLbx2Q3QCIKllfsGyAabzTtY5INkquZjG0Q61CZkbHbAfMHDEsXWopH/4c
    pUFxt3KrAyxz0VD3ri8AFghVSv/ylte3hdvkTxjCJGc8/xV1nacd9BV0WYwlpjC2
    BzGs0fbgcmB1WVkm3yZ9jlYPt3c9xEfJjT/P+Kq145I4FZZDGYPgKDn8LIQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cqw1R+XS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tEdVAb5V;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cqw1R+XS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tEdVAb5V;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELtrPPBRHee1I2Z3e8fcLWnyktmQRw432Gdw4gGEWJRz46JP5ubsBppsqQSlDD6zxa27AjWWcA==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	abbotti@mev.co.uk,
	Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line derefernce issue
Date: Fri, 16 Mar 2018 16:18:13 +0530
Message-Id: <20180316104813.30848-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316103652.jparuok7dsmvu5xp@mwanda>
References: <20180316103652.jparuok7dsmvu5xp@mwanda>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed coding style issue.

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/ni_atmio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
index b9e9ab548c4b..2b7bfe0dd7f3 100644
--- a/drivers/staging/comedi/drivers/ni_atmio.c
+++ b/drivers/staging/comedi/drivers/ni_atmio.c
@@ -224,10 +224,11 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ni_boards); i++) {
-		isapnp_dev = pnp_find_dev(NULL,
-					  ISAPNP_VENDOR('N', 'I', 'C'),
-					  ISAPNP_FUNCTION(ni_boards[i].
-							  isapnp_id), NULL);
+		isapnp_dev =
+			pnp_find_dev(NULL,
+				     ISAPNP_VENDOR('N', 'I', 'C'),
+				     ISAPNP_FUNCTION(ni_boards[i].isapnp_id),
+				     NULL);
 
 		if (!isapnp_dev || !isapnp_dev->card)
 			continue;
-- 
2.16.2
