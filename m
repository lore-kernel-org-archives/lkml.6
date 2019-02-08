Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE5C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AB6207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655146;
	bh=w9UfRp5yQBxVjaPXXHC7yPfdl6PmtXOyKIej0ZJcTok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JQrjI5uLrxXSIzKa56FK2hcPhVvikgk2unh3btfslXeskYnPah5Tp6Z69AJsJvePB
	 ACBHlVyriR/YR2S87hmiEe1l2W2aea04miGtdxE+M5ipUHRzeqtesxFnRX0QIIbhtb
	 7KCIuHSjKV2+fQJMqXZWUovQ/Qmh0cmzEe0f3fr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfBHTpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfBHTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:05 -0500
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655104;
        bh=w9UfRp5yQBxVjaPXXHC7yPfdl6PmtXOyKIej0ZJcTok=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oKNNMumpyjUB7Z0TelcRZWQx6ZdKT5XJvcQEg9BdiZlYVfBFi/ft1LE3uNwrsZFLq
         O967sd7ILDdtpg2Mot4WfrxR0G5DPHJgDUFeHmg6px+n4XYzPCizA6nTvmi+eSX2nf
         WtFiDfJofmjuMWYj4OOwmqcNdl/Gssa2UKgQnqEY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208083835.GA26921@kroah.com>
References: <20190208083835.GA26921@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208083835.GA26921@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.0-rc6
X-PR-Tracked-Commit-Id: 6d923f8fe821c0c6b5378635cbcc9da5f5ec520a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e464f50c057a1fbefae6c6078f9bd5511f84f199
Message-Id: <154965510494.5511.1846674112000426360.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 09:38:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e464f50c057a1fbefae6c6078f9bd5511f84f199

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
