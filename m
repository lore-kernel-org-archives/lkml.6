Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-986160-1521537338-2-18351438759175590604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521537338; b=pQwJGz/xNEQQBhmZ7moLEz9/Rmxd9+ZNLSGK62GaonRyzPB
    9VCV4+LaRrSorvSLthgS+AsYAK/Ynt51uMiVl6PNbXcWAC/Ymu87Nm3JnsUIXwyc
    ACZRgEeHt3ByIYscQXgfgGoWh9f+lTlaN6kcDoDSLN56FcIiPAxHwKrCbt6tqjpC
    /lX8vqLDj1OV4nhkwCL7TjTV4+i6JZ0Do9rx6AmccucEZ34wMk1vt3swbsTvxlKf
    MllT7Ygbn2032ToqhXXdp/C2mal2bsxgq8lvzLVyYbPVOVI2ISzVGs5DXyfYOupC
    bJNYUM8m5JOsAcfmMRbs/70jQ7IWitOuRW+G30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521537338; bh=8YnQ7kMlP+Z
    M56ov2j8OAdmprdQ6uqGtOoFaTmn1x3k=; b=QktlcqfudTmYMOvomAzDSvH2wZR
    gQagKP1In8F4k26gAufdea9BF1HjqIVI/bHdmF+ZbfaIGlg0WzoiLvbL8E29xQWn
    wHM1ySz/nrROJBEMuVgbLc0ARZV94XVjtdp5Izj3Q8yEdjl3vxbpcV7EA2duxizu
    Vhs8+O9PPvy+V3/zrVk0Epj1SVgy5ytv31S092xIov6OQjAliayJ1nRQpBBe3ZWw
    vElPkRnTXaOyXnUQjSIHYXi3K/Mo8XdTsQdTL3fZMohoFrVHyx12ZmSE0Sz/rZPB
    +YwM2Mi4J/BrA5Xsd5rjvrubYgtk7D0nL/bIZMYKQoRjzU/HWzXdnuxdCPA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SUu1hNDz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass (Address match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L2iz+KQ0;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SUu1hNDz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass (Address match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L2iz+KQ0;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Google-Smtp-Source: AG47ELuOicTw7gGN4iRRbN7p6BPa63J8QXSEgFsGYFy/aU+z4/2mfmozapcgCM4xWkgLO3N2LW9fZw==
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
Subject: [PATCH v4 2/2] dt-bindings: usb: rt1711h device tree binding document
Date: Tue, 20 Mar 2018 17:15:04 +0800
Message-Id: <1521537304-7531-3-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521537304-7531-1-git-send-email-leechu729@gmail.com>
References: <1521537304-7531-1-git-send-email-leechu729@gmail.com>
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
 - add dt-bindings for rt1711h typec driver

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
