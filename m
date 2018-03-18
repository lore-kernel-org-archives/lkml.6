Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeCRPep (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCRPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:34:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F20620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: dts: exynos: Second pull for v4.17
Date: Sun, 18 Mar 2018 16:34:15 +0100
Message-Id: <20180318153415.8229-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous DT pull.

Best regards,
Krzysztof


The following changes since commit 6f4870753f29edf7dc39444246f9e39987b8b158:

  ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250 (2018-03-05 19:11:40 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.17-2

for you to fetch changes up to 720b5fc3ca0f72b30452089d0510cd1e81a3df6d:

  ARM: dts: exynos: Add #sound-dai-cells property to exynos5250 i2s nodes (2018-03-14 20:14:24 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.17, part two

1. Fix audio on Exynos5250 Chromebook Snow.
2. Enable HDMI audio Chromebook Snow, Peach Pit and Peach Pi.
3. Fix debounce of "OK" key on Midas (Trats2, Galaxy S3) boards.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: dts: exynos: Fix "debounce-interval" property misspelling in Midas

Sylwester Nawrocki (7):
      ARM: dts: exynos: Add #sound-dai-cells property to hdmi node in exynos5250.dtsi
      ARM: dts: exynos: Add audio clocks configuration for Snow Chromebook
      ARM: dts: exynos: Add missing clock and DAI properties to the max98095 node in Snow Chromebook
      ARM: dts: exynos: Enable HDMI audio on Snow Chromebook
      ARM: dts: exynos: Enable HDMI audio support on Peach Pit
      ARM: dts: exynos: Enable HDMI audio support on Peach Pi
      ARM: dts: exynos: Add #sound-dai-cells property to exynos5250 i2s nodes

 arch/arm/boot/dts/exynos4412-midas.dtsi       |  2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts         | 11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi             |  5 +++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    | 17 +++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     | 17 +++++++++++++++++
 6 files changed, 69 insertions(+), 1 deletion(-)
