Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ECCC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5A20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5A20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeIAMZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:05 -0400
Received: from mout.perfora.net ([74.208.4.196]:53685 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeIAMZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:05 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MeiSs-1gFkqD1AHQ-00OIum; Sat, 01 Sep 2018 10:13:49 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 25/34] ARM: tegra: colibri_t30: update compatibility comment
Date:   Sat,  1 Sep 2018 10:12:39 +0200
Message-Id: <20180901081248.22639-26-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:kR0zm2fMEbINuHEB4DCzTMWfmQjGymw1Lst37pVFPfgqDAWJCah
 pxgfYHDoAV18gGrIBgOVj1e8Kl8VrFVihasZNZnWGbujcstNogMUdQmII2qHAIgzUlXbDuG
 XagPfYs4PMzH6Fl0X2pMbSB+kCV4y3MG515xqULya7qeoB1LjzTRCSwlfawAZzBFdOVQqyA
 zUkzi4tMFnFH/KjBeq3sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qaAUaT6znVY=:eo8wvxdV3QWB7FYiMyvnii
 A7K6zZaPWTLsl4x71mnSW3HDmFEDxsBDJoPkosOfZo7k0vjN+OM+wOlWsLEnaT1uOcl5Y2l1P
 Rr2hEmdLnm+1OBVuCOjAJ8gytjpnlqGzpfQYR3sAX9q0qEO2r2HI1OyR3MRhrkMiPgvZxfkbW
 jZZ99EmnlvP3+IELVr01O4IMAS9vzwKWIJ1v7B9IvMLgdR0HYiCM4RsGo/E3iNWj/IiJvIB7X
 i0XYKQfA7X6f58P6TaKhgwcW1Vhfzzo2BY04CtAkqMOVOYRyi8ELkWgNAlhIRCqRr0wrT8Z1E
 urjZpOVvxicPyZ8o+GdEfvNzf3V5cUbhp4TfkBTv54/jiKVJTHqN87cc6DoeuLaDOwOCShqBo
 QfLhhho3UR/KW9ybp4P1JaiTUg4RMWxPWZBRLKlPBp2/Sv6qWrZPVwe9ofys1TKNJOVmoYEEA
 9Q1frdxj5/6svabpNfuKblDIY3V6giUXh3PUqfYNYpDRT/TBK19HhZwNOm+J/x8wS8ggClHML
 hBily0Cq+LTI8zyijpmTEhyLt/8/nY0H2LNnUQkRu8W0s+yE/63je4gw9fSxDmtXy86fYJjXV
 JYFePAxtlI5981dFHY7NMFkHsmCstjeaA82tckJLipWSGMIjeNcfBlz2WgJMTjum4YEznxSBo
 MiQTudjJvSwKrncdcFAOs642AVsz7GEp+0SHLxw/Dgo5xtur9l/SvxyzlERyPpCYUmtg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Update compatibility comment.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 7a4e454a1960..9bd7034b8e66 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -3,7 +3,7 @@
 
 /*
  * Toradex Colibri T30 Module Device Tree
- * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E; IT: V1.1A
+ * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E, V1.1F; IT: V1.1A, V1.1B
  */
 / {
 	model = "Toradex Colibri T30";
-- 
2.14.4

