Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeCLEYC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:24:02 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47702 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeCLEX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:23:59 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ARM: dts: sun8i: a33: Improvements for A33-OLinuXino
Date: Mon, 12 Mar 2018 12:23:52 +0800
Message-Id: <20180312042356.18625-1-wens@csie.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some cleanup and improvements for the A33-OLinuXino device
tree. The first two patches drop some unneeded bits. The latter two
enable peripherals that we now support.

ChenYu

Chen-Yu Tsai (4):
  ARM: dts: sun8i: a33: Drop GPIO pinmux settings for A33-OLinuXino
  ARM: dts: sun8i: a33: Drop sunxi-common-regulators.dtsi for
    A33-OLinuXino
  ARM: dts: sun8i: a33: Enable PMIC power supplies on A33-OLinuXino
  ARM: dts: sun8i: a33: Enable A33 internal audio codec on A33-OLinuXino

 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 55 ++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 23 deletions(-)

-- 
2.16.2
