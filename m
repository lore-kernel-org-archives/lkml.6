Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73606C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178EB2404A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178EB2404A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeGCUGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:06:39 -0400
Received: from anholt.net ([50.246.234.109]:42476 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbeGCUFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:05:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8F52C10A18B9;
        Tue,  3 Jul 2018 13:05:14 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WW1T7i8AH3Et; Tue,  3 Jul 2018 13:05:12 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id BCAB310A17E3;
        Tue,  3 Jul 2018 13:05:12 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id A8B432FE463C; Tue,  3 Jul 2018 13:05:11 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 3/4] bcm2835-defconfig-next-2018-07-03
Date:   Tue,  3 Jul 2018 13:05:10 -0700
Message-Id: <20180703200511.2725-3-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703200511.2725-1-eric@anholt.net>
References: <20180703200511.2725-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-07-03

for you to fetch changes up to 7b54aafff3ef4571567ff6a7d13ed51554f07a71:

  ARM: multi_v7_defconfig: Enable RPi voltage sensor (2018-06-21 17:29:51 -0700)

----------------------------------------------------------------
This pull request enables the new RPi HWMON driver in the 32-bit
defconfigs.

----------------------------------------------------------------
Stefan Wahren (2):
      ARM: bcm2835_defconfig: Enable RPi voltage sensor
      ARM: multi_v7_defconfig: Enable RPi voltage sensor

 arch/arm/configs/bcm2835_defconfig  | 2 +-
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
