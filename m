Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBIRwm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:52:42 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38206 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbeBIRwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:52:40 -0500
X-Google-Smtp-Source: AH8x227Yj+RjQL0D6ntBZsr+3a3ojml0sb4t93/Yk0JMlDeHFgXKxZfIS9+vL4ip2emz6TCAEmFTwA==
From: Philipp Rossak <embed3d@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] Fix broken bananapi m2 devicetree/regulators
Date: Fri,  9 Feb 2018 18:52:33 +0100
Message-Id: <20180209175236.21215-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchseries fixes the bananapi m1 devicetree, to be able to boot again.
The first two patches update/improve the devicetree and the last patch adds
all missing regulators.

Regards,
Philipp

Philipp Rossak (3):
  arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
  arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
  arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators

 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 70 +++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 3 deletions(-)

-- 
2.11.0
