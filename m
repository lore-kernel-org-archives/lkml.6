Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A80321104
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544356170;
	bh=/Ot7Gzx7qA2GKIHFnhJiOxMrvQy7iQmiBjYCm2bGsZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f3B1hVVTiZGAd4qGDiKuc+LL9i6rdlRtSymAP/JEr6A2lyKllRoEjy9sBiTMLGtkb
	 m3cx79OBVACOQrK1ubLOcIqxrI+5zl8YFTPX6sm97NvOgDc3P2dJordtTaqCoWBVxK
	 hXpaDYlnZKhbEMFzLU/hhn2KIge8GNnzyiNwn24E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A80321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeLILt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeLILt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:49:27 -0500
Received: from localhost.localdomain (unknown [178.38.170.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E060920874;
        Sun,  9 Dec 2018 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544356166;
        bh=/Ot7Gzx7qA2GKIHFnhJiOxMrvQy7iQmiBjYCm2bGsZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRgvvmCtyugB6yjwCtG2J4oYWzUwXnMhkVm1AxxHDbwHLTkgALpI69wkRzTQV0lFW
         db3YmOLAfVFv+1uf5xPX0zx7IgSXRsoW1huDPMeQfOXLrd1uPvUiAQ7egIKaDgol/6
         CubNMEkgJrFAuzskjnDBO0DpqcZqReZm9VkQfPjo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] arm64: dts: exynos: Pull for v4.21
Date:   Sun,  9 Dec 2018 12:49:10 +0100
Message-Id: <20181209114911.25194-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181209114911.25194-1-krzk@kernel.org>
References: <20181209114911.25194-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21

for you to fetch changes up to 9deffb5ee78e41e2a5d6c448874a24caec6467d0:

  arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.21

1. Update DWC3 hardware modules to Exynos5433 specific variant.
2. Update cooling maps to include all CPU devices in multiple DTS files.

----------------------------------------------------------------
Marek Szyprowski (1):
      arm64: dts: exynos: Update DWC3 modules on Exynos5433 SoCs

Viresh Kumar (1):
      arm64: dts: exynos: Add all CPUs in cooling maps

 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 +++++++++++++++++---------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi     | 24 ++++++++++++-----
 2 files changed, 42 insertions(+), 18 deletions(-)
