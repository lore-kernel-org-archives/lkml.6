Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeEVRCE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:02:04 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42008 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:02:01 -0400
X-Google-Smtp-Source: AB8JxZpIopU+KfCA1DlJAwq8gz3Q0WUDDI6GTP5eZ9gQytEYQ5nmK4M76hPt5gWJywcEvzpoRV6NMg==
From: Scott Branden <scott.branden@broadcom.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] arm64: dts: specify 1.8V EMMC capabilities for bcm958742t
Date: Tue, 22 May 2018 10:01:39 -0700
Message-Id: <1527008499-4120-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify 1.8V EMMC capabilities for bcm958742t board to indicate support
for UHS mode.

Fixes: d4b4aba6be8a ("arm64: dts: Initial DTS files for Broadcom Stingray SOC")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
index 6a4d19e..dd9de6b 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
@@ -44,3 +44,7 @@
 &gphy0 {
 	enet-phy-lane-swap;
 };
+
+&sdio0 {
+	mmc-ddr-1_8v;
+};
-- 
2.5.0
