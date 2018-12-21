Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20810C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF72C2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbeLUUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:42:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52752 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbeLUUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:42:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B3A1D14A92C11;
        Fri, 21 Dec 2018 12:42:43 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:42:43 -0800 (PST)
Message-Id: <20181221.124243.1852216989215465396.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 12:42:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just some small fixes here and there, and a refcount leak in a serial
driver, nothing serious.

Please pull, thanks!

The following changes since commit cf76c364a1e1e5224af80edf70a1e3023e1fcf8c:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-12-05 17:06:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to d430aff8cd0c57502d873909c184e3b5753f8b88:

  serial/sunsu: fix refcount leak (2018-12-21 11:24:38 -0800)

----------------------------------------------------------------
Corentin Labbe (1):
      sparc: Set "ARCH: sunxx" information on the same line

Yangtao Li (1):
      serial/sunsu: fix refcount leak

ndesaulniers@google.com (1):
      sparc: vdso: Drop implicit common-page-size linker flag

 arch/sparc/kernel/setup_32.c | 13 ++++++-------
 arch/sparc/kernel/setup_64.c |  4 ++--
 arch/sparc/vdso/Makefile     |  2 +-
 drivers/tty/serial/sunsu.c   | 31 ++++++++++++++++++++++++++-----
 4 files changed, 35 insertions(+), 15 deletions(-)
