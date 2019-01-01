Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC389C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C425218A4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546378807;
	bh=6ZVRD6ioRHp9X/OpZRSOJpqkjB7oULJ/6TrPP3whPww=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GUqMuN3+Ibk/paw1NKrSdHWB8KIlfbxDia2Pw6BZeIE/JksuFMpaEvpobK95e74wA
	 35jXQMXuplzTEl9Vmic+IcbZgXKcv7lYAZ6aK4jGRjX3go6JUvo1WAhrZ6hBAShTye
	 1qXsb42GURg9MiB0a9+9ERWwh9yFXYGlgB4ID+Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfAAVkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbfAAVkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:40:04 -0500
Subject: Re: [GIT PULL] RTC for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546378803;
        bh=6ZVRD6ioRHp9X/OpZRSOJpqkjB7oULJ/6TrPP3whPww=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2uNnwNnWBE2U3/RxNrszli6SQLiidSjyGK1AnEu75eXbxoMuZ0fZUx+TLsqxSsnz/
         VgxzgzxlTiqQebCqTdJSdyUSvigBwA4Np+o5eL0G3a5J1ExGB7tWOKXPeNyArg6aOJ
         rnbVoEAN+IW7R6bwZ37Uubg5hwX8nqa1JG07UeSg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231174557.GA16020@piout.net>
References: <20181231174557.GA16020@piout.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231174557.GA16020@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 tags/rtc-4.21
X-PR-Tracked-Commit-Id: 36e14f5fdfdf7cec8887b7ff69cd9bb5051ecf62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28e8c4bc8eb483c22d977e147a0b98fc63efadf7
Message-Id: <20190101214003.29500.86237.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 01 Jan 2019 21:40:03 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 18:45:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28e8c4bc8eb483c22d977e147a0b98fc63efadf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
