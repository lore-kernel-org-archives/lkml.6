Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18619C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16772080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546389309;
	bh=u9WMnyvr4NVNnt0MG9v5aVkMwHBh/KL7cavcQ5tGyIg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PTeoUwqTPhaA9G7fwhWC2ox10c1Qs9/kOXbWWZTuNB+CCs157f5Zr242eFPZcVHg1
	 HYxiKyErczTBR+wuodkPdjIn5JHsNwMJC1me8JinxouZXkB2WBgX+I4yrimrcMoDOq
	 5KoIUKsqhU1VLQ0DRINhZnm+NFp5+eAXQm3lC920=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfABAfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfABAfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:35:04 -0500
Subject: Re: [GIT PULL] v4.21 Updates for OpenRISC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546389304;
        bh=u9WMnyvr4NVNnt0MG9v5aVkMwHBh/KL7cavcQ5tGyIg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sUUduExzk+C8JWmuNUSI9Nl0M5CGGBnokbf3ZMcdkjSngcfasRuRB1XkEIoj1g0Kn
         PRkrCG+wW6DIfFUkYo1bt5VgRz2lOMrugz3B7pXtAe5tFJVRQdfljGzw+/NjY5X/7X
         9FdBRVdDgMfyyrJR8TpgvZFLR9h25CYvL2ZV59zU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231222041.GM3235@lianli.shorne-pla.net>
References: <20181231222041.GM3235@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231222041.GM3235@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 57ce8ba0fd3a95bf29ed741df1c52bd591bf43ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbea8c7c793397cdf4ba53a32f99b656467b7c7f
Message-Id: <20190102003504.1457.83473.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 00:35:04 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Jan 2019 07:20:41 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbea8c7c793397cdf4ba53a32f99b656467b7c7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
