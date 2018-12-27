Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF3C218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878741;
	bh=RdxXn1tsFtWfTjrrBPnGy+e1tifpjiyvBT07hweu2QY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qjc3jrD/jBiFLmOZSZJeH7+wrPlafl7+urInbAPYMBTes7rkB6TdnCC1fORlYp1/k
	 5j5MRrGpXwt1MQWfcIdPOW9M8xhIf10GS7+RTmk5yOpg9b20dDZAJAF9wu9Ty3PzAK
	 lQlJMsW6e44GNFiNWscMuoRndCXSQOXFqiFQggKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeL0Cpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbeL0CpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:03 -0500
Subject: Re: [GIT PULL] x86/amd-nb changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878702;
        bh=RdxXn1tsFtWfTjrrBPnGy+e1tifpjiyvBT07hweu2QY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ObB61d+xAirNFBngzPZ3zwDjvUhKPvseKS4jiaxqeONEpAGg+qPECNwbcB4+8gzIF
         +yIKTZxh8t0Q4NhQD17/yO1DwT/sSrxGvZhKhfjdcL8MLI0zQk6qRbsVnD1UvSXnsq
         x9smh+aIXlDwcM770ble9cNHiBFMXHqoLMGtYNqo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224225004.GA96500@gmail.com>
References: <20181224225004.GA96500@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224225004.GA96500@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-amd-nb-for-linus
X-PR-Tracked-Commit-Id: 210ba1201ff950b3d05bfd8fa5d47540cea393c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8465625ab4700e3e1db506ed8a541f7796356d63
Message-Id: <20181227024502.3706.23670.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 23:50:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-amd-nb-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8465625ab4700e3e1db506ed8a541f7796356d63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
