Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755190AbeD3V14 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:27:56 -0400
Received: from anholt.net ([50.246.234.109]:40736 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755085AbeD3V1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:27:54 -0400
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 3/3] bcm2835-defconfig-64-next-2018-04-30
Date: Mon, 30 Apr 2018 14:27:50 -0700
Message-Id: <20180430212750.12303-3-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430212750.12303-1-eric@anholt.net>
References: <20180430212750.12303-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-64-next-2018-04-30

for you to fetch changes up to 69bc5b2c056b4e784b49a8c9c5049561b62352f7:

  arm64: defconfig: Enable LAN and BT support for RPi 3 B+ (2018-04-23 13:28:33 -0700)

----------------------------------------------------------------
This pull request enables the Raspberry Pi 3 B+'s LAN and bluetooth in
the arm64 defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      arm64: defconfig: Enable LAN and BT support for RPi 3 B+

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
