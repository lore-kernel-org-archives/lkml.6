Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF11C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CFB2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CFB2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeH2MKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:12 -0400
Received: from mout.perfora.net ([74.208.4.194]:49969 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:12 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Ma46L-1gDHwh461P-00Lqht; Wed, 29 Aug 2018 10:14:21 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 04/31] ARM: tegra: colibri_t20: iris: add missing aliases
Date:   Wed, 29 Aug 2018 10:13:40 +0200
Message-Id: <20180829081407.11304-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:DkG42YXucHmbRVZo5Pi4HXUhlpN/ET5eAoGWjuOATIJy3Jmy8dt
 shQJ8519Z5/c6hAIe4wZoXSWn8hdQGG+1Vcz4Kwp26LQsjL5fOc1/1zTex7UuW2jeU59fDz
 quo4wpmp101yIiDcoe1lLg51Y7S6vgBdOLLhPy894eQ1vAahMhpC3mTKAsOwzqYZkVHaSI5
 IdPskQHt8iathZEj0LewA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CNPwjK6F5uI=:ivzZUEz0kwPy3gxQT+6wG1
 Hg2gCpwARPjWSFCRm3fccz0RymA6h2q5hNkz+qPhpffi3dBHJ521VG1knEaxEQrh64Xtu9q1q
 Z7J1XQ9Xaqm4VK3qVk1HbcxGBYO7cN7GbnRUAhS7sJMnA3mWo9jDcg7YPUXE38tSZHYmRikHR
 GFGpSggeRM+pCbjAPoWUMnOcRyBVzZaHgROw+EbrXl0SnucQ+x15i+Hvet2YCU1+MI4zjmCbn
 8riLO+55hesKayf2XAWPIPpRBGTrrIKYM53KZSj/tIKBb4NvJGPe8MirtIucxVdT9kDfQ1Y1D
 447W96p/TP6upoIXfPOhNKHCiaQPgwKmm00FFD1xMrIfgUQqCmPCshwiHakBOxMQplgLtpTRF
 /R6YwYhMmh6iZmbLVicctqAxFcBQJPW27n0pxhX3VLMzhVgwSBt2kECJX27kY23UbysJRwTGf
 gJKBcTSOWP0t16+n+I3qVRKIVRB8xoii90hKqj2kGsSiXJ1TWtPevmxFGxy/3yKewywJXGztC
 t4VipCrSqtu2LeoPh9VCtcDkwCXzsZR06guvKBPuYVfUWgwinqLqwpbtEQ+jAdAHW/AR3qwRq
 NSwnQ50wu99IU3A2bfOQZeha2nYE2Nx168Vto711gHCbEEixsz+6Rkncbt6biK9IidtoqUQ7j
 WsWxCaAxjgDxdFvuomPpjb9mpmJzICIhM5E6ROozf4r37v8NeXJUmjkFo8TMPH9KNjHo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add rtc0 being the ultra low-power I2C one as found on the carrier board
and the 3rd UART being NVIDIA's UARTB.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

