Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbeD3V2P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:28:15 -0400
Received: from anholt.net ([50.246.234.109]:40752 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755160AbeD3V1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:27:55 -0400
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 2/3] bcm2835-defconfig-next-2018-04-30
Date: Mon, 30 Apr 2018 14:27:49 -0700
Message-Id: <20180430212750.12303-2-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430212750.12303-1-eric@anholt.net>
References: <20180430212750.12303-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-04-30

for you to fetch changes up to 329fb2b79b132d727dd8a1624da8dc5331eb8633:

  ARM: multi_v7_defconfig: Enable LAN and BT for RPi 3 B+ (2018-04-23 13:25:49 -0700)

----------------------------------------------------------------
This pull request enables recent new drivers for the Raspberry Pi, including
the networking on the Pi 3 B+.

----------------------------------------------------------------
Stefan Wahren (3):
      ARM: bcm2835_defconfig: Enable LAN78XX driver
      ARM: bcm2835_defconfig: Enable VCHIQ driver
      ARM: multi_v7_defconfig: Enable LAN and BT for RPi 3 B+

 arch/arm/configs/bcm2835_defconfig  | 2 ++
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 2 files changed, 6 insertions(+)
