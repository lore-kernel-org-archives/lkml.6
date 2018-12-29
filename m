Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D17C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D61218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061774;
	bh=uXqmrv269ZG+UKtCo2jjZdjZ0E9ABYFUHo5vITFlFyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AHpOmh+4IMhRQ855jNKHCKqZrtEu1Rwj3J7O26vZ6SvRv9n8CuCIu+PGUwoEYhox8
	 qnzrN6xMM/kr0nREtAPpxkizGhHPsdbDWejE0y/z8tBMRACOTLveOlXl7/AMBHhuuj
	 +Mw/2+/iIzMc2UzIAaajCDG+tGhuUD9HR+erBLsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbeL2FgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbeL2FfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:07 -0500
Subject: Re: [GIT PULL] USB/PHY driver patches for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061707;
        bh=uXqmrv269ZG+UKtCo2jjZdjZ0E9ABYFUHo5vITFlFyk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A0P5DBNKT7rl0Ag7B2RUD0PGzDow2aAIAO1UYbvCuvhJyQXDhX81dR6BVETvqi2MU
         KpFSd7/P/TVPVwNaVm7O8+pTUNpAjnJ8LuJTNHrXHdsX3fFBk6RfU9o057JLE6XnCw
         4euptPmoKWEApbrjAsBS+7nHeGif94vTONhUXJhc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228153442.GA23402@kroah.com>
References: <20181228153442.GA23402@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228153442.GA23402@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
 tags/usb-4.21-rc1
X-PR-Tracked-Commit-Id: 4b2c01ad902ec02fa962b233decd2f14be3714ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0ea81b4d37837409d0dfd2036098a7babb312ed
Message-Id: <20181229053507.9301.4772.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 16:34:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0ea81b4d37837409d0dfd2036098a7babb312ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
