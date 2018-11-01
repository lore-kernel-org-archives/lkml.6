Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7461BECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B07E20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B07E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeKAKpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:45:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57822 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKAKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:45:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4FB0614711CC8;
        Wed, 31 Oct 2018 18:44:19 -0700 (PDT)
Date:   Wed, 31 Oct 2018 18:44:18 -0700 (PDT)
Message-Id: <20181031.184418.1509890447175181068.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Oct 2018 18:44:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Two small fixes, please pull.

Thanks!

The following changes since commit 4b42745211af552f170f38a1b97f4a112b5da6b2:

  Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-10-29 15:37:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 1f2b5b8e2df4591fbca430aff9c5a072dcc0f408:

  sparc64: Wire up compat getpeername and getsockname. (2018-10-31 18:30:21 -0700)

----------------------------------------------------------------
David S. Miller (2):
      sparc64: Remvoe set_fs() from perf_callchain_user().
      sparc64: Wire up compat getpeername and getsockname.

 arch/sparc/kernel/perf_event.c | 5 -----
 arch/sparc/kernel/systbls_64.S | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)
