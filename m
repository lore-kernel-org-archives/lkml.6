Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9624421906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545420624;
	bh=/NPTmLiA8awCAkguRmnT0l14zjzzMvMD9kP9bShubAE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rjBF/w4jyrU/3inrNheA+DQng79kSnh3BeK8drSmQx+ZDoEuahiSVowGOESaPYj8J
	 kGXJvsRvW2ggKEs+1xkPCYP5UUMz926bnYPPG0AGUNJ1h6axDuGciPcQ5TmPTC7TlE
	 5VBJAeKGuZRq2TJZ9sb6ZCCY+2Kx4G3GHsfFP6HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404557AbeLUTaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404534AbeLUTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:30:03 -0500
Subject: Re: [git pull] Input updates for v4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545420603;
        bh=/NPTmLiA8awCAkguRmnT0l14zjzzMvMD9kP9bShubAE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mAAcxTRIEWKxu0YYNwIE5HroFpf2QJ2vTsX8M/DvzKL/96F0C/IRq6ViRT0DSc9Ic
         4PsKoOjgpEtcyJUH+dakfAjz85IPWQZ3UXyNcpdQN8PrNBDbntpNWHJaySXUWa9Ael
         nXS0Ln0ZQa0agFHVf3fs9J9KrQgO9Rl3szhc0fmU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221091258.GA63423@dtor-ws>
References: <20181221091258.GA63423@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221091258.GA63423@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 7a71712293ba303aad928f580b89addb0be2892e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b517333721c1b7a740e54b1cbe78a14884d51e7
Message-Id: <20181221193003.15695.29715.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 21 Dec 2018 19:30:03 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 01:12:58 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b517333721c1b7a740e54b1cbe78a14884d51e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
