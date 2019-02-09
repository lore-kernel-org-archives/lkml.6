Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32985C4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0293920844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672818;
	bh=bQGtd1jdJn91SpRr2Lh2kIKXVESE6moSNQPwIXNfk10=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W2sDN1cK+TTKamfyNPJlcZg3ZaOOtOzyYX8Eo8lSE/sGYQ4MHzX0CUkkQzyQBaqVc
	 m00VFBsvZgjwNPt8i/Zkp+RoJ+aqyr7Mv8PvEaRwfRot7/kAdKPwoEQUeu//8ciehK
	 uLgpG7iIHsDDG0yxq1QFMQeZkPhok5sYZvwNSVDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfBIAkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfBIAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:06 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672806;
        bh=bQGtd1jdJn91SpRr2Lh2kIKXVESE6moSNQPwIXNfk10=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PE58bzgwslZfL64ZgrUN1k6WU7Jy4hs32DgvfXAkCSP7QE9NtHQlDL+o3Pvjbnihd
         EVJIKGQzE67/dQAgH9krhVU1d2YW19vHJqc7K/voMCS2F2Le5RW8jIGbGuu++0ZfnG
         FwWJdl7ovrxtdbQKbz+RG7v6tQezhv5Tbveht3gU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1549653479.3647.13.camel@HansenPartnership.com>
References: <1549653479.3647.13.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1549653479.3647.13.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: bb61b843ffd46978d7ca5095453e572714934eeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b6e8204a997510718949fd177f01da1860c738a
Message-Id: <154967280635.26526.15830031632230930777.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Feb 2019 14:17:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b6e8204a997510718949fd177f01da1860c738a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
