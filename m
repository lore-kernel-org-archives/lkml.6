Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935154AbeB1Vjz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:39:55 -0500
Received: from anholt.net ([50.246.234.109]:34536 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932597AbeB1Vju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:39:50 -0500
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 2/2] bcm2835-defconfig-next-2018-02-28
Date: Wed, 28 Feb 2018 13:39:45 -0800
Message-Id: <20180228213945.6781-2-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228213945.6781-1-eric@anholt.net>
References: <20180228213945.6781-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-02-28

for you to fetch changes up to bb9d91a4e5c87cabfa2c9d35761374aa11150c2d:

  ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3 (2018-02-26 15:30:43 -0800)

----------------------------------------------------------------
This pull request enables several recent drivers for the Raspberry Pi
family in the defconfigs (thermal, BT, aux serial).

----------------------------------------------------------------
Stefan Wahren (2):
      ARM: bcm2385_defconfig: Enable BT support for BCM43438
      ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3

Tuomas Tynkkynen (1):
      ARM: multi_v7_defconfig: Enable serial console on RPi 3

 arch/arm/configs/bcm2835_defconfig  | 4 ++++
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 2 files changed, 8 insertions(+)
