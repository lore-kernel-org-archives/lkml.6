Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B81C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778A420844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458409;
	bh=op4mhf2e9Zkr1qOgRoovilB/bSQPRmCHj69o4/fZD9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jr4Vp83GD8IM96yZ0GH/q4VOOg+bza3BiNrJ+OQKbvpAo51NNJ5LITxi6AStYonCN
	 RDQBeQMMEHVDQM8aBRijjr+AZ1HilQrT6enc2GOdTx6pi/SzToCi8jomKZUwquE5qy
	 wSvGzQvFQowW6PXA0mTk/xu5/mlFZJk9XRMSNt6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfAYXUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbfAYXUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:20:04 -0500
Subject: Re: [GIT PULL] USB driver fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458404;
        bh=op4mhf2e9Zkr1qOgRoovilB/bSQPRmCHj69o4/fZD9o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MMvH62ywA31Eoa2RPyzj5vnQQ5nI2ZmbFEJp2bYl18wsysY1Rwq2+4zHe5MA6PPFK
         8/lcEiQ4Nq3zXQRwqjN13yuLsKctmGLphK88lILecbgiWZSbQxcZRtLcMaIiZZjcvp
         MHHjQRvK0YEEQkFoP4V7XLjxh0U0PpcVc5PNbYME=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125122221.GA7517@kroah.com>
References: <20190125122221.GA7517@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125122221.GA7517@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc4
X-PR-Tracked-Commit-Id: 4f9b838927812b5949a9899f14e0c9ef7f02b0c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b48cef32b6a5103dddf52aadbeda90ab0f7ef673
Message-Id: <154845840423.30665.8439735706920707614.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jan 2019 23:20:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 13:22:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b48cef32b6a5103dddf52aadbeda90ab0f7ef673

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
