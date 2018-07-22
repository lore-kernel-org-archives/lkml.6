Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB802ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5E20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA5E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbeGVWSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730905AbeGVWSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F762AFCD;
        Sun, 22 Jul 2018 21:20:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        James Hartley <james.hartley@sondrel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 08/15] MIPS: dts: img: pistachio_marduk: Add user LEDs
Date:   Sun, 22 Jul 2018 23:20:03 +0200
Message-Id: <20180722212010.3979-9-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the LEDs that are connected to the SPI UART bridge.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/mips/boot/dts/img/pistachio_marduk.dts | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index f682d0a5a3d9..6984933b3cdc 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -60,6 +60,52 @@
 		};
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "marduk:red:user0";
+			gpios = <&sc16is752 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led1 {
+			label = "marduk:red:user1";
+			gpios = <&sc16is752 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led2 {
+			label = "marduk:red:user2";
+			gpios = <&sc16is752 2 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led3 {
+			label = "marduk:red:user3";
+			gpios = <&sc16is752 3 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led4 {
+			label = "marduk:red:user4";
+			gpios = <&sc16is752 4 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led5 {
+			label = "marduk:red:user5";
+			gpios = <&sc16is752 5 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led6 {
+			label = "marduk:red:user6";
+			gpios = <&sc16is752 6 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
 	keys {
 		compatible = "gpio-keys";
 
-- 
2.16.4

