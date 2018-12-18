Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C880FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95698218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545163813;
	bh=V2Z6FNlObzVrANZZjLMVrzORLYCaCBjOZOSSho75eZ0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zH1Nj9jz0INZ1Lv4V98sZXI7UgQoixJa6oOYc03z6cHXBlkPCYCenPS0799nwKdzb
	 j0pqBqRpJIzJbEegID1wKqF/PNvpcYWtZP82+UuhL6mdtPwODrBKlhWZS4nbDkllPI
	 9fyCoXZAk/fd8IrvMASi5bgSJA9hDzCFCV49moTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeLRUKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRUKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:10:12 -0500
Received: from localhost.localdomain (unknown [178.38.170.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0519121873;
        Tue, 18 Dec 2018 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545163811;
        bh=V2Z6FNlObzVrANZZjLMVrzORLYCaCBjOZOSSho75eZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=BKBosLUHWplD0avHxIjeMhwmcP0I+uwNiuLSmufaRimVJTaYdfE3IRUGdaf1YO9Js
         N3ATmM7unm3hqmZ/1s9/zlaxDJ2cFhAe35cl3jsrCSDbi06Mli0McxYsZhQNcjls4v
         DmLpX5yFW6NLRsyF0EoUURoGKRvZ0bPVw9tGpy+4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.21
Date:   Tue, 18 Dec 2018 21:10:02 +0100
Message-Id: <20181218201003.12806-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:

  ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21-2

for you to fetch changes up to 8ac686d7dfed721102860ff2571e6b9f529ae81a:

  ARM: dts: exynos: Specify I2S assigned clocks in proper node (2018-12-13 21:56:07 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.21, part 2

1. Add missing CPUs in cooling maps for Odroid X2 (missed in previous
   round of fixups).
2. Fix clock configuration in audio subsystem on Odroid XU3/XU4.

----------------------------------------------------------------
Markus Reichl (1):
      ARM: dts: exynos: Add missing CPUs in cooling maps for Odroid X2

Sylwester Nawrocki (1):
      ARM: dts: exynos: Specify I2S assigned clocks in proper node

 arch/arm/boot/dts/exynos4412-prime.dtsi           | 6 ++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 9 ++++-----
 arch/arm/boot/dts/exynos5422-odroidxu4.dts        | 9 ++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)
