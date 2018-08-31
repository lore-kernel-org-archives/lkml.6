Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9826C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E18320658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E18320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeHaUrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:39 -0400
Received: from mout.perfora.net ([74.208.4.196]:45985 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeHaUri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:38 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MK3Jj-1fwbGW3PmP-001R3o; Fri, 31 Aug 2018 18:39:14 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 25/34] ARM: tegra: apalis_t30: line break long compatible property line
Date:   Fri, 31 Aug 2018 18:38:07 +0200
Message-Id: <20180831163817.23970-26-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:3S7raW3GFUasT1QrSsvNCdD4yzfFKa09TsPTkiiUwX1Q0he5IR2
 h4K0FXItJynmQtwKKWtp0sdqJAbMej6wQhHx/x2Tbech0rBOTgNweasdo4dlNX2h1BGSUgW
 8y/P0B28Se1zasIhsGaJGd9InswbD4c+DzVnWLDq0OoXgSOfON6Ma8CcgnGkIpdaUVX/gnX
 SZQgGIw4RbmBT+nltsr3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3yvZd4tuLtM=:SLN57n+3vqXDI/u90LBu/z
 khxe6LMhtcG2eVlpUmRXsDP7SApvywda11wtJDvezaC7BGRJsMi7EP9ivatRmS0Q7CLgSxapH
 EEQYOfooZdbbiSMdLQGTL6SN0SbPDcJsudqowdSdrDl9KTQhZqlCAOO93e7xOoy8FPekGmDcC
 ByxBc59gBT5KRoIMZ9R8G8eHkwJCZz6732TUNO2NSJkOmBqvfZLRMfCCUdwvIJp8ZP4uZLKCh
 BM9c8VK+8WkKOea+h8wu2Os1mrnsL/upeuktnjuHWl7dh42k/n8QTgK+3Rd8/QeICYpVe9PHq
 xzrbrfxSJLv6eAjmU1B+071YmALnsCtU3X4xeX3G0Bt/rAXgZQxhtZzBk3676fuhudX5pTJ6p
 piS19mykUGegSqV7lsDV1AwJ1b0lZFA7Lx7CqDZiHDDB6slRBJm9hvNtSPNnSOqBA2dyRdNHD
 BUgZUq5awOKmN+m2mDBP6h26t8kZKIXjVW/NGQymUUjwDffLrcUY9DFWBchEFHRInMT4nxZuj
 yOfn+hTe1eJmvXVLF22WUCtdagiEF4xVysprLqoRGsZ/C3KiOUPxcRhQNTleWS1YKn9IZS6NF
 p0o8k4B7jAuhLvr0M4a+2j79zLzGoBw54Kqj7QOlu4B4VPF16PApHQRn0JxY4cwzScEGR5NhV
 II9o6L6voBhSbBW0F3I/kbVveHf7Ir5briuRKA3T4f681x9MwrpaaSYSkURaII3MDHPc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Line break long compatible property line.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 5d1bc8560dbe..97e2f1822a94 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -6,7 +6,8 @@
 
 / {
 	model = "Toradex Apalis T30 on Apalis Evaluation Board";
-	compatible = "toradex,apalis_t30-eval", "toradex,apalis_t30", "nvidia,tegra30";
+	compatible = "toradex,apalis_t30-eval", "toradex,apalis_t30",
+		     "nvidia,tegra30";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

