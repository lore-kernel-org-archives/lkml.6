Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700CD21901
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545961512;
	bh=jJkHocf4VuKd6XqJ8oi7zZVy5PZYU7oYPaDXh+N/3cw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OIbyEY07ChC7f8+XFjnTIdlcgX/2MnIzawRB54Cd5wZx9JlS0KjvpDBZb2JqqyGV6
	 iJEFo9+y4AoWKDAR9z97b/dJMzhksb6+4P1IWjOfgr8yBM9/PNZZRd30LnwhPrP61H
	 jYDkNo0S+FfPNBTbzbPKXaBa6Dk4R7BbOvC6kXJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbeL1BpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbeL1BpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:45:02 -0500
Subject: Re: [GIT PULL] dlm updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545961502;
        bh=jJkHocf4VuKd6XqJ8oi7zZVy5PZYU7oYPaDXh+N/3cw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JiqGC3vjQcZX69RLS6HqYS4sryY6yAJBq9vpC25gSqENRQNGZSyY3XHGOsXCxgwWX
         CN2j1iSK3nL3dIpQ2oBFoTjVSxFfPZ5JLeTCrBvHj3Lx0XIFz89GgnYSYJN0MrhzTZ
         cMuk0Lmn8egVanllOOUOlGbALZHglL5PVDd/uLcw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181219171722.GA14517@redhat.com>
References: <20181219171722.GA14517@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181219171722.GA14517@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-4.21
X-PR-Tracked-Commit-Id: 3595c559326d0b660bb088a88e22e0ca630a0e35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4de3aea385f5a054885bc96ffdb9c7d0ea0c9486
Message-Id: <20181228014502.3597.55728.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 28 Dec 2018 01:45:02 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Dec 2018 11:17:22 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4de3aea385f5a054885bc96ffdb9c7d0ea0c9486

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
