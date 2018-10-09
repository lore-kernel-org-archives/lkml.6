Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB2C2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB2C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJIWnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:31 -0400
Received: from mout.perfora.net ([74.208.4.197]:36945 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeJIWnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:18 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M4pkR-1fkgX20Lld-00yvpG; Tue, 09 Oct 2018 17:25:41 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M4pkR-1fkgX20Lld-00yvpG; Tue, 09 Oct 2018 17:25:41 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 6/8] ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
Date:   Tue,  9 Oct 2018 17:25:21 +0200
Message-Id: <20181009152523.3771-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009152523.3771-1-marcel@ziswiler.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:bVpVhmcYoxxIRYXYybXIx0ljwVnPhyjwK5LcnMy2TmYLcuaHIdR
 kIvlYOPgFN54gahb9j5BLGOM6NBj7C18uR3RhjH0LzX5qSA0wKP19ahrmv2wIPYhpFoAEMx
 8qbshpNBZ8tWlXBK2SmRc5miGjdSk7tbCzVQYL7KFMnWBP77s5sTXhWXCaRiy8Lh8BpqptN
 NKKYMYmDek1PHuSAq2LJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0fPFcPXQE7c=:D5S41a/8aqULACxTmwHHUr
 c3ePDTKnXa/WNCzcyJaPtKIQT5ECihnVZ1hLgb0WclxIZ5ANsMCEtZB2L/uSPmupq+iVmglDI
 iz4u7N2u8Xmbtu7RqwFv8szRNI3WKLhe1kev07uIHXPUlcHvavi4JOHvpvrOLr5YIyPPNSeJB
 0QPsIL3nk04489Ai30+geaoTjcqmco26Hq7coy68iGatPTYeYXiakowAwSpaAD4CKlXich2f+
 bop4V2pbGCkmMzl8nPfxb6rbY8fT6Heoa3fxoCt0btaVs2ETLQ6qegYQz7YZQ9K6/VnHfRUup
 Hbx7CuNfcvyy+ZxxiB0J9GMxc8u81F1b5zUP9po4NEsXJT7QfS+NV4IQBPQ+sns/gHmnuCp+K
 ooeCszElA8hpyqo9NaJM2E7BXlqxnjCj2Au92LEPfp2D0pyu4cVMLkOi6DO2FRZ1Ck27iJO7c
 0Efl5e22otbwso4YFzOcn59zxgtuUJ8a97rGnFWJF/TqG7A4WDNcx+lgCeKb4tlLYypNapzf3
 HhRqzvQ135JEx5oguhi9T0sbBKzpbu8DoUqYx/IBogE3mn6w2E0+VYXlVhASyYJsnKJLT5Ysy
 baopRCVKxnzFm4ehTjeGg5vYWwHPginBwNndOvbeAtNJhEs9L8cU6AMjC/NZIQqZ8A8jbHgjH
 b9Owm2q+xivVel8lInn3GEoVAgzdU7oSIQcH9v3wRXuGFX2RJrfEzbVj2ehmvCe0boy0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The power I2C bus aka PWR_I2C which connects to the audio codec, PMIC,
temperature sensor and touch screen controller is really on-module only.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v1: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 5 ++++-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 5 ++++-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi  | 2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi       | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index e532b564e4c9..0d095729b46b 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1552,7 +1552,10 @@
 		clock-frequency = <10000>;
 	};
 
-	/* PWR_I2C: power I2C to audio codec, PMIC and temperature sensor */
+	/*
+	 * PWR_I2C: power I2C to audio codec, PMIC and temperature sensor
+	 * (On-module)
+	 */
 	i2c@7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 3cab9bda918f..13127415d86b 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1582,7 +1582,10 @@
 		clock-frequency = <10000>;
 	};
 
-	/* PWR_I2C: power I2C to audio codec, PMIC and temperature sensor */
+	/*
+	 * PWR_I2C: power I2C to audio codec, PMIC and temperature sensor
+	 * (On-module)
+	 */
 	i2c@7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
index 065a24ac1052..05e412a7ea17 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -845,7 +845,7 @@
 
 	/*
 	 * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
-	 * touch screen controller
+	 * touch screen controller (On-module)
 	 */
 	i2c@7000d000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 6727c5868425..0f0d0ae93075 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -836,7 +836,7 @@
 
 	/*
 	 * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
-	 * touch screen controller
+	 * touch screen controller (On-module)
 	 */
 	i2c@7000d000 {
 		status = "okay";
-- 
2.14.4

