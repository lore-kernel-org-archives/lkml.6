Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772FCECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C89220874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C89220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeGVRrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:25 -0400
Received: from mout.perfora.net ([74.208.4.196]:34981 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbeGVRrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:24 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MYdKW-1fUeVa1hJq-00VQOT; Sun, 22 Jul 2018 18:49:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 06/28] ARM: tegra: apalis_t30: annotate pcie port nodes
Date:   Sun, 22 Jul 2018 18:49:14 +0200
Message-Id: <20180722164936.20581-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:o7wRJZS5+yCFmEGPMhmLN/VPnmSUNxVFahNjtVIpj/n1LMp6eCA
 xux/9BlOq9x7x1yBZQkf/FgZfDZ7F0jj7wLFZ4Gow6QOAAcbY8qSFPWgdlkOAsQMhW5wjuB
 AY0XY8CC7SddN9/0m5etl8Qc3xR51FRpcydpGZplCRSZSTMiEsF3M71VHIpK+j/hD0JSF6l
 OneY45SNdkOPJE59WyNrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q27CrQSeLEI=:8z0dhhS7ue19L+wqMjDkjQ
 rWoi8aakE5ugVnoi/4SZ+Mx8txMCNmoLzhJ49UCOk+M/H+iJE0YcRYNDXzHXp5zI9Jn6egVs9
 PGMpefWQYUQvp1tf1YCDRB/SMLWeCvu4/SZgiaB88bFj8DK5cC12XixfmJ5mDrTV0w1nLqj6k
 iFRTpUlmk7H5y+UxQAEmmZKmz6tPLan7q9XdnTJh0a+3DyAfwFKMhCx++sAPfA3MP7dqdvVfu
 wA08F2VNd9pz7EEEBwU+8OoKGLihQVQ6ltnzy0YIzFBCQVNhoMokpuPYSnKZKHurZNpu+23DE
 XqypfbV/9fJeZg6f9yjzWI86etyCHoJFDxrv7ARJVBOlOBqTdOAstuf+sZv15mFtpQt3nhHf6
 cW7sksB5hO84/33Y+J+VyEh9ac4A9aEItAYTURlksjQlh6FAa4A0TZSAQGGEmv/QVEF8k5c8l
 6tuqwVBDnf0qFd9tyiAJ4rLTJE8OuD7uWNdlqsA0Dc8nGfwpzHqTOKgyHbIVFNRE6EMnXpM92
 BRXqtldMe62F6ye7xw5N/O9OBV8r52nRxJEQppvQk3psM5X2DVy3Xapuab52wh0IyVWj1v6PB
 KzoVRZmHUeblPkeih7MD+C+Y7k4yBXzkmLtxVScYf/GJWkh7ZDl0gCd7Zhq7C/bjpabi1Q1ha
 Bfk2vUp9wm6hR/vAvssBrOu7x78Ym2KrMqwkD4K0RvMD2d56P696d9l7yd2h1GW18TEc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate PCIe port nodes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 0574eda8b3f9..a1cc415b3893 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -24,14 +24,17 @@
 		vdd-pexa-supply = <&vdd2_reg>;
 		vdd-pexb-supply = <&vdd2_reg>;
 
+		/* Apalis type specific */
 		pci@1,0 {
 			nvidia,num-lanes = <4>;
 		};
 
+		/* Apalis PCIe */
 		pci@2,0 {
 			nvidia,num-lanes = <1>;
 		};
 
+		/* I210/I211 Gigabit Ethernet Controller (on-module) */
 		pci@3,0 {
 			nvidia,num-lanes = <1>;
 			pcie@0 {
-- 
2.14.4

