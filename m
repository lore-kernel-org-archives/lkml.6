Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886CBC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A7A20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A7A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbeGVRsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:48:01 -0400
Received: from mout.perfora.net ([74.208.4.194]:53379 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:48:00 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MA7VH-1fsWub3gIz-00BIGs; Sun, 22 Jul 2018 18:50:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 26/28] ARM: tegra: apalis_t30: line break long compatible property line
Date:   Sun, 22 Jul 2018 18:49:34 +0200
Message-Id: <20180722164936.20581-27-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:fwrWvDgkMfXR0G/z0lake2x2V/oSEee8x0STOyXJq5pMJI0c9OR
 9G6ZqhgvDnG/fDH6XuT0JvBYq8H8U7LvxFvGlWbK6FAMXIH7hvepE6YLs6i6Jach05ASC60
 H5QRI3DdXOvAepexeypHVXt0v1LQP4M66yDt+NQuGV385rnl0NneGiqmFKu//Ody2To9KcD
 YWcomxKoiw1SPJSwDtCCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7t4zJiInu+M=:rvTt7ZiOzWnTUX/ji+4cOk
 VU1mR9xdWwZlkOuEjmbvXOF8ESXA2sBWRbP5drKprUc1k5Qm1IT28jiZEV4EE72PJMjCiTV9B
 hnZQ77w2eN8wUkyi8utqUYkE6UYZgVS7pxu3DhFq3Iy0OxXim6htQ/w3gZoglwf1YSKGXb7w3
 ys3Pb6JSQmOKDXj1dgSKZZMqXSTyc0BfA0bFMV0YBRZR4zFlcyIKYYkMshrqr0maOzD8PzqVl
 1cFSOcdDshOAVY4f6tX8dC6pQfvWx7OMSEU94HbB2gZ3lqDWgkQzc7HyW172j1pR27ZP9/JhQ
 V/okcL1Yrz3zj3ct8Y+iaEd2m+qOFsrNcfCAdzpp1EayBJf+eeLqhxbT4+BzJ8WkWnMorCevb
 i1ojzRgXLbunQraVF3xSqD9LN30y03nzECrZnWkZuJ2etBxCawsZXWmXKlvj6EFXwlmhSiBUa
 ipCRy0I6SdFwPFL52H5P/c5psjj/XBs0BpCT8eTU7VFXWi83H7dGvG27J5EBV62shGP5VmuSM
 AS9mJaTcuH8t7UA5RoIpt1Ze5qX/Ksn98Dr/sk6vcjOrteFjjDW6KzgJbJgUC5Oix1IQ6ye83
 LRet/hSgzMfv+zCkbqu8SDkG5/AujVEBH4lZUAX/veltoG/6tKEpWqXUbbLruN716FqPBMgZI
 3xHeGE1Z8GwtsPF2FM0fdRrIOv2Veb0aSx9bSFh3Bs62B8KxAyYMXfQBI0D038rqeFuw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Line break long compatible property line.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 6978e3626fae..83949ac3cc07 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -6,7 +6,8 @@
 
 / {
 	model = "Toradex Apalis T30 on Apalis Evaluation Board";
-	compatible = "toradex,apalis_t30-eval", "toradex,apalis_t30", "nvidia,tegra30";
+	compatible = "toradex,apalis_t30-eval", "toradex,apalis_t30",
+		     "nvidia,tegra30";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

