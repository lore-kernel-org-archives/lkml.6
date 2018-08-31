Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B7C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203042083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203042083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeHaQuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:50:14 -0400
Received: from mout.perfora.net ([74.208.4.196]:56981 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbeHaQuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:50:14 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M5fUk-1fgWEM143M-00xcFh; Fri, 31 Aug 2018 14:42:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ARM: dts: tegra30: fix xcvr-setup-use-fuses
Date:   Fri, 31 Aug 2018 14:42:33 +0200
Message-Id: <20180831124233.27156-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:w+D5ZyStcKPbuCvYjmmkgm69SeLunWnHv/T/dMo2dqBHP6xJmUQ
 oQmugpBxICYwPDIu6bVSHZ/wpKlzJnN2JuPSZJNoboyMkJFo1+lAKl4MasG+kABsBmYf9CJ
 r9tUa6l0Qf+X/Ne/7hvZTo6vimSbg6Vs+CE5H3QnxzZquBPnPTAKrlnACRElKRh9HOV3jIk
 DjukZNW/90ZZNcWgFgBlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UKzHTpn5Brg=:BxaIniJaatBjAQTdCjhF0+
 ajr26V1OP4SxcITMnCmzCpEKvDekCVI93+TETSx/DysRMjBtOxaM5pJm1x4b6Gos4lpt6rqS/
 DXIC8yb7NN+oFXkNXY3Iiomkkfy/wQXilBJPj85V1pPzLjpx3pYtgWIhvQoLgbkKwaD9byBaJ
 WSp8a/kpp46/sR4Uelr0Bog6AwRFd0x5eNRvoFQ31MZ/VYqSohTCCEIoVsnGaDgw3DKB25M28
 aoYTklaqiE8jJ7x8v/ogxTAMlxJl9z0Y9ibGwOa37acN+drqq+iZqMK9hXkTj5W6ZcLAfk006
 4XMdSkVyeyuGsFdFpjfKfZxu2gTB4BYUoCvDGC22S1+3EIWFGph0NWAZUbaz6R5Rs/o+BBrqO
 ZN1GkpRd0qwR9JBG/ALK2zHn4JgtCWuynO/c0uuhQYTUdR4kaO+EPcXfJpB5uqRUog1/lJi8Q
 3mNS8OxxtFeYEdm/y3b/BIunLLzOLaJUCr95Xyw6uTCj36zNOJZU2mVK21cBAhYMQ9gArMRmV
 N9ONv+DBTSSq/tMc+c4o5N1PBsodZoS6NecJpPhZEonHG1IYqrWT0fGtkL9hwQYdPmQ0Li8y9
 vcPvojs0J396pBkH+5C/Il3ptYoaloAbz0NvjNRJ+X4nuLRI3RWKG6j9wIbJBG+J7M2raKznI
 Ax8EKHcfKXGoo328EKkytKVCSGtuQD8eFvPul+1twCdMuAL9LNKIuK/3NKKCRr4Cdq5E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

There was a dot instead of a comma. Fix this.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 1de10f0d1da7..d2b553f76719 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -896,7 +896,7 @@
 		nvidia,elastic-limit = <16>;
 		nvidia,term-range-adj = <6>;
 		nvidia,xcvr-setup = <51>;
-		nvidia.xcvr-setup-use-fuses;
+		nvidia,xcvr-setup-use-fuses;
 		nvidia,xcvr-lsfslew = <1>;
 		nvidia,xcvr-lsrslew = <1>;
 		nvidia,xcvr-hsslew = <32>;
@@ -933,7 +933,7 @@
 		nvidia,elastic-limit = <16>;
 		nvidia,term-range-adj = <6>;
 		nvidia,xcvr-setup = <51>;
-		nvidia.xcvr-setup-use-fuses;
+		nvidia,xcvr-setup-use-fuses;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
 		nvidia,xcvr-hsslew = <32>;
@@ -969,7 +969,7 @@
 		nvidia,elastic-limit = <16>;
 		nvidia,term-range-adj = <6>;
 		nvidia,xcvr-setup = <51>;
-		nvidia.xcvr-setup-use-fuses;
+		nvidia,xcvr-setup-use-fuses;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
 		nvidia,xcvr-hsslew = <32>;
-- 
2.14.4

