Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B0FA9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7196A208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7196A208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935597AbeFMTbN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:31:13 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38022 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935461AbeFMTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:31:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 58B96609332F;
        Wed, 13 Jun 2018 21:31:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lHbh4TSgxvVF; Wed, 13 Jun 2018 21:31:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 209CA6093349;
        Wed, 13 Jun 2018 21:31:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id umkSRDRF_WSL; Wed, 13 Jun 2018 21:31:10 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EF9C4609332F;
        Wed, 13 Jun 2018 21:31:09 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: [GIT PULL] UML updates for 4.18-rc1
Date:   Wed, 13 Jun 2018 21:31:03 +0200
Message-ID: <1763075.mOQZ1Y9R1k@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.18-rc1

for you to fetch changes up to 5ec9121195a4f1cecd0fa592636c5f81eb03dc8c:

  um: Fix raw interface options (2018-06-10 22:54:47 +0200)

----------------------------------------------------------------
This pull request contains minor updates for UML:
- Fixes for our new vector network driver by Anton
- initcall cleanup by Alexander
- We have a new mailinglist, sourceforge.net sucks.

----------------------------------------------------------------

Alexander Pateenok (1):
      um: remove uml initcalls

Anton Ivanov (2):
      um: Fix initialization of vector queues
      um: Fix raw interface options

Richard Weinberger (1):
      um: Update mailing list address

 MAINTAINERS                      |  3 +--
 arch/um/drivers/vector_kern.c    | 20 ++++++++++++++------
 arch/um/include/asm/common.lds.S |  6 ------
 arch/um/include/shared/init.h    |  5 -----
 arch/um/os-Linux/main.c          | 12 ------------
 5 files changed, 15 insertions(+), 31 deletions(-)

