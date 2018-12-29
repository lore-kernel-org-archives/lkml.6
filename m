Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4187DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049372087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546107319;
	bh=lzkBc8gJnNTWOrYgl+CWEehBP51jL0FA7n8VCSs3TEU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tRfOdafYQnI0h6elJsF3xW2Fur8UaTAGeok7Yj/z7hZiyWoeqv8xhhi1KmZKZJK3C
	 asohhh/5h+reR2au5FFZ68sh3mdHmj68odg7kN63OACacInqELV7LazCAdZBjB9EuK
	 D/w9/IeTCmHrdte+sdhGAQ7RmnKKo7bt03ysg5z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeL2SPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbeL2SPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:15:03 -0500
Subject: Re: [PULL 00/25] Xtensa updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546107303;
        bh=lzkBc8gJnNTWOrYgl+CWEehBP51jL0FA7n8VCSs3TEU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dy/CjL1tF26wahaJY/98WBG/mrnDY1Cnn7RnV8BKeW8doPsxLRP5VvQ+aPUZyyvjX
         DiIEhJyygi1UK64aQFBmndXJBkMx/LEb7obr0+lW87hSmD7EWErJjoWOw0oiZLJcAA
         pOlhNfHzuFgpRRGkOzj+EXlf2LpgLTnA8OVrLiRI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228183120.23058-1-jcmvbkbc@gmail.com>
References: <20181228183120.23058-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228183120.23058-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20181228
X-PR-Tracked-Commit-Id: 64711f9a47d4defa90417f5e8db8ed0060bc3275
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ef10340749e1da0c7fde609cedd5360f8484a0b
Message-Id: <20181229181502.27859.16610.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 18:15:02 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 10:31:20 -0800:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20181228

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ef10340749e1da0c7fde609cedd5360f8484a0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
