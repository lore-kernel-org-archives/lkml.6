Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239917-2-3641084912730466827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.192.194', Host='mail-pf0-f194.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239916; b=azUyUVsZ2z3mJyp4HHPLJV81+8N3RQaxMgkVi7etO8fkohxLIE
    ti4YGJguXYkIgDsyVzeyCjl3szodcxcLpE/C5Rn/z/EQwkH0rcn9aLd5troxF6Hv
    64HBFx/L3Y7VwsZAfpGmBXCOJ1PipOfLcbnqnJYEPQgdR5exUeYcg6cMGmWgC7sw
    K8SVOm2ws3NlEukNN+7v87/3Ya2hESntShz3BTQ1LSsk8sgRey4hmUi0Fvxo7NlG
    RPdOK3mvx0k9JwW+RAVgzC10y4mfBmc0SzQYgXr5NIR8Gt0tzJd5wE58s+Fh+4RF
    wY6aylH+J30WcimxlPKLatGNSuD2J+kefMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    fm2; t=1523239916; bh=AXHeTS+z1kIAEl2rhjjXGzpe1n5N9++8UNdBsXA99o
    w=; b=layrKMnbVI+Bi6qAJNHPYi4d0VJw8F09VhIwgo1kyOsh7Ycw8r/BymKXcm
    PvIx0Xw4Sqt36WY1X/sIWaAjIA0vUQVgKGAg5RRQYf7lDEM9hlqMui5ot3QlIY6g
    NaZXSITpFQifG1TeWi2Hr3FURq5cSeJVQKeK5BCu+qaHOZFcc/s6/h/6ga6UlVwi
    wWEXq4Ml/SagV3ppRI7MbylJNLFwaZqtjl871cqjRSplhdD2wpY2u9fvNPxxqaMp
    7FE+OYgQZxIZyvTpJrsvjHmw/diwuyCthxg/sBVlLhoLsbjzKsqn9cZaF0FqhWIj
    PWDcXaEptTl8CaPtf5Tfil3IUycA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RQ1BtTha x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.194 (mail-pf0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f194.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bM/BsiD7;
    x-ptr=pass x-ptr-helo=mail-pf0-f194.google.com x-ptr-lookup=mail-pf0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RQ1BtTha x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.194 (mail-pf0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f194.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bM/BsiD7;
    x-ptr=pass x-ptr-helo=mail-pf0-f194.google.com x-ptr-lookup=mail-pf0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPRSYa9yaFvBFsDfC/FmNi4rCTogbg3sOxnldxyVaai3zwIltXiBkmLUigK9Wkhc7LvQsqACJkQsKCnZXp8Qo+V4phZjuufymlxtMdMqtFEXfvwext+n
    AZxraX9YgPc4WbUm/ZkRAhGXSzIZfBE4qa8+CBe925rnmQ2lZV+zi+ng6OKnVHaBxawmvN2UrTsM7qR9MOVkztMMH71s5v3YD18=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=q1RTs8wOsFxUj3NkwiqlDQ==:117
    a=5e1vwORFIueXgP/ahoX3ng==:17 a=x7bEGLp0ZPQA:10 a=RmZWWTEyPbYA:10
    a=Kd1tUaAdevIA:10 a=l0hiEBf7AAAA:8 a=n2QAB0608vrUGZuVM_8A:9
    a=ynCB8LqupOr-u-Kv-6Up:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AIpwx4+vwLqoIUYnN1VjbiaUhBj0pGfKLN1q0WpiFa3YqSiRPFSs61PQM1zNrf7FcDEUkMKNqpdWlA==
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
Subject: [PATCH v5 0/2] staging: typec: rt1711h typec driver and dt-bindings
Date: Mon,  9 Apr 2018 10:11:33 +0800
Message-Id: <1523239895-4467-1-git-send-email-leechu729@gmail.com>
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

changelogs between v4 & v5
- remove rt,intr-gpios in binding file and always use interrupts property
- remove parsing rt,intr-gpios and just use client->irq in rt1711h typec driver

ShuFan Lee (2):
  staging: typec: rt1711h typec chip driver
  dt-bindings: usb: rt1711h device tree binding document

 .../devicetree/bindings/usb/richtek,rt1711h.txt    |  17 ++
 drivers/staging/typec/Kconfig                      |   8 +
 drivers/staging/typec/Makefile                     |   1 +
 drivers/staging/typec/tcpci.h                      |   1 +
 drivers/staging/typec/tcpci_rt1711h.c              | 312 +++++++++++++++++++++
 5 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
 create mode 100644 drivers/staging/typec/tcpci_rt1711h.c

-- 
1.9.1
