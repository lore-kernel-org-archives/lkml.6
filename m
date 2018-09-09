Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E22C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F6D20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 10:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F6D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeIIP2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 11:28:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45890 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeIIP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 11:28:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so9031884pfo.12;
        Sun, 09 Sep 2018 03:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZkH+fTuXLzILILxIyKT6m1MUvEkcsKadAhYpjidCzE=;
        b=E9n3LK3G55g7g9n9ZpOnSkcVdATFjjxK+6zuxZBI/V3ZIcOUMPKtLjK1AYwr8gm9PZ
         euZJ/Nt8R41kLzAWQcdM6wEIhRjgAZoOnJpaKC37aNcjVO20zgu21JXnduKN6aAnNu+n
         LHGl7xRCZj2PyT2waQXA/Sa7YP3SJwr0gmVKP8hrB5wVnkne7OEMCDLj5CLMqA1fHxke
         LeSQ1jpnhu6upMf4WQ7B+aNuF/f59sc0RkfVDMTJB0AI2jXGblNt/L23eIWhs/FdH/iE
         COoaRAJvJFkvpPnyGO6XlNaxMWpSJph6FwTFaQYSEdczGBweZbhfAmrj47BGJ+4LuTTH
         dUCA==
X-Gm-Message-State: APzg51DTU4P+RpL9h5brjGsD81+Jff2Y98r4eJxObX0X/u4s1uDHHEr8
        DOO8t4XRlxiYyAGaA22FgDpyZvVwI4bZPQ==
X-Google-Smtp-Source: ANB0VdarCldVA5Z1sdQHtkqjjoBKtFK1AVGWvtVogTPZIvyLOR+xd33DOR1JIce5ez5K1sRJWZGSAg==
X-Received: by 2002:a63:b00f:: with SMTP id h15-v6mr17341776pgf.442.1536489554924;
        Sun, 09 Sep 2018 03:39:14 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id q6-v6sm15984272pgq.19.2018.09.09.03.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 03:39:13 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-leds@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/2] dt-bindings: leds: document Panasonic AN30259A bindings
Date:   Sun,  9 Sep 2018 20:38:24 +1000
Message-Id: <20180909103826.17793-2-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180909103826.17793-1-simon@lineageos.org>
References: <20180909103826.17793-1-simon@lineageos.org>
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

