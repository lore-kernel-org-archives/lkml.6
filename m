Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5958AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7B920841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7B920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIBOZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:21 -0400
Received: from mout.perfora.net ([74.208.4.197]:53423 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeIBOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:21 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MG8Zd-1g9pBJ0PO3-00FJTY; Sun, 02 Sep 2018 12:09:58 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 22/37] ARM: tegra: colibri_t20: annotate/rename lm95245 temperature sensor
Date:   Sun,  2 Sep 2018 12:08:51 +0200
Message-Id: <20180902100906.25792-23-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:pq7wjv1nAnNG7mYCn7ZGRz7iv59kMqYW4rfFdvG2BOjHMZYDiiQ
 lIhnoKWaz0ulbhy/9J/frpYNNFgxfL8zF2iSmShe6hLOFyNoN6W2fhW7I/9KDzaSAk1l4ar
 dhWSoTBr/6reZ7/qbr8/kYSoyIR/COI5Uqpv+2kxdghncUduTUboP5NuR4Cyii4dtHJX/1J
 N9CA/WIxc/khcJ0ulFaOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3vyB3Bwr+/0=:5DVnvDOrU5SOi0q9Os5tgy
 hEjltr9ZvueelOugSfTZbEGKB0BgLWR/D30wiv0lgj0fxIV0qNzzs12zmnpmdSK1tmeroBcPq
 xs9bJnJ1tvTUfFGEXEWrMWqiDco31cmB2UiR72CP/IF8j3PeM2aTOWzune/bA4cj+HrMfEXQt
 +OS97ndzqeCSdyxd30ASSmqWb6xS6F/hzH1s61HWCMKJCHdDhQxh7mqPUtxFtHEO6x44fOjFX
 BcURE344EPAWPa4z9nTFvCdUz7crrQVor8awTP7VAeGaoidyZdjpBnoFouTtH2S5d96DOnkZr
 hoYrrtKCaDxmCxwLfGX6AsljuZvdMss4jAOIFiwVngNr4EjfM0ysEwuuOvKZJtRo/bEfve5Di
 SRt1CxQVINXXtlgWZ3zXI0YjzYN+wX50EkSaH/FcH2U9KclPtNh7vdqPyxtukc8ltOyeaixn6
 LSkrL3DpxyagOrubKZHBA1G+wEOfAbt2xQUwlaW/JeLDlJT/1op787CP8lFm8VH8YHo3qbK4t
 TWqtMux4sUVAaoK/eve8zcSeBo3nDJFBT/aLDqnMB7e94Y/FJfoePi4kxuxIp3xLS+I3F5VXX
 6yKz9MJC8PUfzpPjDiERa/L4UJGK+772qPqw39GQO+hnyCCgTvRr9sP4X1Xb7Np9aOOnvDOiC
 0jLHvsr+QPLygrgnD2fnh0vsInTfJ5QRyn3WUCUfvTcfvi7Z3MYgQyDMb/1cXkqKvYqY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename and annotate LM95245 temperature sensor more in-line with our
other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 86bfe77d9230..477d67ff74c6 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -584,7 +584,8 @@
 			};
 		};
 
-		temperature-sensor@4c {
+		/* LM95245 temperature sensor */
+		temp-sensor@4c {
 			compatible = "national,lm95245";
 			reg = <0x4c>;
 		};
-- 
2.14.4

