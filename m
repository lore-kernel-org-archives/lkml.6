Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B742C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABEE20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABEE20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeIBOZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:28 -0400
Received: from mout.perfora.net ([74.208.4.197]:56677 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeIBOZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:27 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MZW8Z-1gChn80P7t-00LOFi; Sun, 02 Sep 2018 12:10:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 27/37] ARM: tegra: colibri_t20: add compatibility comment
Date:   Sun,  2 Sep 2018 12:08:56 +0200
Message-Id: <20180902100906.25792-28-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:NEX7TsJGxcdobVRD3SppjxNGT/clFcHxutk2qCnXW3qS2In4h68
 SyB7QPsTgLltH92H5X5LjizAKhx9ipdkfOqpgoixqZBMa6vnv/Rv1R1zyNju4kDrW63e0E5
 DbGzbmdnPpfQZBGdjz15aLhQ6iPMlkTz7Y+n0OPKheC2YB/bQvOfL8oZMloCNLgNw+hgQVX
 xsB+PuJ80uBMz35GhBLZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JoVFV05fOz0=:cITfs1h4a9PtSYPXOSZFI5
 xQUTHpk2HwlV2hLbUyJ3qBVZuFfcv11837oEYI07EOC1DCXzKF7pRvOXYcVkninMvVROM45pt
 uXgbcVvxEdHyB3ehYH2j4vZqG427SMxGjGH4A/CYNMPZ8p+I8OLomvfKtGAh0efsJU0gFl88r
 5CDGnOUIVqQ7RCtEOOfu3Gb7vrIpIB3rjbNhtcka7thqJsCrcefjwP58Tmzh7gt7X7kUDokbJ
 Bi1z8NMt+qlEpZa1NXEA5PVIzsN35yUDQOvaKeKVby5/nUQ0zcyXvFNnYG4aMzZjeTZdlSkuB
 msolKWM8EBYNf4jQHSfRpXIq4njoXsboVFVktZQvWdM8+RqPszTENDIxoYHt3IBmW5N0PaW79
 /wbV389jCCkfLqbO7S7tfD9Pq/qmSOmlX+x7IK98ufUoQdePlodi4GOoYiCnACB8yU1EeiexF
 H65wWc6yQuB4lXzGGy+gYx3E9MJXg/8F7gGoybGrSGkZ2sdvZWbh5nfzOG2fbVSJdxhIY4foC
 CfhMrHZEaIJhj5Vei/f1cPwBJMfM03q0OK4deoulZbXmOee3JcdQP/CXLsXMXDHMBodEaey57
 JupWT1n2nFPeHCW3kMy3nfpiYuR3rwB0swa53QZEb8WnruZcpB36Z6rLs56+k6eu/MLjrbHzI
 uaKzckWNrdT9Icc3ApPlO5DzlFolt0rXdlKQnXe+mvC3aMwNSRTN89s0ORvctX/u6sFk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add compatibility comment.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 6b82485ff58e..ea785f65c89f 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -1,6 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tegra20.dtsi"
 
+/*
+ * Toradex Colibri T20 Module Device Tree
+ * Compatible for Revisions Colibri T20 256MB V1.1B, V1.2A;
+ * Colibri T20 256MB IT V1.2A; Colibri T20 512MB V1.1C, V1.2A;
+ * Colibri T20 512MB IT V1.2A
+ */
 / {
 	model = "Toradex Colibri T20 256/512 MB";
 	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
-- 
2.14.4

