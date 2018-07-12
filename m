Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE141C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7857B21486
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHZ4YvgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7857B21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbeGLQ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbeGLQ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:57:37 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0003221480;
        Thu, 12 Jul 2018 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531414036;
        bh=+dqZSJeRNo4f+YIUVTwXtQsbozt2/SgZZG0VRfbLRMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHZ4YvgQ2fhgRBNsv4yQZUFkjgLutsqb5AkxM6Tz/YhT6Lwg4jS5GLUzzwVmrDrBp
         ZdpHUJXlnTHWcnEtWjZjPtQ9MUMLL0oqnJc3KAUNOpn4BN9d025lEsFCrW9lIJB06H
         OrWx1ett6IRUgbb9QL6dVnYar8kW8P7Q/XvqNi3E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/3] ARM: dts: exynos: Pull for v4.19
Date:   Thu, 12 Jul 2018 18:46:40 +0200
Message-Id: <20180712164641.19925-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180712164641.19925-1-krzk@kernel.org>
References: <20180712164641.19925-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rebased on v4.18-rc2.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.19

for you to fetch changes up to 57f4e8bc1c3ebbd06a278107edeb6af95b53e5bf:

  dt-bindings: samsung: Document bindings for SGH-T959P board (2018-07-07 12:28:07 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.19

1. Add two new S5Pv210 boards: Samsung Galaxy S and Samsung Galaxy S 4G
   mobile phones.  Both are from family codenamed Aries.  The Samsung
   Galaxy S was released on the market in 2010 with Android operating
   system.  At that time, it was the Samsung's flagship model.
   This brings support for storage (SD card and internal memory), PMIC,
   RTC, fuel-gauge, keys, USB (in peripherial mode) and WiFi.

2. Add missing secondary CPU properties.
3. Cleanup from old files and properties.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: dts: exynos: remove no longer needed samsung thermal properties

Jonathan Bakker (2):
      ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
      dt-bindings: samsung: Document bindings for SGH-T959P board

Krzysztof Kozlowski (2):
      ARM: dts: exynos: Add missing CPU clocks to secondary CPUs on Exynos542x
      dt-bindings: arm: Remove obsolete insignal-boards.txt

Paweł Chmiel (4):
      ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
      ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
      ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
      dt-bindings: samsung: Document bindings for Samsung aries boards

Viresh Kumar (1):
      arm: dts: exynos: Add missing cooling device properties for CPUs

 .../devicetree/bindings/arm/insignal-boards.txt    |   8 -
 .../bindings/arm/samsung/samsung-boards.txt        |   5 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  18 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |  13 +
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  20 -
 arch/arm/boot/dts/exynos4412.dtsi                  |   9 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  25 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |   6 +
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |  21 --
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |   8 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 419 +++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  45 +++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  77 ++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |   2 +
 18 files changed, 635 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts
