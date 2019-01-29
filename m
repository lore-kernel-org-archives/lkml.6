Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB5CC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E107620989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfA2SyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:54:21 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfA2SyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:54:21 -0500
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mjjvp-1hZPsD0UDD-00lEHP; Tue, 29 Jan 2019 19:54:14 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/3] bcm2835-dt-next-2019-01-29
Date:   Tue, 29 Jan 2019 19:53:26 +0100
Message-Id: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:rcOOSYolGStfJdNcq/KlyY6sP9DYafv5w8GyaG8lzQAEVBzTkZF
 lVerjWkAPb261nFtlnVEcBWy2ccodBkxXRncG38cC6ZTyMqNDDvGMJ94Y+fDIYewYWJ4Z86
 6qeCrjAvSL3mQpCUVImyU5kR5JbMQen5nx82/98469oDo9XTwFQwFcBaSkatwEOcU349s9j
 bodJZWMDCn9nXiCWiIQ2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iQlBNvaJYu8=:JByGSd8FQv33Nv2x4R5S8c
 VPCGo+1r7VlDVOyca6gWOucU2ryIgrTvLG+mZExdmf06D61dtGlwbjHA2Pbw7Hvya11WI4pV/
 Ro8IrRauPjJu7vNpRMIfeEXhVSA08SNq9Q5trZIY09XelG6XbcyMegaiRLjaRVeYwMfc9j3v+
 EwZmruvEaq+l471l5jyG9OQyydnOPOiYNTuupbDk/zYacANRobbRotTv6Ze/6ho3s9skSoshv
 Tl3JzXdu5OrkbQNAnAtvwunoVB8dSC8sv+UG0KQiHFgJLqyApP1iTxPT9K+G5pcPPBWlymHbF
 nRH1Tz/E8zG1DBjoDEkRehxiDuh84n29RYX8LKQ0Q+iyVCTQsstNHmAEGP30Q4Pfn2e9p6/E/
 Y0wZTWPyECHDJM13gRoICmIR0f3atU+gH7n4XlcOdigx1bir7acfixlry09J8j2Cw9YDP7ci7
 u804r0i4Q/ytXinenvtSxXtIs9gE4iEP5ELFRixZ9HPYXyDgNgo8P8tXvSk4shQFy5Bgcvrx5
 K36s8ninRaaVkzItksOV+6katJ6fQTKNEft4t9JYn/jSmZ91E+FSgEVD4cwT5vlKYeeeIXqYh
 eTKbAwighTLV9/mU0tM8VyFg/n6nl8+Ntxm3vlukoozKP72qyD+Tc14TVrSjDh3IjKJn3p67B
 8Y54W8EgkLJtrl5U2LaavJcrXjeL8CllhPP3XPGtpqeGDNQiveNVF/22S/jk14RdckKMty/vx
 MJncoggg9ofAXA+7+NEQ7Fjsrd9D1oWvoCV6RJnS2NVGwFUVL9dq8SLGcZw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

sorry for being that late and hoping it's not too late.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2019-01-29

for you to fetch changes up to 14117e0af4a853b2b37925f526b2bfe1cfc7b285:

  ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-01-22 07:25:59 +0100)

----------------------------------------------------------------
This pull request adds the necessary changes for the new BCM2835 PM driver,
support for the new Raspberry Pi 3 A+ and the missing GPIO labels for RPi 2/3.
Additionally it contains some minor DT fixes.

----------------------------------------------------------------
Eric Anholt (2):
      ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block. (v4)
      ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.

Stefan Wahren (9):
      dt-bindings: bcm: Add Raspberry Pi 3 A+
      ARM: dts: add Raspberry Pi 3 A+
      ARM: dts: bcm283x: Fix DTC warning for memory node
      ARM: dts: bcm2835-rpi: Drop unnecessary #address-cells/#size-cells
      ARM: dts: bcm2835: Fix labels for GPIO 0,1
      ARM: dts: bcm2837-rpi-3-b: Use consistent label for HDMI hotplug
      ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for STATUS_LED
      ARM: dts: bcm283x: Add missing GPIO line names
      ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  11 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   4 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   8 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  68 +++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 175 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  74 ++++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  74 ++++++++-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |  17 +-
 13 files changed, 415 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
