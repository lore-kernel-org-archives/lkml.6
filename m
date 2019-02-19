Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA66C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C4221738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550602348;
	bh=7magXceUJ8ImTVgOlwL7w/s4YKCJoWKnahlH0PwJHi8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=R3VGw/uaKlqtTe+6Tr64Lke6ibRCDEiT9WwdR712cDtCJxWr76u5EywMDmZ2HIak2
	 KGq9WLEYCtEHNAyh7PqDUcBR40f9DDFKlsWOEFYFZsDy4dpKBSZbF5fkSqofd5dZ5K
	 w3pEbtdykjal+fYrUJDuhx9MKitbt9e63VZ30xMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfBSSw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfBSSw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:52:26 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E952147C;
        Tue, 19 Feb 2019 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550602345;
        bh=7magXceUJ8ImTVgOlwL7w/s4YKCJoWKnahlH0PwJHi8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ongw8/sKOH8mYGN1Ub/4DLqbPV0hMKSJ0Y4Oy62AiNsauBU9BTs9yRp8vH8MZmslX
         CFW5M876pTo2AmDGzsGfqZnl+5lJCLq/HCn99aDVIOoUCZjcUM05miRDesDeoPUU5o
         n9N0lTcQlpnKMyTdE1i1yCaxFGBHldImhe66r5nY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: dts: exynos: Second pull for v5.1
Date:   Tue, 19 Feb 2019 19:52:14 +0100
Message-Id: <20190219185214.5544-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit ec33745bccc8f336957c751f4153421cc9ef5a54:

  ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3 (2019-01-25 20:18:10 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.1-2

for you to fetch changes up to 625c731d1b2af487fc6be10b9a505699c045813a:

  ARM: dts: exynos: Add support for secondary DAI to Odroid XU4 (2019-02-18 20:52:25 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.1, part 2

1. Enable ADC on Odroid HC1 board.
2. Fix clkout register failure on Exynos3250.
3. Allow using earlycon on Arndale board.
4. Disable ARM PMU on Odroid XU3 Lite because it is locked by Trusted
   Firmware.
5. Add support for secondary DAI to Odroid XU3 and XU4 boards.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: exynos: Enable ADC on Odroid HC1

Marek Szyprowski (3):
      ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
      ARM: dts: exynos: Add stdout path property to Arndale board
      ARM: dts: exynos: Disable ARM PMU on Odroid XU3-lite

Sylwester Nawrocki (2):
      ARM: dts: exynos: Add support for secondary DAI to Odroid XU3
      ARM: dts: exynos: Add support for secondary DAI to Odroid XU4

 arch/arm/boot/dts/exynos3250.dtsi                  | 3 +++
 arch/arm/boot/dts/exynos5250-arndale.dts           | 2 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 5 +++++
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  | 6 ++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 -----
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 4 +++-
 7 files changed, 24 insertions(+), 9 deletions(-)
