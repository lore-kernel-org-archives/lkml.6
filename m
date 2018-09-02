Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF33AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5E20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA5E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeIBOZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:03 -0400
Received: from mout.perfora.net ([74.208.4.196]:54481 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbeIBOZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:03 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1HiQ-1fcY1Y1lfc-00t52h; Sun, 02 Sep 2018 12:09:36 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 10/37] ARM: tegra: colibri_t20: annotate usb ehci instances
Date:   Sun,  2 Sep 2018 12:08:39 +0200
Message-Id: <20180902100906.25792-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:YyRneP7pvhXRiCNe1PMJY4KpJChrbVvukGdNHb0ovinHjsVZE9/
 NM7qXd6Ra8skBrGY8nhIW3rYJ7LHG//NTFsp2dZp/d6/tO041NcAmyYuaqfvbk1wrsOH1D6
 7PRpuRiAzb8kRaeRA43HIXepBQsgx/vd1NG0f4odAJvKb3iemgxvAS2e/BwdpdGu1tWsZVg
 KOEdMRvfX6W1SVNbpe2rQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KUSTm6CAfPc=:9+uJY81xSf4SOBR17BOmZt
 rap6TApQmtecv/8QvkLUTqoyGK23uGUqAewl1wNWO+9RmeJKWhVbQCP4ZhDCtJq4LkvfQI3Yv
 n3F2euAoI9z/3hU4tjbTNzmi/29aGbQjFtEp6HrbG5/DAET62m02O4eKkwCEjt66l+3j66dVz
 gOkggR3aG9JWTT2aCidxLp19tZjHW5iOtiZ7nvDJQINIIJHDpDRb+81PPZQpJ/1PrMLVM9SO7
 KUHtcLKYrm5IJSQCQcIIrcTDadd8u1Q3BXi4pOMfz1hXn71gBu+lNp3aXKt87XNnqMk9wSFYA
 T6XiBz6jguiCGH2U1aCwwuonf5xSdeWIW8WdYwNbsJGfcJBmVCVnY9etBxa0saADSwQATN+yj
 autyAQFIITJMLzUPF5HOGu8QvIhfxzZF4rkA1MeNndXAz0NbMJaTdrFsDkYGL8vRRYkuzUS97
 zHTTYw6dE1kOgklqMNltTqd35schC5s8MHzezgRuTAkOAOa4b8t2NQC55EWitLDbfimsPkSqP
 e1rF8JOcK2gsjelsYNtrofnGQHklnXRRYmpzG6+bCkVB5NecJutN06FP7DBoOxGdMMoqudV0j
 GuARFilj4C44sOwRanyZTIODCKcpSm0dYnUfO3XgtcM59fmomIAhKwYHEc3KTyUim4fTt9RHW
 Pb/izHvgTwUmrSkvTUrfsSSU+Vj9MsyIF4OerXPtqJsUXF32UaCM+7VAEtEctSPftGp8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate USB EHCI instances.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 9f0a819c68f2..194f40646a83 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -83,6 +83,7 @@
 		status = "okay";
 	};
 
+	/* EHCI instance 0: USB1_DP/N -> USBC_P/N */
 	usb@c5000000 {
 		status = "okay";
 	};
@@ -92,6 +93,7 @@
 		vbus-supply = <&reg_usbc_vbus>;
 	};
 
+	/* EHCI instance 2: USB3_DP/N -> USBH_P/N */
 	usb@c5008000 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 5e98f225322b..77e99caf5606 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -454,6 +454,7 @@
 		};
 	};
 
+	/* EHCI instance 1: ULPI PHY -> AX88772B (On-module) */
 	usb@c5004000 {
 		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-- 
2.14.4

