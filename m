Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C1BC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352BA222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550007922;
	bh=bPDDenangOOi6e95JV75EXEJq/LsHTGT+kd4X2xA1L8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JlBjnNpuDp45pyHsNY3cGrK51A6Fp3Eobc4/+MwWCsD3ZQf3ER2ENe0Gpyq0OIVeK
	 7oZAPk0512S4B6L8f2L3QKtI6O2xcgm8/OPmHZvH+vaXmA2SCxTUGM2pZYTSk6yVg2
	 slFHJU4qD5cn52eg2etXbt/VW2O//zpYt/Ze6nww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfBLVpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732653AbfBLVpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:45:04 -0500
Subject: Re: [GIT PULL] RISC-V Fixes for 5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550007903;
        bh=bPDDenangOOi6e95JV75EXEJq/LsHTGT+kd4X2xA1L8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uuNj6U4QM50S0tYcqRSDbLwlM1zts3XevOlsE7g1DlOOZWD5f2Qymr43f6S2S4tSx
         WLnvqM7aD+jx6DJ21LwU2JXr13SNbdA0Vt5Egx6GTXmkgaQN9bSnugRV57WxDuhW4F
         w7QTfsboOTcLQd/UDhPHIWJzG7wtJ28ZO+TUtJ40=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-57c6009c-7e1d-4742-af0a-807c08dab07a@palmer-si-x1c4>
References: <mhng-57c6009c-7e1d-4742-af0a-807c08dab07a@palmer-si-x1c4>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-57c6009c-7e1d-4742-af0a-807c08dab07a@palmer-si-x1c4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
 tags/riscv-for-linus-5.0-rc7
X-PR-Tracked-Commit-Id: 41fb9d54f12b87fb1f670653e95d34668a08e8ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57902dc0670c2926b0b5cc93a1e2ddf09d53e706
Message-Id: <155000790389.22230.12737198135434561900.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Feb 2019 21:45:03 +0000
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Feb 2019 13:18:49 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57902dc0670c2926b0b5cc93a1e2ddf09d53e706

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
