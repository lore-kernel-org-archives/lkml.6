Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583F32147C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583F32147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeHVIlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 04:41:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50578 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 04:41:06 -0400
Received: from localhost (unknown [172.58.46.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A4E57101AD025;
        Tue, 21 Aug 2018 22:17:51 -0700 (PDT)
Date:   Tue, 21 Aug 2018 22:17:50 -0700 (PDT)
Message-Id: <20180821.221750.2043917894955366743.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] IDE
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Aug 2018 22:17:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Remove redundant variables, from Colin Ian King.

2) Expected switch fall-through annotations, from Gustavo A. R. Silva

Please pull, thanks!

The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to a2eed33dcdb7663170b01f05dd8d0a3323ffe4b3:

  ide: mark expected switch fall-throughs (2018-08-13 11:48:54 -0700)

----------------------------------------------------------------
Colin Ian King (2):
      ide: remove redundant variables queue_run_ms and left
      ide-tape: remove redundant variable buffer_size

Gustavo A. R. Silva (1):
      ide: mark expected switch fall-throughs

 drivers/ide/hpt366.c       | 5 +++--
 drivers/ide/ide-floppy.c   | 1 +
 drivers/ide/ide-io.c       | 4 ----
 drivers/ide/ide-probe.c    | 1 +
 drivers/ide/ide-tape.c     | 2 --
 drivers/ide/ide-taskfile.c | 3 ++-
 drivers/ide/sis5513.c      | 1 +
 7 files changed, 8 insertions(+), 9 deletions(-)
