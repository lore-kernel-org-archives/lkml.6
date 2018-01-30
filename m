Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeA3Mjm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:39:42 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:36666 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751974AbeA3Mjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:39:41 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH 0/4] add RK3368-uQ7 SoM
Date: Tue, 30 Jan 2018 13:39:27 +0100
Message-Id: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds devicetree files for Theobroma Systems RK3368-uQ
module and the corresponding evaluation kit baseboard.

See https://www.theobroma-systems.com/rk3368-uq7/ for more information
about the module and devkit.

@Heiko: I added the OPP points I use as a seperate patch so you
can decide if you want to merge it or not as i noticed your reverts
in the last cycle.


Klaus Goger (4):
  dt-bindings: add RK3368-uQ7 SoM and EVK base board
  arm64: dts: rockchip: add RK3368-uQ7 (Lion) SoM
  arm64: dts: rockchip: add Haikou baseboard with RK3368-uQ7 SoM
  arm64: dts: rockchip: add OPPs for rk3368-lion

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../arm64/boot/dts/rockchip/rk3368-lion-haikou.dts | 146 ++++++++
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      | 397 +++++++++++++++++++++
 3 files changed, 547 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi

-- 
2.11.0
