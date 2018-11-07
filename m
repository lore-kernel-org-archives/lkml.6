Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E4CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA83206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA83206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeKHFy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:54:27 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:21886 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeKHFy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:54:27 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3004219F5CE;
        Wed,  7 Nov 2018 21:22:21 +0100 (CET)
Subject: [PATCH 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     arm-soc <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Message-ID: <596a4b64-e2ef-878d-0873-dd59d14c2d85@free.fr>
Date:   Wed, 7 Nov 2018 21:14:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")

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
2.17.1
