Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-993874-1521537330-2-8396026139484895701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521537329; b=q3RTlaX4Hdez5FOcBSFPs8p47VtudVqsOBmEUCN0OmxygPn
    dQIu6J0zd/T3ZAZvFu4FWwxI8SxgkbWBTLGhiksl2MtdcTkQT/Pln5jlhkkQeMLQ
    Q7oNH22+4orBKOsiShYK2LF1hVj2ALTvTIXrh3QXwiclx6N0cV31JHVdzZfoKptK
    8w7BNIq/ZhkaTveq6gpXizm8G4fjxbpF+yXogwLmp2Fnf4KSUa6JBGRIGOEV78gA
    FaxSpD9FIfiS1YpYKBqn6ylXDENVU7TFBfUxlMOh4cpRaC1jdSaOwfxnRsiWdXK9
    z026nGv9JYf98Tp2ptK6Tf7JgOgipZaZNoDSAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1521537329; bh=9avMG1e2YNaQTgurtbfXcsY681Q0mcQ45JGySe
    hBjsg=; b=iNfsVz1T6+7iHgp+tZCgHXgnuQGfZJ6lQqRzgooi2ESs8D04KLgERU
    EGPVpxNN+9SlJGLgE32rXL2UHkQvm1+viD5ckTFr8mY8YALRhRqTlT+vp9SKRAi2
    W0ArGEsIKgYy+gXhrUWQ4Lc8KmK7koiHt5QhMO/Tk1bRcVmvwW/0rWcXNmNOwrUG
    As0EkHMPh5JzZ0OotdZ8bYa8kmUMq+tocW+H+74EO4BB16Bd56YymZrMFAziPzqq
    kVZPWApqYEiQ7agziQ8K8eyyoRl7QRF1lhe2P1Cjq5AlwIkxqFuK6JjgwYwOOHll
    oz2/i5MfSXRQ0NBCS56SJ21Ipr5pl4yw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qHmY64Pr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass (Address match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WiqTce0N;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qHmY64Pr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass (Address match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WiqTce0N;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Google-Smtp-Source: AG47ELtgq/HqvdAsAwD/+LqncllKwdTKQEHf091nTSZMcSrM+QuRGbYbYgKltpe9JP+Kz4oWa1xFsA==
From: ShuFan Lee <leechu729@gmail.com>
To: greg@kroah.com,
	heikki.krogerus@linux.intel.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: shufan_lee@richtek.com,
	cy_huang@richtek.com,
	jun.li@nxp.com,
	mats.dev.list@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] staging: typec: rt1711h typec driver and dt-bindings
Date: Tue, 20 Mar 2018 17:15:02 +0800
Message-Id: <1521537304-7531-1-git-send-email-leechu729@gmail.com>
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

changelogs between v3 & v4
- add definition of RT1711H_VID and RT1711H_PID
- modify the way of using RT1711H_RTCTRL8_SET in rt1711h_set_vconn

ShuFan Lee (2):
  staging: typec: rt1711h typec chip driver
  dt-bindings: usb: rt1711h device tree binding document

 .../devicetree/bindings/usb/richtek,rt1711h.txt    |  30 ++
 drivers/staging/typec/Kconfig                      |   8 +
 drivers/staging/typec/Makefile                     |   1 +
 drivers/staging/typec/tcpci.h                      |   1 +
 drivers/staging/typec/tcpci_rt1711h.c              | 332 +++++++++++++++++++++
 5 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
 create mode 100644 drivers/staging/typec/tcpci_rt1711h.c

-- 
1.9.1
