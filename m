Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0E6C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED4220845
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED4220845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeIARRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:51 -0400
Received: from mout.perfora.net ([74.208.4.194]:41801 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbeIARRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:50 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M7rcM-1fiq2R21zM-00vRvy; Sat, 01 Sep 2018 15:05:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 15/19] ARM: tegra: apalis-tk1: drop obsolete spidev nodes
Date:   Sat,  1 Sep 2018 15:05:00 +0200
Message-Id: <20180901130504.14318-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:KOBDsPwlc/fFjht9++CFl13jhTVKO8/2u5fSVC6KAcXoitfWjUT
 8ZTKsxyeZjKsNTxMDcHl2ZJCpMzU+UWCmtYj9m6hdkIE9OM/cpdfB3qDu5C/Kj6H0F5Nllv
 FD4BVhhiDrakbVfzR5QqHJQFTFeHfuWOHxKoC+vZ6pFZJUf8IRT11BWW0yqtALML9JPC2iT
 TSfPFjVB8Qu96fzk7i2aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2qBiZIP9okE=:PXfv/bNqNLcArnEQbXYirP
 YR3HFy3Z1sEvVjXnpHE+aTk0VMBsIWcYsz5LSvcIPbi/iiP305+rzFfmP/tMx7sw+D7jEJZwy
 +ExS4ndEpQus7S/sk1UBKUmKNs263r5KnNqDbbCYqtc26C7GzNx3Cha9MEve0hlPi3lBRA4lr
 ccDeCREgtoIez9lpvgmGR2Drt7eE/ddXtYVeZ+aJPvs61EK9JCc+KE0nnVI2q1sGxgqkCnJih
 9e3S+edeulRflyP76qO9HDKyfRxF3p23JBBHGGlZbg88nCM4f2Pu1tF3S8GlJ8TVIYMdEgzNu
 yDzkWelw3M1ARcYlh0Q46je08/QrBx+h5wewGJQO2VlgCF8VcbyPb7ySshg8/OPBH7u8/QJnH
 mlhvGtzDgEpzhW8Y0tVltA4CSM1ZSF5vNN32DaQ2sWoGpzQOz8GeAKbLHXr/RKotaD08LMZ/9
 iX4he6XtLiE/bMkeNTseFg9QzTkyY5XoaZINMhM2NDTkV84y32YUf3oibjAhDzEYl/TQJsXrO
 PKQFFaNjVU4UviNBJzjmd9XmZ1w0rVayN8oglxofY9I2dh0xrS/mVKn7voSbaVimJRv2Eoha/
 cdJK30BM6/iq6hmok9nsvYx5pWnGSQWoYuRO7tUykYevxPiIZhwssKlV7V0qO/p9PxourRlOG
 y523S3YtHEn3AVE/g0i2FKWNApW6Q1nmZPQRKBwTfIWE/OwHXceSWaEbh19adzf0fmwE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop obsolete spidev device tree nodes as nowadays one should do this
by binding the spidev driver to specific instances/chip selects at
runtime.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 12 ------------
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 08f60636441d..2710eb79b63e 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -142,24 +142,12 @@
 	spi@7000d400 {
 		status = "okay";
 		spi-max-frequency = <50000000>;
-
-		spidev0: spidev@0 {
-			compatible = "spidev";
-			reg = <0>;
-			spi-max-frequency = <50000000>;
-		};
 	};
 
 	/* SPI4: Apalis SPI2 */
 	spi@7000da00 {
 		status = "okay";
 		spi-max-frequency = <50000000>;
-
-		spidev1: spidev@0 {
-			compatible = "spidev";
-			reg = <0>;
-			spi-max-frequency = <50000000>;
-		};
 	};
 
 	/* Apalis Serial ATA */
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 97c56e82c51d..574780250031 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -108,24 +108,12 @@
 	spi@7000d400 {
 		status = "okay";
 		spi-max-frequency = <50000000>;
-
-		spidev0: spidev@0 {
-			compatible = "spidev";
-			reg = <0>;
-			spi-max-frequency = <50000000>;
-		};
 	};
 
 	/* SPI4: Apalis SPI2 */
 	spi@7000da00 {
 		status = "okay";
 		spi-max-frequency = <50000000>;
-
-		spidev1: spidev@0 {
-			compatible = "spidev";
-			reg = <0>;
-			spi-max-frequency = <50000000>;
-		};
 	};
 
 	/* Apalis Serial ATA */
-- 
2.14.4

