Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B6C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE03321855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548349813;
	bh=TBk1ZdkFcISBNx0bhmmUA/XlLNxchardOdpI63erCAo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0ovnngLkQnk+H6iJB/oNBqCSgTus2Z7PGyYUvNWP6hj8eQ/AQIRxcK6tCVXQGWAD2
	 iQyGkazH8jPUDzl8Ep2qUxIuVGjBxWRG3bYgBUIhotTiiWeg1+OFlBOCtQY/wjQ8l3
	 zTYfFpXmgVVXeBw1yLbyoSln9iJyhs2HOnahZp/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfAXRKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbfAXRKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:10:05 -0500
Subject: Re: [GIT PULL] Ceph fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548349805;
        bh=TBk1ZdkFcISBNx0bhmmUA/XlLNxchardOdpI63erCAo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aUo+eq426Hw1AcM5WzVjJ8qMNMyFfDTm+fh6U6cr8SnW1djdnCkGDl7fvyb7Gsd5L
         PwSLVZ4RoJiyM6Hk4j1AfIWUSlZZ+WpISwpK3ssWFRcDF3KGf/aAmD+GTOdCYFZ8Yn
         o+7TyYmHI5Shaq3dF5nIFau4vKwl/XRxbmsx54q4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190124154958.8067-1-idryomov@gmail.com>
References: <20190124154958.8067-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190124154958.8067-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.0-rc4
X-PR-Tracked-Commit-Id: 74827ee29565f86e2a64495a5e3e58d3371d74ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22a89a6b88e6db7328292491f564b54b13cc15fb
Message-Id: <154834980520.21465.4439579297346781753.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jan 2019 17:10:05 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Jan 2019 16:49:58 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22a89a6b88e6db7328292491f564b54b13cc15fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
