Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8CFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391A12082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391A12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeH2MKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:31 -0400
Received: from mout.perfora.net ([74.208.4.196]:54545 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbeH2MKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:31 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lz1b4-1fqc6a3wjw-014DDi; Wed, 29 Aug 2018 10:14:41 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 13/31] ARM: tegra: colibri_t20: update sound nvidia,model
Date:   Wed, 29 Aug 2018 10:13:49 +0200
Message-Id: <20180829081407.11304-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:XZya6wtSmSI72ce/2wA2rYXwXW1/khaO1mX0Rw3PrqU3aykNmkE
 bEw6bpKC2DqsToBp9xDq4xWnwRP0CYvDTlxkXAnjjEy9zjkCEYENCLG/sLmxscpf+UAehpT
 zBZQVUn8ZI3sqwodrZFbV1zy1ZQP8sZmnb2T9r7zbQ+p+rpNi0OzWzmzgfJIXXAwVJ4lUYc
 hAw2DDcI4xEVA9OnOGBfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x1yr04UHbGo=:Q6p2hi3nA9xxXszFMbhoi9
 2Jy2GrEa0JTzLb0SIAmhvyDlIoeGZ14bTWmyMieUpkg7XcIl0jAN5EQQXZOnhFAVZTb+qZNOa
 JxFM3Hq6Ljh1M67HGHn1cfPlGNxwHIpB9zC/8yx5qDoguJP4GmrqvVEFq1ObszqqIpXELlHjq
 aWAZbQ76+cUZlmNntSOp4CjO+4HOuImc3oZ8Ty93UmFzWSLw+eYPxqaI+Ey4I1UX9C5g3sNsc
 KgSSVjEpQm/qPBRsVsrWv/dFZkk75kSu6iChUewMdAi2oHs79e5XtoZaHaDvU+eDUmwLfzaWW
 6hLV+3KLNxGAK5PDGnfg5cqhNkv9Hi3VAcx2meeAXe4kRzGveYNFn3VcD85uSwkErlAiZtWqT
 VL6JZVCvKewBt5sMCBjfgFMz7yMyfDEe3B+Tge/g9e030g9uX9o31T+9piTbYBg+DzFL+zGX6
 wVI4CZ+O+yazgBD+wE9gl2Ueb3GgXApxhb2kPSiQs95LcFMF91/OyzuNwdSxlvLwT5pyFPiBY
 mrqgeTplH0WNzxlJXgX88beHibFl0KYGjt/OqRTVMVj3QhJ2RyDGGfkQtM+FHxK+xzwOHMmIb
 VJmxgRaxyqoa4Esr8a0lll1b2gmWdNSuHLuyxqRDeMc0QI3lEmbOygP9uRZzD0twQ1MiAGIv4
 ILUKuIpahJpJgevfDKHC5GrGcUBma/RTe97FdcBAJfIXJBySX43lIBk953OFTPbCaqLA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Update sound nvidia,model to be more in-line with our other device
trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

