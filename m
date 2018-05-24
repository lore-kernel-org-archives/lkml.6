Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034281AbeEXSUx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034253AbeEXSUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:20:46 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] arm64: dts: exynos: Second round for v4.18
Date: Thu, 24 May 2018 20:20:16 +0200
Message-Id: <20180524182016.5866-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180524182016.5866-1-krzk@kernel.org>
References: <20180524182016.5866-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 8dd6203f32f20cb83469eb859efded9e403b3e9f:

  arm64: dts: exynos: Add mem-2-mem Scaler devices (2018-05-13 11:26:13 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.18-2

for you to fetch changes up to f0b5e8a21e6604980c35eeeba1ee3a124f45ad1f:

  arm64: dts: exynos: Add more clocks to Exynos5433 Decon/DeconTV (2018-05-23 20:23:24 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.18, part 2

1. Add clocks necessary for DECON hardware windows no 4 and 5 on
   Exynos5433.

----------------------------------------------------------------
Marek Szyprowski (1):
      arm64: dts: exynos: Add more clocks to Exynos5433 Decon/DeconTV

 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
