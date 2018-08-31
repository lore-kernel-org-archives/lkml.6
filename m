Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DE0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2320658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF2320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeHaUrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:46 -0400
Received: from mout.perfora.net ([74.208.4.196]:36613 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeHaUrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:45 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mbzhw-1gExEG0NKI-00JNYJ; Fri, 31 Aug 2018 18:39:18 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 27/34] ARM: tegra: apalis_t30: drop module level model and compatible
Date:   Fri, 31 Aug 2018 18:38:09 +0200
Message-Id: <20180831163817.23970-28-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:dmGCByMd7awE6CDvpkPoVANu6kiPVubwUaOy4MmC+miTiCygq3c
 AM8Y5sBtfewCZaB8eiuSEHXzA80eMETwrbJTGSkL8LP8ws2DgPC0SJEHtQahsk54GTTOfUv
 XCAzG/xtH9vY52wYLpnD8UMFAATnyM49ncssKRdM+ly9UAXf8rMowA+4XpKdD3w1ksuwyGp
 3YBf1OfCFKgXOeBp1L+pQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NP7eK6dGcGg=:H8eOYL/rSV249I5Fr0N//J
 mOtxxMmdxxsJ49NLGZZCQfUpC2VRmsM6z60YVYp2vKHmdxESlgyp8Zz159dHSPq2/YK85LTTK
 2d4ePY+9YsYkdWELaxsG/TEC32JfmhP6uIOESiORoH5IDs8ty1Tjxcp+d3+0rXYS+3Rfb2piV
 Xm01XZ9uAK9N+nAw+V4yTwkDgAQYxdTyNbrHkiXxUizPyCjVtsNrIi1c0XVelhyxatYAcRHHM
 Vkv6ldjW+XjKYyX0jCTkWKVLLbsUzCvPjYn8LUsF7ToCoKuIviatHLYYrkEVl9++CRpwUOoSC
 Ar6OFbYg5VdQc9/S6ukjaNYfhpFiF/vZTdNejca0nnJ2UWi5QsLZWSa5XTQrLt26qSs9kn2jM
 6Um2vpu14qqtO8xuWnWj/SsilDrAcg8YvgskynTdzSI62DH+J8eJ/iBVXwM5zY6m9H5qaqSdM
 GL3bmgt1B5btySUYtwiKhiVrfq/HJqS3gAjgG58kdKkUwdP5bf8+PbMnjTSdelA0r0kLwJdNY
 /H0xsm4eY8qihXSpzgRh7BmTs8LoQI/UuAHevD5/MSXwGEFqFuOxcH0K6OAfiGWFxRsS0CTtq
 CYXC5gy8g91Gt8jKfCy+HhCiqUMSMuBagrt+SAji8PTw8M3/Y/rRFwF8i7+3vXxdich5fI1ul
 LTBL/JJLv2JQIV68Sjns2ylrc0GXpbuvBhq6//q4Ix6padLpLCPVEvANEhRTAMggDG6A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop model and compatible nodes from the module level device tree as
they get overridden by the carrier board device tree anyway.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch as suggested by Rob.

 arch/arm/boot/dts/tegra30-apalis.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d80101df2228..e7793f3b19d2 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -7,9 +7,6 @@
  * 2GB: V1.0B, V1.0C, V1.0E, V1.1A
  */
 / {
-	model = "Toradex Apalis T30";
-	compatible = "toradex,apalis_t30", "nvidia,tegra30";
-
 	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
-- 
2.14.4

