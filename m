Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247852087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546113310;
	bh=2ZqHaJQnCTq5FGj49INdYKc6wJA1mUeTI4PEzUD6Q/g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iv/32bQSY5gZhNtXhWxIZIxxeS0BACvSEh7bO+WT2lAvPLpXG72fNrqccwLe7//8r
	 gpgWxRRDvwNQf4PQshTNd9ltw0/HhNWWaADWSgTbKt9G+BZfRAAMb2HcHYb8EdnYEm
	 veGFCDux7UrC24gOqo08oEOtl7q8uOcw5x+7q+js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeL2TzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbeL2TzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 14:55:03 -0500
Subject: Re: [GIT UPDATED PULL] cgroup changes for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546113303;
        bh=2ZqHaJQnCTq5FGj49INdYKc6wJA1mUeTI4PEzUD6Q/g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DuHqdGaj6iHmll5PcoFcdQ5GCVTtoAlNwytN0mWYxYV+DScfN9f1eh5MHmqX/yVCa
         GedOCGwlPY4CWKUCcLttwQ19vaG0CMd2caCbY5lVHpO0rxuRCdNgSyi1cgGpAQCdYz
         vHX4KWWs7OkXRXDxE2Tou7Q2c9fBaUUnafVuxl+c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228184117.GN2509588@devbig004.ftw2.facebook.com>
References: <20181228021605.GI2509588@devbig004.ftw2.facebook.com>
 <20181228184117.GN2509588@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228184117.GN2509588@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.21
X-PR-Tracked-Commit-Id: 3fc9c12d27b4ded4f1f761a800558dab2e6bbac5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f9d71c9c759b1e7d31189a4de228983192c7dc7
Message-Id: <20181229195503.31407.2100.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 19:55:03 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 10:41:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f9d71c9c759b1e7d31189a4de228983192c7dc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
