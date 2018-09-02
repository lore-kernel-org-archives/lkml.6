Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5175120841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5175120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeIBO21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:28:27 -0400
Received: from mout.perfora.net ([74.208.4.196]:40303 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbeIBOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MBkrR-1g5RTf2i6J-00Atci; Sun, 02 Sep 2018 12:09:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 04/37] ARM: tegra: colibri_t20: iris: annotate i2c busses
Date:   Sun,  2 Sep 2018 12:08:33 +0200
Message-Id: <20180902100906.25792-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:N5VI6ED0bgo1ychLu2RYpGLSF3MYxsdOwKDjAtU4mSl3S1iSyLB
 E2dKwxlIMCD9CmXmKpStLGojtONeHKRLbnDuag5so/fXv1ET9CTgZZfHDEgLKegEKKBL96w
 +ruOn4BpMQr1kE5glMM9DXpou+S2NHaiBWnf7NRKv5ap2ar76wSjP78w2sUFiVREJHEkk3C
 zystico2pGwH4tFkLOAzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m3os0d+0hlc=:OQuD1n4oKS6Re7Gb6ZGGlS
 7sNXxhQLvqONQobeXt1xxezMjWKt1b0D7cvNc7fv2TbZh9bIivigaowCN/qywHIKBLDzOEO78
 W9O4CxF9P50E8b3P76QI8DW0SzVYKyznhREHli1aB1aU/jc88XNsc8MCaI66qHC/gFnEiroQ4
 LYaBfKgmmeF78exUeHQ135nnAr+leyR5nbC3Tg5j1C5z3LQG562/B9H7E1ftK5w1ph7SCT0EC
 QVyMlP7AQYQ9tCWh1wTLpb9bhjSmY2i6kHBoq1qWcY8HUvzycbAg9ivNjENQkdWO5VWh2GQPB
 4kLBtAfZif6T8Z9mhWuPnqAihkZY2ZTKs5UKXrorI8LPfY3G6Oh+HcQufEe1HlI1gr4RqD+UN
 RG7f7qEAAnoivl8NYXt3teuE/fLDzb+lN9nfE/XCYulIGdPerJrps4ZuJZUzXS/xlWmeFXSjf
 QuAItDGdi+qYQyNKzKcGoQ5Ixa5mijsDBgLBdlGC3fxhPAEjRG/NE/yDk/z1DgofMQ52jf556
 JBa29uK1a2LUhQHyT1EdNPt7RbMn4HIuYtpJuxQoLNucLlxF4Zis5E6pRBsQ/+Ux9geVpTAGO
 3WZDZz6t4XY4noJXSU8+5LpYtTryro+qUbKiKOQCyZD4yXqI69DBqj9MBsz3nNnLROgqXvhFy
 Mf6nRxvbS9Seqt4oZhlfiBOD3TRrj9hLgnMuAFR5XeuppSacB+O8WX5HpUeAMqvaDGVw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate I2C busses: GEN2_I2C and CAM_I2C (I2C3) being unused and
DDC_CLOCK/DATA on X3 pin 15/16 e.g. used for display EDID.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Fix commit message which was mixed up between "[PATCH 03/31] ARM:
  tegra: colibri_t20: iris: annotate i2c busses" and "[PATCH 04/31] ARM:
  tegra: colibri_t20: iris: add missing aliases".

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index cbf1f4d76813..cc9e372a3b58 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -73,6 +73,11 @@
 		};
 	};
 
+	/* GEN2_I2C: unused */
+
+	/* CAM_I2C (I2C3): unused */
+
+	/* DDC_CLOCK/DATA on X3 pin 15/16 (e.g. display EDID) */
 	i2c_ddc: i2c@7000c400 {
 		status = "okay";
 	};
-- 
2.14.4

