Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4952146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546113304;
	bh=fAckpoXzcDEyrLwdCkszuO+Ci79jJR1kINX5TvSRz0g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YveRetXZrRfM7Wb84fUVAWGlqzTZQQlSqimTG5G9QpCZQGSLg5Jig2IXkeDLqzGw/
	 WqJWZhE6uJcb4W5aSYJZ/I4HmAV0lac6/3KtFGrq0GZYg/4CN3AWT4uATz1ra9rC5Z
	 AgzJPIwlgOSixVlNJHau/dFWoRIZV1VGC5tgiTtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeL2TzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeL2TzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 14:55:02 -0500
Subject: Re: [GIT PULL] cgroup changes for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546113302;
        bh=fAckpoXzcDEyrLwdCkszuO+Ci79jJR1kINX5TvSRz0g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ocF8Kfohznma36/pFHar0Ev6o/glEvrH3JS0AxOI4TcsQSxzzavde7c6TThbdxb5K
         p2157wq+oVECUZ21Tvkr4GKJQKqipDDP9f0ebFPZmiAwNm+XH09irZWjHoxo1eb/7k
         csgQDz0QFk6BBz+DmtVf2IzyaOwkaI2uJpOwEcCU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228021605.GI2509588@devbig004.ftw2.facebook.com>
References: <20181228021605.GI2509588@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228021605.GI2509588@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.21
X-PR-Tracked-Commit-Id: 4d71c6f8771a6bccb844244f09831fa4624b22c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e250d91d65750a0c0c62483ac4f9f357e7317617
Message-Id: <20181229195502.31407.28249.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 19:55:02 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Dec 2018 18:16:05 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e250d91d65750a0c0c62483ac4f9f357e7317617

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
