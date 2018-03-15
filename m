Return-Path: <pratik.jain0509@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-779193-1521135071-2-11323139670612068441
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
    t=1521135070; b=jqOMWByYlcTlXe98ynZXUNXuuzCiRyNv3NoGjTgNZ7XHh+W
    Y29MpEPYSdoGDd9Ur+wPRNAPohJ3jnh/VCCL7oicMbZ/dmpOqUIdV1Vg6dXnW8SE
    E4XHKoWup5FvS0jvszfPK2K+5JNF0V4Z+qiVLbW+G6vFWz6wQHHzJiRTNHNWWnNI
    0tSBSGy7+Ssk3Q+j92CBC6k7vF/CLgXmnN9qafGwpRjE6l4nDDnjNYxoPWHfsuqo
    FGXAhYzCtEILErqskjWcEIx2wjGB2pgursBrQKGjpghsSJKp6VTNfNwU/1dQ9xg5
    Vs1XINxszHZf9P2RfF+waShMkRy9nyGd/xTzCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1521135070; bh=13NaVY7tPb6kO0Hbd0E8qHGAj7mnXgQHI3Efnd
    Tg9JI=; b=FN0IfOWfbNdVzq52zWFimaLNNd3Tqgfzi+3VMt0fRsmGOAidB7Gf56
    sfygtNrZQ3xmCiUQCJSJgciiKaGvuXFw3jfaOAx59th6O/+2TSme92CCgtNmvAyj
    M9YVWD9zcDPDEeHYO82M9XCavmLzzka4YRmi21pfZUFjiq8UT5CqLDSbEdw0B3OK
    Y/nxfZEDlY/5pMPfqllM/VOdGMufZykS+UMOhRTvpZWIVwcA8zKJcx9aaufmXwk6
    o+O659rfBhGIn5ZgbR8q/QYFj8x1zQjfB4H//oUbeYuSiZiOEZHd+WF5yvIGWKiR
    bPGa/mApid52ErcVyBNRIqRBCnR6Reug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=c4A4o17/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pS1w8HEN;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=c4A4o17/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pS1w8HEN;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELuRqB2R05Bu4hPpu9Y+wjiSbmggm/kO8E4Hhr52B/ZcVSUe+/VPGVXoU+vV8ia0soagcJnLQw==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	abbotti@mev.co.uk,
	Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line derefernce issue
Date: Thu, 15 Mar 2018 23:00:40 +0530
Message-Id: <20180315173040.11468-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed coding style issue.

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/comedi/drivers/ni_atmio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
index b9e9ab548c4b..e82fbe987dd8 100644
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
@@ -356,4 +356,3 @@ module_comedi_driver(ni_atmio_driver);
 MODULE_AUTHOR("Comedi http://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
-
-- 
2.16.2
