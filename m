Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F98C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643822086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643822086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeKIKtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:49:03 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:63718 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeKIKtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:49:03 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 2C17719F57E;
        Fri,  9 Nov 2018 02:10:42 +0100 (CET)
Subject: [PATCH v3 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     arm-soc <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <281cd6fb-138a-956c-999b-58d9e04787c7@free.fr>
Date:   Fri, 9 Nov 2018 02:00:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64, so remove it from
the defconfig.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f786c95504d3..8d6878c1e794 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -107,7 +107,6 @@ CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
-CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
-- 
2.8.2
