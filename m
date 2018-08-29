Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D35C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251862086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251862086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeH2MMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:12:39 -0400
Received: from mout.perfora.net ([74.208.4.194]:35957 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbeH2MKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:25 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MT99c-1gJdjY1ZvK-00S9Am; Wed, 29 Aug 2018 10:14:34 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 10/31] ARM: tegra: colibri_t20: annotate usb ehci instances
Date:   Wed, 29 Aug 2018 10:13:46 +0200
Message-Id: <20180829081407.11304-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:JQCMFluUgbhOcQE222J5Mrk94rKsPd7E56yhDAODnpSpFtl/fBv
 eBZUySLPA64g0ML8CVP1wqzWKrVSeDtRBk483oTtdo7hjz8Ad1bo4ZECFq2DqoKN2AZYVFu
 wya2lqQWNGVcoBE2mTZdGHDaq5E6W43xgJjR2525ct3tjqQmh0dcScXZ/4giyIL7xl4WG4H
 te0diM7Y3aJih+Lk1c0jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LsOZWgUx27c=:A+pWbX/63ihoUFUZKDl8Uo
 QKG20yv9dnaN8OKbnbe5kWV4beGxtMcs3GONxOjipJZS03FmkoEG9bQCdXFiv8INw6KpSPCfK
 g+cWyHmjVzvm2jjNNcHFU0ojGZOaqFwLJaMSzwq5A7z+OXCPg+Tcm9xYqJqixntTv1m12VWBy
 icJ9w4bDjI3ZTyK3XGO7OrR11dWYqwDsfbhGxGOWicNxUPhdaVL6GV16BrzlPrwfGrLSjwvQG
 NtcylI90aR4G1i/VeGY2PGOBZniXy7lOQCLGTJa2VziZdM7hezgPsEwLWSDZqhA5JHudEORXs
 bDk1lFulfJclA9GvC2Sd0G3jl17Oyz/XnOmqr/T1VWP3iQaDH9FRsp8iV6n8jyb+Og8+dRwRJ
 TV8s4By7pA7yc32DKd0mJnHMaD3M2jMwY4ABL+SL31zNZcBAs4dk0uXhc+iTXUUocM8p0loge
 rGuLcwf7Y9PnsyAwp3/MJMDAJF42pjy8Df3fYrV3O2c26s8NWNpLTwUFfB2xn/nvFzwSaWnwS
 damZazr/XBudX1wFjndUzCmLwA+g+kXqepXVcEMLveswFCttRRLGROW6L3/UBxHeBXKUkIgsZ
 hczZzFcCS5Ewdz2GHAajvzCW9829bmH5CoU/EbIp2ZKO3emIDrzonSuG/XII6nf3Zu7YFCu+5
 Wo+JcwxTDVMoos2pWKzxILUhVVbyCn1rvST8YKB6tRt9ZnBfKjRBfMU60q9KtHQSQMfo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate USB EHCI instances.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

