Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8777AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC572404A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC572404A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeGCUGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:06:42 -0400
Received: from anholt.net ([50.246.234.109]:42490 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbeGCUFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:05:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A4AC610A18B0;
        Tue,  3 Jul 2018 13:05:15 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id JG3rPka8BCo5; Tue,  3 Jul 2018 13:05:12 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A38E910A0EEB;
        Tue,  3 Jul 2018 13:05:12 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 93B152FE2D94; Tue,  3 Jul 2018 13:05:11 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 1/4] bcm2835-dt-next-2018-07-03
Date:   Tue,  3 Jul 2018 13:05:08 -0700
Message-Id: <20180703200511.2725-1-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-07-03

for you to fetch changes up to 7503668f7287a359f234cd000f4ca8572e40677b:

  ARM: dts: bcm283x: Add Transposer block (2018-07-02 12:46:20 -0700)

----------------------------------------------------------------
This pull request brings in a board DT for the Raspberry Pi Compute
Module and its I/O board, the Pi3's PMU node, and the display's
transposer block.

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: dts: bcm283x: Add Transposer block

Eric Anholt (1):
      arm: bcm2835: Add the PMU to the devicetree.

Stefan Wahren (1):
      ARM: dts: add Raspberry Pi Compute Module and IO board

 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts | 88 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi    | 34 ++++++++++++
 arch/arm/boot/dts/bcm2837.dtsi            |  6 +++
 arch/arm/boot/dts/bcm283x.dtsi            |  6 +++
 5 files changed, 135 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
