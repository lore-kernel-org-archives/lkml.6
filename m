Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03758C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44721477
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A44721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeHYMOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:14:22 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:45840 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeHYMOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:14:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4ACA0605AD44;
        Sat, 25 Aug 2018 10:36:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id av5V2huLdciN; Sat, 25 Aug 2018 10:36:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D5228605AD32;
        Sat, 25 Aug 2018 10:36:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mx2bREqOH6Zd; Sat, 25 Aug 2018 10:36:05 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 9D2B36088983;
        Sat, 25 Aug 2018 10:36:05 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBIFS fix for 4.19-rc1
Date:   Sat, 25 Aug 2018 10:36:05 +0200
Message-ID: <10888946.TpHzFjB4nf@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 99a24e02ccf6604e3020cf9e2c7a042b6ebb655f:

  ubifs: Set default assert action to read-only (2018-08-15 00:25:22 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-ubifs.git tags/upstream-4.19-rc1-fix

for you to fetch changes up to 6e5461d774bf42aae622ad0f3ff53e41962f886b:

  ubifs: Remove empty file.h (2018-08-24 13:50:07 +0200)

----------------------------------------------------------------
This pull request contains a single fix for UBIFS:

- Remove an empty file from UBIFS source

----------------------------------------------------------------
Richard Weinberger (1):
      ubifs: Remove empty file.h

 fs/ubifs/file.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 fs/ubifs/file.h



