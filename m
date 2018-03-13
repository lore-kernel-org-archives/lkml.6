Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeCMRa0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:30:26 -0400
Received: from anholt.net ([50.246.234.109]:40834 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbeCMRaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:30:25 -0400
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [GIT PULL] bcm2835-dt-next-2018-03-13
Date: Tue, 13 Mar 2018 10:30:22 -0700
Message-Id: <20180313173022.30314-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit bcc76c4014dce4e3834dbd5b7f6593cbcfbfebe0:

  ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode (2018-02-26 15:02:23 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-03-13

for you to fetch changes up to ae67cfc4f6abb379e5bbe9a5616f00b23bbecb01:

  ARM: bcm2835: Add the DPI hardware to the device tree. (2018-03-12 11:44:29 -0700)

----------------------------------------------------------------
This pull request brings in one last patch to add the BCM2835 DPI
controller to the device tree.

----------------------------------------------------------------
Eric Anholt (1):
      ARM: bcm2835: Add the DPI hardware to the device tree.

 arch/arm/boot/dts/bcm283x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)
