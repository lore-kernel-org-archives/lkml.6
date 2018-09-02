Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD85C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D186620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D186620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeIBOZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:03 -0400
Received: from mout.perfora.net ([74.208.4.197]:53427 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbeIBOZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:02 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MEE6I-1g7Mc93c2y-00FbWN; Sun, 02 Sep 2018 12:09:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 13/37] ARM: tegra: colibri_t20: update sound nvidia,model
Date:   Sun,  2 Sep 2018 12:08:42 +0200
Message-Id: <20180902100906.25792-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:L21kXrJ4RENzeUQxCiY/FYHtvPJzmMn+rWiY0d5SsoRc2lIWzuD
 qrjJaxjJfEyh94ukuTSsHhzU3mUyCicyuU+sE9PBxY42H7pHtEVt4/nM7wc8L089+UGbJI3
 1Du3rGy1ChZ4SM0+G1esceYHetO1aCdGD4uK0L1LWxaV2sM32xHwNhkCn1R2lnyr2seHV0f
 dcB8BD5tI9kPtPYTfk39Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UxCt/eWO04A=:1QWpC/OlZ8rhpnJ6QDUIEx
 NFyABiqq+XCaO0IEaig33cccY35tUcTx0rTDlZRcCZ481M46c5qAonv3cWTnxH9kJsla3sJha
 P4gdAk0y+av+SEyqZjBRva/as2Lot3z/NBiNybp3G2JC9dpLF/ONzaHX2CHNUaZLWDVWbuypJ
 y0EjjPAHkkRJy18GOxQeftveSniFXeHxfTdEFCtNJXNiBVkV9ChMp8TVFtVFsAFQxvoJ9s/g0
 DKcmGd9v1vmx4MSfqQ7anoV7a0k3oBnzuH0MWvIbE7TG0qE7pyylH+pydyIV5cXFdYM/Fkr9g
 13AGAdWwA4EgTVL5fhLEMN2hQg80w721cGToKHiEG+wEm4tm7tqoItsY/aJU0wr4cBLyWS7+d
 JzUbyE/UTe2g8nxADzctoW65l+PZiPLALMRkJ/+Cl9mSBebIm/uz356VQRwERyoes/KMjTte4
 aybS/36trfHRvrPyQpMhgwCmynXilxY42+7R6o/2EEhVhU6K498ZHOq6JyGVLIe6T6pX9QrsQ
 VRPJCnCPu28Kl/9iU2SKME1n+AX19s38GHo/tINTQqFlQ5U9nAnlXfL9JGEz5cud5DMbNKKOo
 1u0fTG1ZOgNjkN+bzvrMZ3FZqYI0mHkTEtZf51AIgXaWsUG8zBm0rxu2BHh0tiRwTgCmvLyMk
 0wG49iF50hBphLB//LN1zyxabQtm6FBN5QMWrpPogjvWkDTPFzjku6iUQMtnXWYQEOOw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Update sound nvidia,model to be more in-line with our other device
trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 5559008efc5f..ba84184e09b8 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -507,7 +507,7 @@
 	sound {
 		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
 			     "nvidia,tegra-audio-wm9712";
-		nvidia,model = "Colibri T20 AC97 Audio";
+		nvidia,model = "Toradex Colibri T20";
 		nvidia,audio-routing =
 			"Headphone", "HPOUTL",
 			"Headphone", "HPOUTR",
-- 
2.14.4

