Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA856C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A308521902
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545961519;
	bh=8gVo0O0mH/2oXIvgeiCEreVsjfrpo33QWozTs9bJ2Q8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pQovWdGbjLKBgVDal2/2Yznz2llzlpWbmVRI/uQKdfNdMViga34dR9u5+fA/vZOwQ
	 wSpqdvxTMv8yl7itOnZxa+Kvjs9GjXJlgANtLI9nIZ4BmgIwsbGN80PrlIbD03q5kk
	 21to6Effl7zF1cKmPIesrRergwtZw7A24Mpz39pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeL1BpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731349AbeL1BpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:45:04 -0500
Subject: Re: [GIT PULL] File locking changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545961504;
        bh=8gVo0O0mH/2oXIvgeiCEreVsjfrpo33QWozTs9bJ2Q8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mFa+oZnZ39IEdu9BQkmpuBU8rWelalJM0q7tDV20hUgxqyORd2/sfWqtaZX6sHPSx
         u8KokeVeFFQjVQvYzj4Z+bmqqY9tPVm1bRLewuKbCQ8jKhiI9MmhVK4jXuR9B6c9ll
         XmIeuZc9z1Tr2QiimU3oBVUfAiaoeTWiFcsU3zIY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9d429d110c16472f531e9dcd0a2ac6dfcdc0ad20.camel@kernel.org>
References: <9d429d110c16472f531e9dcd0a2ac6dfcdc0ad20.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9d429d110c16472f531e9dcd0a2ac6dfcdc0ad20.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 tags/locks-v4.21-1
X-PR-Tracked-Commit-Id: 052b8cfa4070caa53125cd589da0cfe744132a94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00c569b567c7f1f0da6162868fd02a9f29411805
Message-Id: <20181228014504.3597.71370.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 28 Dec 2018 01:45:04 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Neil Brown <neilb@suse.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 06:06:16 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00c569b567c7f1f0da6162868fd02a9f29411805

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
