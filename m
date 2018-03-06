Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeCFNFd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:05:33 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36554 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbeCFNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:05:30 -0500
X-Google-Smtp-Source: AG47ELs+adOwLerbD2LYEsDkJMNw7ujDGaRkMbf217f1DpN6w209s4s1LYDZ1lquiQejyOJHtlWAsQ==
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
Subject: [PATCH 3/3] arm64: defconfig: enable more cpufreq governors
Date: Tue,  6 Mar 2018 18:35:03 +0530
Message-Id: <7a5ecbaf8e5defbf47dc1f0b312a372a4654a18e.1520340931.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the various CPUFREQ governors and statistics to ease development.
Don't change the default governor - performance governor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 80530cb..1f542fd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -99,6 +99,14 @@ CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_ATTR_SET=y
+CONFIG_CPU_FREQ_GOV_COMMON=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
-- 
2.7.4
