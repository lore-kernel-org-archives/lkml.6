Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeEHIY7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932928AbeEHIYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:24:54 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 0/3] ARM: dts: tegra: Add 256 MB Colibri-T20 and cleanups
Date: Tue,  8 May 2018 10:24:38 +0200
Message-Id: <1525767881-28516-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Changes since v2:
1. Added patches 1/3 and 2/3 with cleanups and minor fixes.
2. Patch 3/3: Do not add new compatible but use everywhere existing
   "toradex,colibri_t20-512" (suggested by Rob).


Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  ARM: dts: tegra: Remove skeleton.dtsi and fix DTC warnings for /memory
  ARM: dts: tegra: Fix unit_address_vs_reg and
    avoid_unnecessary_addr_size DTC warnings
  ARM: dts: tegra: Add support for 256 MB Colibri-T20 (plus such board
    on Iris)

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/tegra114-dalmore.dts      |   3 +-
 arch/arm/boot/dts/tegra114-roth.dts         |   3 +-
 arch/arm/boot/dts/tegra114-tn7.dts          |   3 +-
 arch/arm/boot/dts/tegra114.dtsi             |   4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi |   3 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      |   3 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts   |   3 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi        |   3 +-
 arch/arm/boot/dts/tegra124-venice2.dts      |   3 +-
 arch/arm/boot/dts/tegra124.dtsi             |   2 -
 arch/arm/boot/dts/tegra20-colibri-256.dtsi  |  11 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi  | 535 +--------------------------
 arch/arm/boot/dts/tegra20-colibri.dtsi      | 536 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-harmony.dts       |   3 +-
 arch/arm/boot/dts/tegra20-iris-256.dts      |   9 +
 arch/arm/boot/dts/tegra20-iris-512.dts      |  99 +----
 arch/arm/boot/dts/tegra20-iris-common.dtsi  | 107 ++++++
 arch/arm/boot/dts/tegra20-paz00.dts         |   3 +-
 arch/arm/boot/dts/tegra20-seaboard.dts      |   3 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi     |   3 +-
 arch/arm/boot/dts/tegra20-trimslice.dts     |   3 +-
 arch/arm/boot/dts/tegra20-ventana.dts       |   3 +-
 arch/arm/boot/dts/tegra20.dtsi              |   7 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi       |   9 +-
 arch/arm/boot/dts/tegra30-beaver.dts        |   6 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi       |   3 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi      |   5 +-
 arch/arm/boot/dts/tegra30.dtsi              |   7 +-
 29 files changed, 720 insertions(+), 663 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-256.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-iris-256.dts
 create mode 100644 arch/arm/boot/dts/tegra20-iris-common.dtsi

-- 
2.7.4
