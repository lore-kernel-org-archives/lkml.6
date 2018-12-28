Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4220879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545961547;
	bh=GccIjQUwR3GkdVD7CMbViMiLCMqfXzRlMOs+4KJX7aU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZzKnRwDwoOyJfUPS8cLO5ZZmdCNxv2VQLI5FBS0koCfp8nM+heCkN7gRfP08uve0h
	 wt+CnkHwoGXKQP/FNBYpkxxeFtnACZYYOiRA/Af874MYZqB65RyAdOo2MjXI+h2pbR
	 OEhY5XhPLCTs8f5STsH7vu6xNWV/QANgNjEs/1lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbeL1Bpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbeL1BpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:45:03 -0500
Subject: Re: [GIT PULL] xfs: updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545961502;
        bh=GccIjQUwR3GkdVD7CMbViMiLCMqfXzRlMOs+4KJX7aU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v9ld047w9znjvey4+zPwxvPegOvWoLOwwu3gmLHTep8t8AXlypWZ8gedcMlUKiGVu
         lVJwPY3fSRxV+8KB6SbrWfhqmNICgvpQ0Ua2EoJhRz3zDOEW9EZ2/VFvNL5Z8hN8F/
         9UZDupXwLOOOIczdh/iSPif+fVuVKyPfXUj8OEcw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224002649.GJ27208@magnolia>
References: <20181224002649.GJ27208@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224002649.GJ27208@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-4.21-merge-2
X-PR-Tracked-Commit-Id: 65eed012d1f2d0f0bf0ffc036826d58147de77b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47a43f2f0ce24bb75e3e4500118000585a3b496a
Message-Id: <20181228014502.3597.26567.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 28 Dec 2018 01:45:02 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 16:26:49 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.21-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47a43f2f0ce24bb75e3e4500118000585a3b496a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
