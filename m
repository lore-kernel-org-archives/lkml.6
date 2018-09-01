Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBE1C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517DA2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517DA2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIAM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:26:16 -0400
Received: from mout.perfora.net ([74.208.4.197]:39895 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeIAMYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:55 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M6Tdt-1fgQ1a3Vxj-00ySgF; Sat, 01 Sep 2018 10:13:38 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 19/34] ARM: tegra: colibri_t30: move input include to carrier board
Date:   Sat,  1 Sep 2018 10:12:33 +0200
Message-Id: <20180901081248.22639-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:5Gohqd9kFdA9bCEPgOQKXNdKUktXNst36WlONK4cEXZ8++EwkYL
 9VYZ6PvO2SWXx0K9Jc1FMASrEUNelJmcSv9MHyUv0apoSHcfOM3rdOcIFslls+swUdWhx96
 wtvS2RixdHDH2j7bJdHM6cQYFcZ16TymygwvHATDW7EQRHMuR5gxJhv3b9drbH+zIhtESOk
 HmNb9KgZ4IqcDUWI48sTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RoeRa1RCFwE=:KgnzrJfLFZQRjPAjMw4Bp0
 Vata+OP1laqUA1h9Z2l3ps/5AsEwPHJQ9PxRQTLPTDt2u0wff5B3G75T3a5kl9Aw65zXjMafD
 DjpO3p5oCju3N+q4PADuamOy2k/eC4G45NIGf4tYIc6IwJo8+pojeC92aHgjXqURkdlfCdLxV
 JyQQfPj3/YfXoj96D3/IAD4gn1abgcA/5DO3Ik31YCivRwDmBVTV4+jfQeIYsveujFCkw4tuD
 qXkD8CwMk+ynqBbkFmvnsptutyyR2q0oq7BVWml+xVh93K3na2WiRuyIlpMOfRoBPaOkDDUI5
 VQ2LjMY70LNrjSE3bIEK/b+J2ffC6AtfhpFvDYeEXsNzwhf19CvSvXlnXIy/C6mw2LxKz3Kzo
 2mZffAgzcBl9MdG1rlYCZs6xShw5VkTyVyoQvUGQSkcNTEFZws6ANi8Lq2EhvvKPGBqTB/dAR
 PtKBnail1QJ0lViohXrEJlJot3/gFONLy1aoQ9EEF78j2ux8Fs8UhlrZWsasEdyyo2LiofDvv
 tJJrDRr80/FM8yDT3Z3YSZNS3rDJr/fuWby6uAoTqUH3Ud4oaLcnH4/pdCJu8auAJeY1iU9Uu
 QlVl76oukYdBX9m+2WAfUEGsCW3fVBSFbIm00VtGz5ow+bGfyUQETeus552iVf1P/XbT1up7I
 u7EeUEf6fWEIxhLun7LSMoMGgcPl19xcjjzVfZVKW7aSU11EROg7l5ITvCC+anC7b7G0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move input include to carrier board.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 1 +
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index d8ee7edb24cf..16f5e6af68b9 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "tegra30-colibri.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 4fcdc93ae687..0d8b0f319c6f 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/input/input.h>
 #include "tegra30.dtsi"
 
 /*
-- 
2.14.4

