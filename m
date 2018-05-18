Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeERJF5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:05:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48220 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeERIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:19:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAB27602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com,
        sricharan@codeaurora.org
Subject: [PATCH V7 03/12] ARM: dts: ipq4019: Change the max opp frequency
Date: Fri, 18 May 2018 13:49:16 +0530
Message-Id: <1526631565-9972-4-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
References: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max opp frequency is 716MHZ. So update that.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 1541e18..2c4ad7d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -47,7 +47,7 @@
 				48000	1100000
 				200000	1100000
 				500000	1100000
-				666000	1100000
+				716000  1100000
 			>;
 			clock-latency = <256000>;
 		};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
