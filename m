Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19385C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D9020841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D9020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeIAMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:09 -0400
Received: from mout.perfora.net ([74.208.4.197]:39209 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbeIAMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:08 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M9peg-1g2dp30U2q-00B1Ee; Sat, 01 Sep 2018 10:13:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 27/34] ARM: tegra: colibri_t30: drop obsolete spidev node
Date:   Sat,  1 Sep 2018 10:12:41 +0200
Message-Id: <20180901081248.22639-28-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:PwjjMfzG72UwalhzBtPu5635TCEXXSdyGNKJNZqWRfdI4QDEnB7
 huIbhxfahRsnBCNOhIWnOhKxFeaM0EGFGYPmpETVzazWkRPVqgrCnuN4QvKGGofvKIKQIBI
 PTd9/7TmqNR3dFxmSQBq0pXfJijMHXEuFVWjiROubJ8DYUZDFbqr4TNHRu6cwq5Q+EFqaE7
 QZbyo8reUlCfSMB99/XyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3CEcc/mTPJI=:2iu6+ppUpniPdEJUkSo9bo
 bjrqBqhYY9VP910RXwupslM6vXvmcS5zk+slDqb0JUsEuGct9v8vUhqloMXueifJ1irMDxUI7
 HRTSm2tl4bWHSwDGqYhZsbMMU28OrR7Ztj0rO2JUe8I1bch+6F0peUgJOE03SIfUPbIZo4PZr
 gy5ertpKX/p3y1TE6jvGB1u/AluXZkDf+W3AblbNcGfp7FAjEbuf2dh4CucTIZwu0T1ebyBIY
 QH32QBMeSFhFrnP7DND7U/zR2KTpcMGGdtfpkpYYe9EtAui0cqOaR1ATS2VrCD7VAbVKwt+2q
 +UzgR+40FfaVTEEYVNdZISa06j2ILWWBRpHzIwxwZMT/JF6o9x30wK4jr4ge+q4tbAZQIFbIf
 M0/8Wr+79B+5ClsCDsD7M2dGU/Xzn4DhJsGly/zHlngd6AJr3B8E7hC7KNO4TEYINr82uuJD4
 0GI+4qeVrPmp1dpH1Q+oHh3ahKm5sftTJtnGR1ESabEm3FsaOI72tBP8lLE0LGpn3iq7Oa/k4
 oP2OXOrHXvQOpaTnoAeSNkAGVWKLICaSSpvSiJuz9mtcLuMQuSL8neBkuZmGRW+qgBvSgvXFW
 GZiYErilxjpJR2aHaUkt10mP9Sv8S9bEKYR+0cTkonMk0+iolDD4V5p0Yz/pFS75R/TcBOrSm
 H0h9YcnLJrLE3evkmi51rG2c359WcqHKAlYp4S9EXg+Rkj7kzVatb/n8tSp5d2Il6lvU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop obsolete spidev device tree node as nowadays one should do this
by binding the spidev driver to specific instances/chip selects at
runtime.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index aca4cd786442..c08e09908578 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -88,12 +88,6 @@
 			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_RISING>;
 			spi-max-frequency = <10000000>;
 		};
-
-		spidev0: spi@1 {
-			compatible = "spidev";
-			reg = <1>;
-			spi-max-frequency = <25000000>;
-		};
 	};
 
 	/* SD/MMC */
-- 
2.14.4

