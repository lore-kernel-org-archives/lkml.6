Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935795AbeEYFkc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:40:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40294 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935442AbeEYFk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:40:29 -0400
X-Google-Smtp-Source: AB8JxZrZg0zvY55jtAAK73EEipz5XHoOaFPNPF7kdWS25mV4G4B7PSEZB7GhQR5/OOJU4TuKYU9fpQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Carlo Caione <carlo@caione.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 0/6] arm64: dts: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 11:10:00 +0530
Message-Id: <cover.1527225682.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This fixes missing cooling device properties for CPUs for the ARM64
platforms. This is build tested by the zero day testing infrastructure
as well.

Individual maintainers can pick the patches to their SoC trees or I will
ask ARM SoC maintainers to pick them up later.

--
viresh

Viresh Kumar (6):
  arm64: dts: amlogic: Add missing cooling device properties for CPUs
  arm64: dts: freescale: Add missing cooling device properties for CPUs
  arm64: dts: hisilicon: Add missing cooling device properties for CPUs
  arm64: dts: mediatek: Add missing cooling device properties for CPUs
  arm64: dts: rockchip: Add missing cooling device properties for CPUs
  arm64: dts: socionext: Add missing cooling device properties for CPUs

 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 24 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  5 ++++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  6 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |  4 ++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 16 ++++++++++++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  2 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  3 +++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 12 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  8 ++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  2 ++
 13 files changed, 86 insertions(+), 4 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
