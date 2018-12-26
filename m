Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA48218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545858649;
	bh=a7td0iJ2MgxUm5EBk8hHdm7m/W0BbBOb5xzs17qSB6w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=grs3fXyUZYiCYMchz3peGjigsDlwAqv6Uml8/J9HWj0+Aig53NaejZiubd3uO7r0g
	 vX0WM+WJYjPVsLD93NxSeg2CvwNLCc+KpCt7/ogNjZ1TEPsaVwrAYcpq0cALS+dfUS
	 6C2+RSzX+nWBERukq4WJg77waizXlBRn/kTuNtY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeLZVKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbeLZVKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:10:03 -0500
Subject: Re: [GIT PULL] x86/microcode updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545858602;
        bh=a7td0iJ2MgxUm5EBk8hHdm7m/W0BbBOb5xzs17qSB6w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oRkm2KnlGXtX16Feb9nmZTj41p7SfL21sEyxaZXemjDozc1SVO9pH9hQc1mhNveWl
         YLHqp2fOyFgbVu+xJf3oJkg3ALNO2f1ydgy1XF1VJiJEUslk71ydYw/0K0NjnHK+g4
         a9fnU7lToYFE2C1MQmWbc0WPU1uDvFEWLdNUnn7o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181223125138.GB26860@zn.tnic>
References: <20181223125138.GB26860@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181223125138.GB26860@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-microcode-for-linus
X-PR-Tracked-Commit-Id: 2ffcbce39ea1e355eed8c6527308624f366f1c58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72af84151fa7e98720a0482b59de2d90ec7f10a7
Message-Id: <20181226211002.9490.22315.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 21:10:02 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 13:51:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72af84151fa7e98720a0482b59de2d90ec7f10a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
