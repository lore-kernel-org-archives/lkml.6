Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572BC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91011222AA
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742425;
	bh=XhYQSByy/hMN932Vion0YNCn7NrIkTtBPceV/1S72F0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qtjpzZQ0gW46tOrKdMSUvQ/FfeoWg3vVGPqtY5en2POowIJAEoqVcBHnIYqF8wjIH
	 MgyPTWAhVdfPQ4DAKAlpRixVBbhZ5cr3iCvqCEYO9gnZs7wr9XNlDh1vOztXJcNn69
	 eK1qUlsxUvKVN9+KGt98Lmzl9tsQTg8P75Ft2g08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfAFCkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfAFCkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:06 -0500
Subject: Re: [PULL REQUEST] i2c for 5.0 (or how it will be called)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742405;
        bh=XhYQSByy/hMN932Vion0YNCn7NrIkTtBPceV/1S72F0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w2K2/zXEtYYESxOrfFs8MheAOfKwAHTB2A7ldH6H5FL+SAH7mMXVEeyNsChDPn6li
         zLvYSOMZ0BFlzuoAo9dui/DFqbbq37zpvi8tmETOlNqlDy95fN4d3kHdHAf35XmB2V
         aHkmizO4LwThn8NKje5XQ0c85flnwsMd67S9DqWg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104110641.bf7k42aprdikplx6@ninjato>
References: <20190104110641.bf7k42aprdikplx6@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104110641.bf7k42aprdikplx6@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.0
X-PR-Tracked-Commit-Id: 81482d13f37b1c9354d9bf5491699d993b193246
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7671c14e6aca7a816a29a85eba47d9bccb7d23ae
Message-Id: <20190106024005.13237.57002.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:05 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 12:06:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7671c14e6aca7a816a29a85eba47d9bccb7d23ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
