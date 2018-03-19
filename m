Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935427AbeCSQVj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:21:39 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44840 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935290AbeCSQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:21:35 -0400
X-Google-Smtp-Source: AG47ELv6VTCO4XtcAovw93XkJVJygxzAhExS9BJwvScUcnF2e5f6I2UqdJYnPh9jOKMKiPdlb97ORQ==
From: Adam Ford <aford173@gmail.com>
To: adam.ford@logicpd.com
Cc: Adam Ford <aford173@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: da850-evm: Enable usb_phy, usb0 and usb1
Date: Mon, 19 Mar 2018 11:21:22 -0500
Message-Id: <1521476482-23335-1-git-send-email-aford173@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EVM kit has two USB ports.  This patch will enable both
when booting with device tree.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index c755079..cc77735 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -304,6 +304,18 @@
 	};
 };
 
+&usb_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
 &vpif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
-- 
2.7.4
