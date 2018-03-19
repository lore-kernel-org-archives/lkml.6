Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1738054-1521431389-2-281272665500986121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521431388; b=Zva9lmj3ykRRJJCXqTjYcXxZjAk5CNjA79TCgL2F+cTP85c
    8XshlzQyDedsu6sYfYPfwayCPErexB6X06Gm2hHItsiQ0Yg/g18XYsLOeHxPU0Pv
    KJPVIiTEiOkBCfGo44XTYyLowucpkPDErJl/YxLMDHtISgepd4uKJDrJ9xgh3FAV
    DHPwN0U0hyWNZGQaZ1TE21E8PJrYKy5LyUSs14aWLWWZCUTViveaT4bMlptqv6h3
    t2vJhUbHKQJUTT/ME3NARPCh82epnIRvmKBOs4Y8frrpuL5B2vG64jgEEibaFFlu
    DX7iRNWUtAE/op0JVbMKWv8HBBZFw3nJldkATbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1521431388; bh=3PJEotp9xLrLoNG9bLqs5C+3ZCvBXgGxCSp0xM
    p0i+k=; b=MueWoeimuDjYV5jkgztcklppwUQPThVIZH24oWOr3z9S0KE/r0wE7b
    lkzCEqDE0cJbtOOvoCOeN0PjGewFMKDSS77ho6yWPTUWMG0Oi/LmSh0gIL2qCmqX
    0VJkyNpPX3ZEXvYOg0ookXulkwxy/6x/1xJCkhjYH5Fl8ss40R3b9z47n1IopMqg
    VZwj3T2leh8dNCITSOyR7NEbb+43NjjzAlk549up587/0HuBHhJDsTlltLo64muZ
    f704RfYKoxrHFkQP37FSrTeYvHXeFowWj7yeWDAJo1pZKVKCbcwSjcNetrcEk9wD
    7c9KrIivEgjcrd5/224VsJ8+nufz5hqQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KQ7Wuofy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S/oP6D1V;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KQ7Wuofy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S/oP6D1V;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELu6sMfGmLoLBXddQk2GAF7YvSgRheHWP7xE5kmTGmavRJcq3ESKzoVMyuEbgR9BNj6r2SrRAw==
From: ShuFan Lee <leechu729@gmail.com>
To: greg@kroah.com,
	heikki.krogerus@linux.intel.com,
	linux@roeck-us.net
Cc: shufan_lee@richtek.com,
	cy_huang@richtek.com,
	jun.li@nxp.com,
	mats.dev.list@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 0/2] staging: typec: rt1711h typec driver and dt-bindings
Date: Mon, 19 Mar 2018 11:49:33 +0800
Message-Id: <1521431375-23207-1-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ShuFan Lee <shufan_lee@richtek.com>

This patch series add rt1711h typec chip driver and dt-bindings

changelogs between v1 & v2
- use gpiod_* instead of gpio_*

changelogs between v2 & v3
- add dt-bindings for rt1711h typec driver

ShuFan Lee (2):
  staging: typec: rt1711h typec chip driver
  dt-bindings: usb: rt1711h device tree binding document

 .../devicetree/bindings/usb/richtek,rt1711h.txt    |  30 ++
 drivers/staging/typec/Kconfig                      |   8 +
 drivers/staging/typec/Makefile                     |   1 +
 drivers/staging/typec/tcpci.h                      |   1 +
 drivers/staging/typec/tcpci_rt1711h.c              | 329 +++++++++++++++++++++
 5 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
 create mode 100644 drivers/staging/typec/tcpci_rt1711h.c

-- 
1.9.1
