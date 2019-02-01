Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D32218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfBATYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:24:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfBATYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:24:33 -0500
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8oKc-1hB2qw2dE6-015n5t; Fri, 01 Feb 2019 20:24:20 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/2] bcm2835-dt-next-2019-02-01
Date:   Fri,  1 Feb 2019 20:24:13 +0100
Message-Id: <1549049054-5460-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:I5sBIGmJddb4MhTsn1EG8BB+ZrawnwL7cuxMpkD5jviRjx+B0nZ
 /GXSWk6jWsWlYh/ECXGuEOSHHx3qTsJenpCco9u63Yt9XK7kGN424dGacgEvVKr/6DhfaHn
 aoO0EyIx2k3305+p4K7n13vIwCaFmciKvZ68SDSikZ6sgA1TL1DFBqriL0EETZMS/BTdybc
 iDdMP8W6SqBN2RcwEggAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qndrzgWY89c=:yuCn4VCDmNFf8LNerIsmtc
 x9S44s5Rvz/E+bQ5OyW5PoPkC4Qlqhlt2a/wB0fOhuErnq0Bzv9MbpjYqwfrxtH6sI2DCzaAD
 BqxDqbrX6FdZuxXOyfevzayZ63FqiGWwPt/HBBHryWHmnTiV2u+nM5KAQd77x4HAPs4m7O6TE
 kqiJfoxVB5eW/fkuncHd1ywXEROV160nnW1nNxbP8+685GAFhyuqUMW/rLJ0b1sRicVGrXTiz
 GKJyrC8ADVmUsI5TWwXTYKvDhAyCANt4nDuiwvZiPSf3bzdfQg6ffzNykcukMTGU1fOQKBoXc
 qmo9Tio/TUPkRpCss8zyxiBNh/6JYE/TTH1I0vXEin/pM+6gn3uuaGMosopC9o72APuaRAc4d
 FIx4KGE+utKu23o8w9+I7i3NeCHYu3ipFaDs6ITUZVpuATdu/qM5gvjZeear2ILXPzVNPJdua
 dsILvYxa/76vyYDGck2ABdFD0IQB4ahvX9bnqI+eoHvaKa3GSXwI79LmJzlqw84gZdwDJl4hx
 ep5JoIMaz4ryAo3Vn0s3cCf4yHzsK9iO4oyDd/Irq5hU9cNFC2d1jFV2iAvAXiHxloqwacx6M
 DjgIyV9Mq0JyNXAbH8N3iGVUNV7gHJy4gBNDUFDYiASHgY3KIxqRA0LVZse4qfNqwrruPZT2f
 yS67FVa0nkPh8kGeYQmMz9CLoCOvsJRq5AaEXHINYvwBx3Iqj20VTyA9/mwydeZG5sjWv4Ulr
 NVhsGnUBmjy0wSf8ypz0u9O0BZoLCciK0qgBnsEqJYL5s3vCzDJdNfgPCsY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

this is fixup of the last pull request. I moved all parts of the PM driver
out of this pull request in order to avoid any conflicts. 

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2019-02-01

for you to fetch changes up to ab1b4ef966af90ad79fa3c4c124e47915cddde10:

  ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-01-22 07:25:59 +0100)

----------------------------------------------------------------
This pull request adds support for the new Raspberry Pi 3 A+ and
the missing GPIO labels for RPi 2/3. Additionally it contains
some minor DT fixes.

----------------------------------------------------------------

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

