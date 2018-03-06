Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeCFNF1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:05:27 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40754 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbeCFNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:05:24 -0500
X-Google-Smtp-Source: AG47ELt0AI31zIeXY7BLegdqRlW3zIB6/CbmFa93rtTFGzgi3xGqg1uw55GDiRooeMJNw4qOerrTGw==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Alex Elder <elder@linaro.org>,
        Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: defconfig: enable thermal sensor on QCOM platforms
Date: Tue,  6 Mar 2018 18:35:02 +0530
Message-Id: <3c0f37be33dba8500fe39a0951f67a6882245afa.1520340931.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the driver for the TSENS IP that is present across several QCOM
SoCs.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..80530cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -327,6 +327,7 @@ CONFIG_THERMAL_EMULATION=y
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
+CONFIG_QCOM_TSENS=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
@@ -562,6 +563,7 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_QCOM_QFPROM=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-- 
2.7.4
