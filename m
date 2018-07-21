Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A039220863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A039220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeGUPGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:06:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39918 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeGUPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:06:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so9110051pgs.6;
        Sat, 21 Jul 2018 07:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZkH+fTuXLzILILxIyKT6m1MUvEkcsKadAhYpjidCzE=;
        b=mpprc669EQDDXu6vQlpbFOzqwwTB4HEnB81gsG82ITN8D/DiVvFZoyno2+pGWO0Jiv
         G2m4XW5mmiUSlOlcN82K6UZUCZyIr2cD06uIZNSETFsbtVh3hy2rDC7jNGYOXOW1Io/7
         Bqr45yNiuUxMJB2Ll24RM6AmyzpmhI7QJwrFI+KDd1xKy33uJn1EGyklxLOvXdmwu3US
         VhWXmQpVv6eR76Swi48wv/89dmFoUeAwtqAC7Ojd3da2IDaEnSvALDo0E7LARueRZhve
         sfvzlUi/Z9HDtbi7Ak9eqjmPmWQUMHMnKw2E/W9kuwZeCGduBoIuv9a0LPVYcDndTsRj
         HLzg==
X-Gm-Message-State: AOUpUlHbUt/295Lj6IYoZQVemlDfIk9rytDok06LrnCjWsNUlwkfrJHE
        hPyTCn2rc4LfBMSeGLuNXuD+J2naIFU=
X-Google-Smtp-Source: AAOMgpfS7zP1cPbbgk8ILTD1j+Uy+3wH/e9k1CR9Q6GpFmY7TBkpZkg/M4iDHixTqEQAbV9cvM+HOQ==
X-Received: by 2002:a62:d98f:: with SMTP id b15-v6mr6193641pfl.1.1532182400684;
        Sat, 21 Jul 2018 07:13:20 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id t1-v6sm5033209pgp.32.2018.07.21.07.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 07:13:19 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-leds@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] dt-bindings: leds: document Panasonic AN30259A bindings
Date:   Sun, 22 Jul 2018 00:12:26 +1000
Message-Id: <20180721141228.2283-2-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721141228.2283-1-simon@lineageos.org>
References: <20180721141228.2283-1-simon@lineageos.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Simon Shields <simon@lineageos.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/leds/leds-an30259a.txt           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-an30259a.txt b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
new file mode 100644
index 000000000000..6ffb861083c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
@@ -0,0 +1,43 @@
+* Panasonic AN30259A 3-channel LED driver
+
+The AN30259A is a LED controller capable of driving three LEDs independently. It supports
+constant current output and sloping current output modes. The chip is connected over I2C.
+
+Required properties:
+	- compatible: Must be "panasonic,an30259a".
+	- reg: I2C slave address.
+	- #address-cells: Must be 1.
+	- #size-cells: Must be 0.
+
+Each LED is represented as a sub-node of the panasonic,an30259a node.
+
+Required sub-node properties:
+	- reg: Pin that the LED is connected to. Must be 1, 2, or 3.
+
+Optional sub-node properties:
+	- label: see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+led-controller@30 {
+	compatible = "panasonic,an30259a";
+	reg = <0x30>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	led@1 {
+		reg = <1>;
+		linux,default-trigger = "heartbeat";
+		label = "red:indicator";
+	};
+
+	led@2 {
+		reg = <2>;
+		label = "green:indicator";
+	};
+
+	led@3 {
+		reg = <3>;
+		label = "blue:indicator";
+	};
+};
-- 
2.18.0

