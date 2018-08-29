Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A413C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307C72086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307C72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeH2MKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:11 -0400
Received: from mout.perfora.net ([74.208.4.194]:51719 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:10 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lwpjy-1fsp2Q3gMK-016P54; Wed, 29 Aug 2018 10:14:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 03/31] ARM: tegra: colibri_t20: iris: annotate i2c busses
Date:   Wed, 29 Aug 2018 10:13:39 +0200
Message-Id: <20180829081407.11304-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:lDjreDzviw84RxciAtdOBSVjBBW4wLMdGhF9zO+2u+/G6QU6msH
 uRBPUJtmR8rvz0zwsYo+g6t2HXM648UAImhZrLIgJalai6G1Ae6rhKGt5OKT/Mk/OrGX4+D
 7cNnTR1PzLKBfl2aAtD4rktPi4TFfJdHGVzjufVFOM84P3AtPrywQK/hpw1ZxPstfxQXd6K
 UWm19wp04FFupU4o95FAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UYI3hiVirCw=:V2ddednRPm7/M1Xxyu1WiA
 Wi9lIUxDLimf8/HHLNNA4yPq0qBBZ0DcnhlZmg6A8Ig473EFVvqnklz94cltVCnxwsMplsEeX
 bDbgdcFfJT7bXBwqY6SPoYTaFyXVwgFPCMtZYzJ10ROdZptovHWSNPwQ4gaVKMsUrIxcW/jI3
 WF/czeUrqVGuD2XcKNCB79Wd2ppXNii7kct5vPV4Km/83S+JpajUvkNsm5NFcLaDQKAufGhfd
 k/hTCqDLIHRcI6oAhYV0ni3OBZ7xtj9o85MvDhzfJq6zz7uSGIliTK9Tw+03Tm6OJ6Unk9Zxc
 BGq7Jsa2QBkNNCSybxXljKMXbnFxl3rHV4sy6aqJBdojQlHkKnUlyxkKebzW1yG3m1vwxnfzy
 z0R4uKM5mh3nlWP97Mu5udlFAIdpH1r/2GaHdqIa2pikZH5QNcmxv8dr+urSIghRAf7cVYD90
 mn5GWWkcOPpxO2bjaV3pWNlYqAitZJiF2X310luV8hDwAQF/mLFQ3uZaOLdJRRfTdn5l+3PZv
 yZBWn9VMjDnQVUg7cLz2VjmAvfeAtxjOi+YqPGxiZvusmTqymXMi2J9yOFENwSwPSFSPMWP/E
 8H/YYwEfhkdi5l0YfrzRtvNvTDJfCfbb/xfCmPUNx0KTCY6JEhXLPIZB5yZjHlN5KAXiXu95u
 5YI7/I00N8kKUd2/lraCeqlqmijx/MycjKzYVD6WSjl6hi5b+DUl6Op2BoPA0BsxoIRA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate I2C busses: GEN2_I2C and CAM_I2C (I2C3) being unused and
DDC_CLOCK/DATA on X3 pin 15/16 e.g. used for display EDID.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index b6d05da8c93c..cbf1f4d76813 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -8,10 +8,12 @@
 	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
 
 	aliases {
-		rtc0 = "/i2c@7000d000/tps6586x@34";
-		rtc1 = "/rtc@7000e000";
+		rtc0 = "/i2c@7000c000/rtc@68";
+		rtc1 = "/i2c@7000d000/tps6586x@34";
+		rtc2 = "/rtc@7000e000";
 		serial0 = &uarta;
 		serial1 = &uartd;
+		serial2 = &uartb;
 	};
 
 	chosen {
-- 
2.14.4

