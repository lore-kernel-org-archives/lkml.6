Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932425AbeCLQHn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:07:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41234 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:07:42 -0400
X-Google-Smtp-Source: AG47ELv1HmfPzajujIXyJQ4TydjKsQGQnvMxZcqNhn8OJKCjAhGFr8F7szBPAp46j7wZPAgx80bmKA==
From: Craig Tatlor <ctatlor97@gmail.com>
Cc: ctatlor97@gmail.com, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: msm8974: castor: Correct typo in touchscreen compatible string
Date: Mon, 12 Mar 2018 16:07:34 +0000
Message-Id: <20180312160734.5606-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.16.1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was mistakenly pulled from the downstream tree.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
index e87f2c99060d..d85311a0422c 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
@@ -491,7 +491,7 @@
 		pinctrl-0 = <&i2c8_pins>;
 
 		synaptics@2c {
-			compatible = "syna,rmi-i2c";
+			compatible = "syna,rmi4-i2c";
 			reg = <0x2c>;
 
 			interrupt-parent = <&msmgpio>;
-- 
2.16.1
