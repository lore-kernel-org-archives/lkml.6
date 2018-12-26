Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B15218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545852112;
	bh=aLXw9azIxgflZ0gh+7sAAX02IBOOV1OGPFh90pmn2xg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EE1q31BXK5xRyzQ8/e4eE5mNRQybYMEHshSBTImr3QC7+UKsmYe80xUOcl2uAIgkT
	 IEaLa/ptna1h2kjLI10rau5tI7QYP0hXAO9LW7pwD44zW/hflIKP8xduDs5FW0Rh9C
	 g+PiZgN7AGg/e6IjiNKRoIUuqGfOB4K/EVrAhT64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeLZTVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeLZTUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:20:02 -0500
Subject: Re: [GIT PULL] asm-generic: syscall table script for arch/sh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545852002;
        bh=aLXw9azIxgflZ0gh+7sAAX02IBOOV1OGPFh90pmn2xg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0WQZa+TcJ1xClWhgVdOWEgDF4plgFwsQHW2QJwNO589i4JRk2Zw2CLW9eFB4YGGBX
         f8LO6fF498c3VtlbFqiNLtxOjQfz5rpH98rTjGGgy8A2ebU2j+lMKtNbjgCcpUIRPK
         PMz0HGygrQAo1eDJRng+XUlNctaRHFEsTuh6szGQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3iAF3J8X2yj7JaCaTM_BcZ--2LZj32kkDf55mBn_cQ5g@mail.gmail.com>
References: <CAK8P3a3iAF3J8X2yj7JaCaTM_BcZ--2LZj32kkDf55mBn_cQ5g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3iAF3J8X2yj7JaCaTM_BcZ--2LZj32kkDf55mBn_cQ5g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/asm-generic-4.21
X-PR-Tracked-Commit-Id: 2b3c5a99d5f314960e00950c1782eac9361de30f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 507413a5f88a2240b2c19cb4318166614e2349d9
Message-Id: <20181226192002.20075.524.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 19:20:02 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rich Felker <dalias@libc.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 00:28:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/507413a5f88a2240b2c19cb4318166614e2349d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
