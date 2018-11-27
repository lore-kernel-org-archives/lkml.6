Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932A221104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932A221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeK1IMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:12:15 -0500
Received: from anholt.net ([50.246.234.109]:45758 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbeK1IMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:12:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EBE0E10A156D;
        Tue, 27 Nov 2018 13:13:03 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id qadoVx0LCpIM; Tue, 27 Nov 2018 13:13:02 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5076610A0612;
        Tue, 27 Nov 2018 13:13:02 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 763FB2FE2D5E; Tue, 27 Nov 2018 13:13:01 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 1/4] bcm2835-defconfig-next-2018-11-27
Date:   Tue, 27 Nov 2018 13:12:58 -0800
Message-Id: <20181127211301.30296-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Hopefully I'm not too late this time around.  Stefan's been doing a
great job maintaining the bcm2835 branches, and was waiting for me to
send the PRs.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-11-27

for you to fetch changes up to 24632d6b78a1929b14f32cab762a0859db7086f2:

  ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver (2018-11-15 19:07:36 +0100)

----------------------------------------------------------------
This pull request enables the V4L2 camera driver on the Pi1 defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver

 arch/arm/configs/bcm2835_defconfig | 3 +++
 1 file changed, 3 insertions(+)
