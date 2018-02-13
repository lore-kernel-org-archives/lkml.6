Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513194-2-6145280767797743105
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513194; b=FISuooBFE0bS7vLL4UEHaqt/qgrRNXCwitZwL+prVGeVJQr
    5usp1fJ5qWIDA9jmaZdvMk0rTbsoR89JogXoPbmSfNEyneDzWcyjHkSEG689iWEw
    3wHGEMRi6Ok+fIAytlOsWMMxP8W01TUM8QhjI0N6eILN3Bx1OwfGJG726ckNoxRJ
    wrgUdeOMdyDne8iQXAO/WC4Zb/zSZ4G9nrfS0GMVNJAqoB7Lv7Ppa/sMwrbFtMJA
    qi/g1xClCRlNTKTzoK5Hiend+a8xoFkR34kd1/dTq6Zpw7GEkXFdQ+e6fCQk8YPk
    3gvIYXMiifgtRPzYkxeU1WKH3KsyDzeVL10uudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513194; bh=EUd52Ddne7G/sQKoCQiXHDcfpEPOtYRIAlWpDKqaYcs=; b=c
    PDFTqNOTZJae11B7k5MFwld9Q5Vj5Vx6a0xdqPFhLK/i+0Uu/9RdvTgl36hSgUoF
    HYUWjEyrf5VP5I7hozSCmA1CH0ub20Ey3NUiC6gQ6vE4lr+FI7dg4WzEpA8F5MYB
    zu28SFQP3MXKQKmbX4f/UgQE2AnmYQFP2QsNNrlnslvsNw6VnlpomoeKD786A7Af
    MAx4+p8+w1BVZys770FDTQYEFR9ACIa9me4xL1tR9HUSV0n6AIfqZ/I4wk19QiWP
    wd2DLHXl21QbQCOC8mOOxrqvocVbvyAA4pBWVrCqX69gJA6/9kdB7yWYzxtJzvnW
    aSSGFxr58imZrlSMudRlA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=T+frEcM7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E9VkP+Zc;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=T+frEcM7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E9VkP+Zc;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226lM7CzZwftQYrLItji4zvk1GgrwjM/mcxp8NDV5Y/MAhiwf43tC8W9O6pQdt6XMYht5IC4fg==
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
	Vincent Chen <vincentc@andestech.com>,
	Rick Chen <rick@andestech.com>,
	Zong Li <zong@andestech.com>
Subject: [PATCH v7 32/37] dt-bindings: nds32 CPU Bindings
Date: Tue, 13 Feb 2018 17:09:36 +0800
Message-Id: <e08b102ed7e8c18e35e19652ec2db052f13105d0.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds nds32 CPU binding documents.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nds32/cpus.txt | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt

diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
new file mode 100644
index 000000000000..6f9e311b6589
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/cpus.txt
@@ -0,0 +1,38 @@
+* Andestech Processor Binding
+
+This binding specifies what properties must be available in the device tree
+representation of a Andestech Processor Core, which is the root node in the
+tree.
+
+Required properties:
+
+	- compatible:
+		Usage: required
+		Value type: <string>
+		Definition: Should be "andestech,<core_name>", "andestech,nds32v3" as fallback.
+		Must contain "andestech,nds32v3" as the most generic value, in addition to
+		one of the following identifiers for a particular CPU core:
+		"andestech,n13"
+		"andestech,n15"
+		"andestech,d15"
+		"andestech,n10"
+		"andestech,d10"
+	- device_type
+		Usage: required
+		Value type: <string>
+		Definition: must be "cpu"
+	- reg: Contains CPU index.
+	- clock-frequency: Contains the clock frequency for CPU, in Hz.
+
+* Examples
+
+/ {
+	cpus {
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "andestech,n13", "andestech,nds32v3";
+			reg = <0x0>;
+			clock-frequency = <60000000>
+		};
+	};
+};
-- 
2.16.1
