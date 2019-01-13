Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDABC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AC62064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547402724;
	bh=d3US2RPAWjv+AlsjqYBRoqWBGWg+65fdz7dngHHV/Kw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ktlWJO8XcRZByKyQEFCXFyoUvrcCAqgAWp/2j9ayD9HAZLjpgreb7ABFNyuZuDmI+
	 ON4+hrPp8Ro9sBB166eaFWATDCrDBK8vgUzWsh504rd+Xrt7bcex1eaplz7j5UesJX
	 iCsYpW53PJienoiQqJvPRwV38mlr2G2SWxWq4xl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfAMSFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 13:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfAMSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 13:05:02 -0500
Subject: Re: [GIT PULL] Staging driver fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547402702;
        bh=d3US2RPAWjv+AlsjqYBRoqWBGWg+65fdz7dngHHV/Kw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XEKzjRF0uaY947gjvrkm79KcY70QElrLBKaEojuZbJxC1jglFvHoGmz31onhNuWF9
         u1BrQLty9cjv75snvzkz+fLSzNJCl3K5RMWk9ysvgCgcxDq7/0bTJOrJhSWF3+0EOR
         tWGgoU4txs3APsAw7ChBNfUWUlqkRXEnnToqzwwM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190113102342.GA27738@kroah.com>
References: <20190113102342.GA27738@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190113102342.GA27738@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.0-rc2
X-PR-Tracked-Commit-Id: 06382deac2b8a49bbc5aaa3c9118fed6da4a1ac1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7c1038bc7597af5d6809c5b3e0352627cef5c07
Message-Id: <154740270229.11831.16468768030363839416.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jan 2019 18:05:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Jan 2019 11:23:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7c1038bc7597af5d6809c5b3e0352627cef5c07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
