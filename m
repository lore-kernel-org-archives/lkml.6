Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeERPVf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:21:35 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38350 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeERPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:21:33 -0400
X-Google-Smtp-Source: AB8JxZp1/ED4x9Sn7kaoHd0w+Jc2/177wgPnaSyUU5QDqQwNiCDWAvmXbWovOsCsSD0d9AiJFGA/OA==
From: Scott Branden <scott.branden@broadcom.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
Date: Fri, 18 May 2018 08:21:20 -0700
Message-Id: <1526656880-8795-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify 1.8V EMMC capabilities for bcm958742k board to indicate support
for UHS mode.

Fixes: d4b4aba6be8a ("arm64: dts: Initial DTS files for Broadcom Stingray SOC")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
index eb6f08c..77efa28 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
@@ -43,6 +43,10 @@
 	enet-phy-lane-swap;
 };
 
+&sdio0 {
+	mmc-ddr-1_8v;
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.5.0
