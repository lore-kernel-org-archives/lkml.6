Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9125ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3C120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3C120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbeGWNi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:26 -0400
Received: from mout.perfora.net ([74.208.4.197]:44749 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbeGWNiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:25 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MV45z-1fVBSQ3N53-00YU6q; Mon, 23 Jul 2018 14:37:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 06/26] ARM: tegra: colibri_t30: annotate uarts
Date:   Mon, 23 Jul 2018 14:36:37 +0200
Message-Id: <20180723123658.980-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ZVFVGV0mMwHzXoaMh4zZKF9otRr+umMI58pPHznVl+UdQisr2vP
 UfP8p1s2UcgiLTwnzbsyjQY/j8YtEXzcafTktZjO8j8P23Ns4o1vMm9nJ4pau37jm8cIPVb
 1Z86MC9l06EQR+R+sCUZpjvGWxwhiR0H0e6Zz54DFNfxF/3S02IP6c3Ha5R/IAR1JFRJtU0
 QCf/w9fiM0AsOxDxPyCyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CP/L8lSETmE=:17l54NljAW+IqAAMsUTWIx
 wMRIKHKagO5vs9ya5ImuxMS5JLAfRDKp2jlPyJhhBrDiyZUeDlPfT3K6+Z9AWSsUpdlVvK2Xi
 0515uByzivgF5C9s1wUR1Tj1a/1YSNED65o6CuVNNfFcMz2o3fm94GAkmFP0ciK/WmmHVbaVZ
 JFuMFTHhYpo6baO8UIYf86jAHrYlNNsnLmHPAT6FDfnL0RGkS560u5gerxXaA6khvUaRsMH12
 F8Rm+9lNlhA7Bq3VyWiqi/QoTfK16ftWquEMnXwGNzDV4e8PZx2U+7GvNCZh0D7HroEbWPD6J
 k8DPr+h8/+JstGrtrc7ZfO0ZhMcUsAWBwYGhMAV6gjW2ZEnEJd5BwLGFbpR1oceelY3p48b9f
 BD/ZOx2bIgcDSqhuSFi7TkHyvxgOiEOZg4cYPAEh+mf0d2RU5itsYb+WKeZXcvv/BR0NG9Rhu
 05OjRdU3jwGKAppVYy0E6btuubQHpG+nrXMWNY0c7/V9pDEwEk/1dhfYd6My8DVmfn03rt4vB
 r/1SvyIH/fjgvow29KGb7PNzGrCpSak4jRv+uL/KwyWux7msaxNrEt1DN808z1A/4iYt75U/D
 1z5rQI5y03t3WygFkdG3KBMXb3miQKVkIP5DyI/DdDYidi+Fm+uHp+3aMK4CBwLObLL4jBJ9+
 5K26DXsOHC0rghLe0rA+eB5eqYOiAfd7jh1XyvRW4OWRkzrs7PdcWPvcKpWCzZCfvmzY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate UARTs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 1c057b285153..5b32a70ceff2 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -33,15 +33,18 @@
 		};
 	};
 
+	/* Colibri UART-A */
 	serial@70006000 {
 		status = "okay";
 	};
 
+	/* Colibri UART-C */
 	serial@70006040 {
 		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
+	/* Colibri UART-B */
 	serial@70006300 {
 		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
-- 
2.14.4

