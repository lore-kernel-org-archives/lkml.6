Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A47CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D2920843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D2920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeIARRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:49 -0400
Received: from mout.perfora.net ([74.208.4.194]:46593 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbeIARRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:49 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MYMgJ-1gRHes3ej3-00V9ep; Sat, 01 Sep 2018 15:05:40 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 13/19] ARM: tegra: apalis-tk1: reorder SD card properties
Date:   Sat,  1 Sep 2018 15:04:58 +0200
Message-Id: <20180901130504.14318-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:h0kvUykim3i3r9D8AfeGlIklFg9qTvP9jPGQjWEtX//gxQNnqH7
 OWH2ejiJKEjCg/GEKHYMCYSXLcKqPlhKia5WED0UnbpXowTvub3bRjgN6Q8uxhbKSFIEPiP
 5EmuZdm2nJArMqO62KzEhUNksZ/tXIpJDGgrWD6TLFLAkRP2KOrN13X8S1hEYpksJx9OmsR
 XCSd9MdDUyms9NBGZJIWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6YeXCvv0huk=:TYUMwm2J79MR5CJoMuQBDt
 17cJTbFSAOiO/WfPhGwtDYkYrIJqL3/ocHadxTE0lddbPAO4NWqdDtb4MX85YDEmalXWykg26
 3TSQ0/awqOmszxF3I172L/PtgFVS8BXdBlZEo0T0NDi6jFCyv+Ea3j4/OlUh+yfKCENyZG8Ap
 VogRbH2+S6eiBJFa0/AWVxZs6rmqsZ7C5OBGflynbHsX+czrkZfXQ8jakWiO+368bHEK0ZtjN
 +oE4X74+lwcUgT6/13jq/ms+B56TPADkQjuMOL0MfqhE96pqAPUD5jy7qNhH8BgBdJJoRVkyf
 zRu8q+w+TZ87A/ibTK5mqm67dphTjdc7Ayoiomp+xbyMCkPtiPx980GixEHVWJlfLNOT1u1nr
 5ltY06Nfo7uUzu1Djd8fnB+ilQ8t6o1zzKLUtRA6E9OB6QGPMG0xwSwmdOQAB/bT4RpI7epIt
 S7ZSzdM8WVOaChhsq/K77w+yhcP9iAB5hGxS4qab1KjoH42AATnV3+FtI9VB/hw3FNyGxXH+n
 MQfrjDQMXA4230ZRau3wLaE3RJat2adf4tna+pFUNyM/o9OAMg8Pdrcr2EV63ND8LV1SpNi2P
 GHH9o1Ns32jpIVQFhKofTci0kTCdc5YOXn9LYVD92LrhVqyHnpHTSum8s9AADrypieo2kpbpw
 As82s+JLiLB2WfkdTn4GkjDun5mVgYB3mIBBE1Jj3xyWdYh54tL3og47AN0XsaWxqGY4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder SD card properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 4 ++--
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index d9805fc97f5e..08f60636441d 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -180,18 +180,18 @@
 	/* Apalis MMC1 */
 	sdhci@700b0000 {
 		status = "okay";
+		bus-width = <4>;
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc1>;
 	};
 
 	/* Apalis SD1 */
 	sdhci@700b0400 {
 		status = "okay";
+		bus-width = <4>;
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc3>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 89783fe76f65..97c56e82c51d 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -146,18 +146,18 @@
 	/* Apalis MMC1 */
 	sdhci@700b0000 {
 		status = "okay";
+		bus-width = <4>;
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc1>;
 	};
 
 	/* Apalis SD1 */
 	sdhci@700b0400 {
 		status = "okay";
+		bus-width = <4>;
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc3>;
 	};
 
-- 
2.14.4

