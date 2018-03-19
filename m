Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1744695-1521431395-2-7071747643204845132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.67', Host='mail-pl0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521431395; b=to2K0F0w/y/ir7x+PYWpe9ECznV4+CAOa6usXvwWZkX1ftm
    //EPuDDdJkSirW0/L17Qk6p/28e27/GwG1kEquHJpOweOgKGWXao8kKE4ZogUR6z
    sCcwCtw1qcf1oDnKYiPCBZ/Pyh0KSi3MUncxf9aiArvbph24MwgU/agaiFBBJX8Z
    1yILg+rwJiwBNwxAROw1WiP5US0RKpmhmFfLAhIWhlPuDn9W5RL2m8iELdGX08Uj
    C9hQGPjChvq4zGGRaG2D/Ay9Kdqn0/7MFW0t0m5RfXybrHOxzIpNOEu9h37KI+DM
    flnTlue8Cruue1jwUmxy6n+ZLdVtjSt5vMtiwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521431395; bh=2dHnPZDW/D5
    q1I5V6/6ITxHhudCN6jNuGO17WZwVOE8=; b=jRDdF3lAE3DvOg+oT1riLQ4lACA
    CYhyUEQVLAZiul91pegYcsmfeQ3pe3CIHQkZi3SyEwG3i+9Vgg//Y2pYcSKh/r/X
    PPmxrwu/sF7Z9FkGEJb1Me6N9BZLZHCoBYCaqSnfb90+E0Cjo+vGZbF5ens/Ethx
    PcZv6Ys/JHmDucnsz50AyVMhePnG5Oaao42yByzK+cJM7r1K7l37+QaaGVPAuTIO
    /HRxuqer2wlyqJNu/5jrjrAhD09LnE8heeG7zPGo1b7w5ojNZ8T21JJo3lO3XHxp
    suajj+Un0i9L7cTBQK84kX6JIN6Be40Z0qp67W2Y533C+15URJ60MXSh3dw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MfpIQMPZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gOvoiC13;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MfpIQMPZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gOvoiC13;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELvYL4RIqO160DyxFwKIH3J9ULyd/akv2rlXLSMUvHy5hWBa4L7rnLGHzEgf+u/TkY3BLpLkRg==
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
Subject: [PATCH 2/2] dt-bindings: usb: rt1711h device tree binding document
Date: Mon, 19 Mar 2018 11:49:35 +0800
Message-Id: <1521431375-23207-3-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521431375-23207-1-git-send-email-leechu729@gmail.com>
References: <1521431375-23207-1-git-send-email-leechu729@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ShuFan Lee <shufan_lee@richtek.com>

Add device tree binding document for Richtek RT1711H Type-C chip driver

Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
---
 .../devicetree/bindings/usb/richtek,rt1711h.txt    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt

 changelogs between v2 & v3
 - add dt-bindings document for rt1711h typec chip driver

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
new file mode 100644
index 000000000000..7da4dac78ea7
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
@@ -0,0 +1,30 @@
+Richtek RT1711H TypeC PD Controller.
+
+Required properties:
+ - compatible : Must be "richtek,rt1711h".
+ - reg : Must be 0x4e, it's slave address of RT1711H.
+
+Recommended properties :
+ - interrupt-parent : the phandle for the interrupt controller that
+   provides interrupts for this device.
+ - interrupts : <a b> where a is the interrupt number and b represents an
+   encoding of the sense and level information for the interrupt.
+
+Optional properties :
+ - rt,intr-gpios : IRQ GPIO pin that's connected to RT1711H interrupt.
+   if interrupt-parent & interrupts are not defined, use this property instead.
+
+Example :
+rt1711h@4e {
+	compatible = "richtek,rt1711h";
+	reg = <0x4e>;
+	interrupt-parent = <&gpio26>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+};
+
+Example using rt,intr-gpios :
+rt1711h@4e {
+	compatible = "richtek,rt1711h";
+	reg = <0x4e>;
+	rt,intr-gpios = <&gpio26 0 0x0>;
+};
-- 
1.9.1
