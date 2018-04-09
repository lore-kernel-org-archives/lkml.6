Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239928-2-8439947838896697949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.192.195', Host='mail-pf0-f195.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239927; b=tGf+5GMym3FCRzDz82a0wtEXLcwTPKHGqIJc2Oh6wkiM9tpeRe
    B2OrJ/2JbL1JG8Nhw+6XZ4BQuBLuKew4KWXg/ff/2V9m8mxd+CPrxIry0HaSgOER
    skQyUrsJabHv5JUxn9MTDVodls/w6KuJHFP7SJ7KWl9qXGJeSb2OAVSvQCMHj7hS
    jW54NjZKi5oirTjjQZ1ZGM14rBtWRA3Pq/GKaOf2sOPgHidrzerHSvEWQWu9t6oL
    JazDGz7IeME92LG438gmhhXUUBReCpIeMhM6zRE+M9yxGJ0GgsptrmKxTNTc0VPb
    uSSwngyBeF4Ofmap96NDOH0GkjbpvuCcTAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1523239927; bh=ACKKoEGN+GDZvAK
    QHwsHxTLJEXv4HuFOwCFIVbuHpwA=; b=KA71M7tILeQNcUs6lDBC38M5k61iE6H
    pn7KxkGzdBzkaC3jil6Qr1IVw19j+xsSr7MFKGsMGifRBxBA5HaroPglCGLAIf0u
    j2/OdWW/NE3Vmja5SulkbXO0GGyWSy4W3o4usLXNZFtkWQJp7x8UMZEWSuqwY/Wr
    MWPwNtHpP/hI1KyRy0a/MNnR9Z2Y8aej6r/Ow+4s1629/vTIBC0Cc043W2cTa1Qa
    MDBC6efiZeNbqxlUHI3ETYiIo/6MMciUsKuzj4gXlEkHIhLqm8TbpOsl9vSdykh2
    Vq6DT7DsCA6nCdlpNg4rse8Fq61o/bLm+5wve0EmIPhCJd+9tLMSdMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=usCiRTP4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.195 (mail-pf0-f195.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f195.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sijhEooi;
    x-ptr=pass x-ptr-helo=mail-pf0-f195.google.com x-ptr-lookup=mail-pf0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=usCiRTP4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.195 (mail-pf0-f195.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f195.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sijhEooi;
    x-ptr=pass x-ptr-helo=mail-pf0-f195.google.com x-ptr-lookup=mail-pf0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA5+AZ8uW0FzwkVfi/K5jmDoqMPaua3jOkU+RCXiq2sNppc/kmomwSa1clXdw3CHeK9ojQyRoc2bKCHP+aMIzP4WAPYLcY77IJgCY+tLEUURR7WbMfT7
    n4OoXB/TtBAYXzZc4nZEhVZ9gK8NB5vMRYNxyT0uBo+tDj4k02wxg6d5JLfFwBEFN/2gFW37YHYJjGt8qlFhlxMTf6HfOx7oDMM=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=k5Mz17+EVlWW/9RPOEeQrw==:117
    a=5e1vwORFIueXgP/ahoX3ng==:17 a=x7bEGLp0ZPQA:10 a=RmZWWTEyPbYA:10
    a=Kd1tUaAdevIA:10 a=l0hiEBf7AAAA:8 a=GY2R8E_rcWczN4kuZ-AA:9
    a=nMQrQmj1SSFzTSeU:21 a=mES5Gd7v8VTXOEV0:21 a=ynCB8LqupOr-u-Kv-6Up:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AIpwx49qygebrtts0gNGK6PMDlNG1mwiSecoWvxD13+lkkRrchlqOnl8hq6b6zWS31JkP07O7jFBOQ==
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
Subject: [PATCH v5 2/2] dt-bindings: usb: rt1711h device tree binding document
Date: Mon,  9 Apr 2018 10:11:35 +0800
Message-Id: <1523239895-4467-3-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523239895-4467-1-git-send-email-leechu729@gmail.com>
References: <1523239895-4467-1-git-send-email-leechu729@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ShuFan Lee <shufan_lee@richtek.com>

Add device tree binding document for Richtek RT1711H Type-C chip driver

Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/richtek,rt1711h.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt

 changelogs between v2 & v3
 - add dt-bindings for rt1711h typec driver

 changelogs between v4 & v5
 - remove rt,intr-gpios, always use interrupts property

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
new file mode 100644
index 000000000000..09e847e92e5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
@@ -0,0 +1,17 @@
+Richtek RT1711H TypeC PD Controller.
+
+Required properties:
+ - compatible : Must be "richtek,rt1711h".
+ - reg : Must be 0x4e, it's slave address of RT1711H.
+ - interrupt-parent : the phandle for the interrupt controller that
+   provides interrupts for this device.
+ - interrupts : <a b> where a is the interrupt number and b represents an
+   encoding of the sense and level information for the interrupt.
+
+Example :
+rt1711h@4e {
+	compatible = "richtek,rt1711h";
+	reg = <0x4e>;
+	interrupt-parent = <&gpio26>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+};
-- 
1.9.1
