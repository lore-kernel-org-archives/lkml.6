Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513208-2-17624033728370315040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513208; b=P8Es71cpwkBmHIfYWrjOYI4xYKg4lx2A3Czwlgrase0bkjE
    1s3axdu3XVsywCD7DRuyNiU2SIaplZoMgDmnraHZ8bM2t4mJAorKLVlKbsy0EXEF
    t3oeAuDI5OCLCPhwWi7s8J2rYcVTdCWoZpicN7ZRysOxgr4kFt+XPrOPVZJ1jHzo
    AcfNKKKGQhfssu6chB+A4K3y5IBtCeN77dr7klOqhPBsPIJWyJunimi3i5vfBOj6
    6SI3PohSVrMc383tIBzoyE5g8Zb7N62oCPHhoIpC9UwOT4JOMynW5yo7xQ+WGP3/
    dwNQQ0nDDmf3xMm2QPsPhHFqOUiP83LFMfrq+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513208; bh=jWmW0rNWv3O8nXNeHB9d91ZO9oeB8bZ20X+M+psj9Q4=; b=f
    NtbsGlEM5rhVj5YCACOcIXsWRV3aizOXxGDk9kQt5nwPKrwZz4r5HV0T9g5LiXEc
    R1cyNyUzEveLLlLOdcxNFkPfAsKBIRsg8luIVLCTUq+E0GYqgdBlGkqInjgLIpKV
    gxrQbDVrrYaenFC1UFr28yyiAKBi7aY4seimvXT/TnwcMvUGMe2CDeyEcOZi3RCB
    xwTEBISYhGeDL3HDkU4O3Km6BWDJrtsjA284qcoklVNU2Gi4edPM2dRtcaAwFg7l
    vXq435OyJbPIT2q2dopYyJoZ8GwiRT6otZpuojIW57ebrdZ2CT6uJ4sboum3NfJg
    IiL3dZiFG8HflWxCT+ADw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qTCSaQQq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RiPAbZgZ;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qTCSaQQq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RiPAbZgZ;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226heaaZzy4QbxpxwwbjTPXd6Y7rI5gn29NLCxpHarC9iEFQOJmg5R0p2pq+heH/tZS6z0itnQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Rick Chen <rick@andestech.com>
Subject: [PATCH v7 35/37] dt-bindings: interrupt-controller: Andestech Internal Vector Interrupt Controller
Date: Tue, 13 Feb 2018 17:09:39 +0800
Message-Id: <3fd9703061e1093ed5f678a98ad6caf17c2930eb.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds an irqchip driver document for the Andestech Internal Vector
Interrupt Controller.

Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../interrupt-controller/andestech,ativic32.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
new file mode 100644
index 000000000000..f4b4193d830e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
@@ -0,0 +1,19 @@
+* Andestech Internal Vector Interrupt Controller
+
+The Internal Vector Interrupt Controller (IVIC) is a basic interrupt controller
+suitable for a simpler SoC platform not requiring a more sophisticated and
+bigger External Vector Interrupt Controller.
+
+
+Main node required properties:
+
+- compatible : should at least contain  "andestech,ativic32".
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells: 1 cells and refer to interrupt-controller/interrupts
+
+Examples:
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
-- 
2.16.1
