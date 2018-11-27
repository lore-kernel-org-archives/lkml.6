Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE51C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90164208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90164208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeK1IMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:12:16 -0500
Received: from anholt.net ([50.246.234.109]:45766 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbeK1IMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:12:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EF80310A156C;
        Tue, 27 Nov 2018 13:13:04 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id shXrOvXF7DK8; Tue, 27 Nov 2018 13:13:04 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6CEB810A0EA3;
        Tue, 27 Nov 2018 13:13:02 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7B9B32FE2D5B; Tue, 27 Nov 2018 13:13:01 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 2/4] bcm2835-soc-next-2018-11-27
Date:   Tue, 27 Nov 2018 13:12:59 -0800
Message-Id: <20181127211301.30296-2-eric@anholt.net>
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

  git://github.com/anholt/linux tags/bcm2835-soc-next-2018-11-27

for you to fetch changes up to 7b369a42e6d06c59fc56a1769fb4da797fac9bad:

  ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier (2018-11-14 20:55:30 +0100)

----------------------------------------------------------------
This pull request adds SPDX identifiers to the bcm2835 platform files.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier

 arch/arm/mach-bcm/board_bcm2835.c | 11 +----------
 arch/arm/mach-bcm/platsmp.c       | 10 +---------
 arch/arm/mach-bcm/platsmp.h       |  6 +-----
 3 files changed, 3 insertions(+), 24 deletions(-)
