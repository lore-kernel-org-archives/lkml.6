Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeBCPuk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:50:40 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:46553 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752103AbeBCPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:50:35 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH v2 0/2] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Sat,  3 Feb 2018 16:50:14 +0100
Message-Id: <20180203155016.51909-1-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the audio codec on the Haikou Baseboard when used with a RK3399-Q7.

Changes in v2:
- reordered entries as suggested in review
- removed a conflicting i2s definition in rk3399-puma-haikou.dts
  i2s0 was already enabled in rk3399-puma.dtsi as it should be,
  so reuse it and fix the incorrect rockchip,*-channels values
- add a patch to the series that definies a generic i2s0-2ch-bus
- overwrite the generic pin definition of i2s0-2ch-bus with a specific
  one used in the Haikou with RK3399-Q7 setup.

Klaus Goger (2):
  arm64: dts: rockchip: add i2s0-2ch-bus pins on rk3399
  arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou

 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 59 +++++++++++++++++++---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 25 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 10 ++++
 3 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.11.0
