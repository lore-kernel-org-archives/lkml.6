Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F92ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23E420874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23E420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbeGVRrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:41 -0400
Received: from mout.perfora.net ([74.208.4.194]:44109 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:41 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MfYHF-1fOMyF2RX1-00P7wK; Sun, 22 Jul 2018 18:50:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 14/28] ARM: tegra: apalis_t30: annotate mmc1/sd1
Date:   Sun, 22 Jul 2018 18:49:22 +0200
Message-Id: <20180722164936.20581-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:hB3GdsgfwxHWtF1b9iHqhc0a+ao+nn9i1KHzu5+5V5Vr03BIr9Z
 lkxM/usNCbX8g2cC0inQ328lhBjZ60DMJzwo6JEzQN7BeGL/IFs48txXuezUvIvFTGu4O/m
 UJ1e7gGhXdZkbeFuwkAajE3AEDQIj7MRMdRDo2IDHD7P+H0HbwGPeSmu4Ec2xKO2NKDvIH0
 tja+I5FUxv6TvocBDpPgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3R5h7AQPkeA=:cyrYWinHsBrss+J0phF9e/
 CDicsUbNi0vmcFboxmEngRsMw1G6hkIyjbTl1XL6pN8yML1LdPMNTOyu/rvGL95MRJ9HwznWw
 jxFYG+uDcsR1YnGN4NTQrB8KglVNeoYqzfZXJ+78gkgj8to1Rbu21qF5EK1pSoFnRYfNK5wjz
 RFDIbFaLNSD59O+jJxzxopjFjwIERxImoVakhXf0qcEeYxCsKEJD0hm8QWdUXt4++MjiYRjc6
 4ALQwNoArFk1EVU8rgHiMe91zH6y2rx5Xks0snOC04aiiFpIYh78k9ECnQsbV2tOOlk0YFAws
 tBYt4T4tsFFeNKHsjtK3wIYsG49bGKBwDplLCa91mf0ONcHgrChw/uwHEW9k8T0ZHa5+NkKKd
 eQveSiDI5Cf7FMAD/PYqgQVpM7BjDGPbv1P4ZCzfczjDh4+0qlhCH1P691fgDKLN4pZpue1sH
 O/PNP/LvKG5TplMdzWQmQ0q4n/Si7f8JR1YluadxTnC2kUWd2iTzyJ4wiLmQ+efXjRq1uwTOa
 qN3iXyHMo7QffFFR53PiT2F37vxVuKPBpk2KnF3gnj3ngUz+AOxejifeye0vksoq2Ko8GLi9X
 6IBUw/OByRN1zfTu6CgxAn9uETiFzlBkg8sXdho32GALK3ub5FN4Egc19Xua3Hf56ewsopOUI
 988bsd+s+BFnuloOcJVFuyC7PRLVO0K22A6TAaVWZwcfyEqpMFX7F0WuEC/cOUDAGU+U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate MMC1/SD1.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 078b1061fb26..a1ae4c3ee39c 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -142,6 +142,7 @@
 		status = "okay";
 	};
 
+	/* Apalis SD1 */
 	sdhci@78000000 {
 		status = "okay";
 		bus-width = <4>;
@@ -150,6 +151,7 @@
 		no-1-8-v;
 	};
 
+	/* Apalis MMC1 */
 	sdhci@78000400 {
 		status = "okay";
 		bus-width = <8>;
-- 
2.14.4

