Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53213C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FC521104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FC521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeK1IMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:12:18 -0500
Received: from anholt.net ([50.246.234.109]:45788 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeK1IMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:12:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2D4E310A0E8E;
        Tue, 27 Nov 2018 13:13:06 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id RKRUyMiXmZXg; Tue, 27 Nov 2018 13:13:05 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 826B910A0F99;
        Tue, 27 Nov 2018 13:13:02 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 83AED2FE2D68; Tue, 27 Nov 2018 13:13:01 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 4/4] bcm2835-dt-next-2018-11-27
Date:   Tue, 27 Nov 2018 13:13:01 -0800
Message-Id: <20181127211301.30296-4-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181127211301.30296-1-eric@anholt.net>
References: <20181127211301.30296-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-11-27

for you to fetch changes up to 703c605fac82d580822dc39f5eff9e2fe66ed63d:

  ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier (2018-11-13 19:32:28 +0100)

----------------------------------------------------------------
This pull request adds a compatible string to the DT necessary for the
firmware and VCHI driver to coordinate on using the correct cache line
size for the platform.

----------------------------------------------------------------
Phil Elwell (3):
      dt-bindings: soc: Document "brcm,bcm2836-vchiq"
      ARM: dts: bcm283x: Correct vchiq compatible string
      ARM: dts: bcm283x: Correct mailbox register sizes

Stefan Wahren (1):
      ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier

 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt | 3 ++-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts                         | 8 +-------
 arch/arm/boot/dts/bcm2835-rpi-zero.dts                           | 8 +-------
 arch/arm/boot/dts/bcm2835-rpi.dtsi                               | 4 ++--
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts                            | 2 +-
 arch/arm/boot/dts/bcm2836-rpi.dtsi                               | 6 ++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts                       | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts                            | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi                           | 2 +-
 9 files changed, 16 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi.dtsi
