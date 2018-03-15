Return-Path: <pratik.jain0509@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-977033-1521140424-2-12700532516827318025
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
    t=1521140423; b=R5cPIChxN+9hJuKcQYE2Fff1S45s5qPiIt9Z3MfRtN7lQFO
    5+V67eu/pnb8uo2nQ42k7uEqt0WIIxF4thsZ+auWfzPpzy2kN0x13sfceArVFBsr
    BGZNFPlrAKkxZMn6r+GK2sgwQPSr6uTRYV83ygmNlPcHA01t9sDzN4OFI4JgYo4z
    pwvGNzAhLCzS+W6CLdbbj+593poMCnG6d417IPBMKSi3MdHqkFsxfmMq7axS0C70
    TSp0ptVm+BMU8bQ9QtzeWbDBFtrt9kLMks3rMHGwSIBt6cbLJ3Ol1+jEczUXTAwj
    tywSQeL9r+53eEXrva/PvFCtifEbPcm7j+vRmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521140423; bh=ojMijHsK7nj
    Dfciy4kT4m5ZJ9XWYmMrcpuGs6EKzBEw=; b=OescU5gcVGQOSo4tiCO/TLDOMez
    FZJUHMS3S/z2JDGdpl26XL/1d3Jpsv5aYoziVj2q8GLCnaXD6FjpyxV/7qySkmTN
    3n4yowsEktbnS5dPyGSHngCXD2DxaxTqHUc4zLzTGhwWNdiEFML8s+XQXbIf7ScJ
    X9mY7pMjckumGO2FEVr+3vGBD8qBOENaQzfm3B03A4xOwcRqR8m7RoKN7cOUwsTD
    q+XaHuLsryBDXqoINHmktep6ZOIFL6ZdSWU4BwGVRm7QHXtMHIcBn2zI9OJ6e5r+
    qHmKrIkB4/0Tc7PXykVz04Y7O7rGGrv6lpjqC0+kWgUBj2meOsSD2BD+xiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZdK+SC6Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OVlaXR48;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZdK+SC6Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OVlaXR48;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELtQS2wwe9lFi7H+r7QcwNZ7a8PpPAYFn2H8N3NzeY+J9e4EBhASJhQwd0tGWtaKbIa6PUQYvA==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	abbotti@mev.co.uk,
	Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line derefernce issue
Date: Fri, 16 Mar 2018 00:29:43 +0530
Message-Id: <20180315185943.18902-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
References: <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed coding style issue.

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/comedi/drivers/ni_atmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
index b9e9ab548c4b..4e27a2959b64 100644
--- a/drivers/staging/comedi/drivers/ni_atmio.c
+++ b/drivers/staging/comedi/drivers/ni_atmio.c
@@ -226,8 +226,8 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)
 	for (i = 0; i < ARRAY_SIZE(ni_boards); i++) {
 		isapnp_dev = pnp_find_dev(NULL,
 					  ISAPNP_VENDOR('N', 'I', 'C'),
-					  ISAPNP_FUNCTION(ni_boards[i].
-							  isapnp_id), NULL);
+					  ISAPNP_FUNCTION(ni_boards[i].isapnp_id),
+					  NULL);
 
 		if (!isapnp_dev || !isapnp_dev->card)
 			continue;
-- 
2.16.2
