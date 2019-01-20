Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E66C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FCA2084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548009621;
	bh=4m3F5PtGrFrH74hnTjVHG4TDLXsposI4RwHxKeNhCVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yEVbIgVrjW5MxX8QqtlM81pLJo/Q6eRO+GYgPf9xd4hQ/rPT8qWtTXdNslnGoBdsa
	 L6dCgFJ1Tw9YNQ2HEDNK49XocxInCCAYPAYYZ3UMw/6pXj+aqhE6CNvVNg2omVCP88
	 2I9lISORHEddfFA+8JF+rOwUQp25duEFSGTEsWWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfATSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfATSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:40:03 -0500
Subject: Re: [GIT PULL] clang-format for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548009602;
        bh=4m3F5PtGrFrH74hnTjVHG4TDLXsposI4RwHxKeNhCVY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zyw0NT0ddWbMz6eg+Fu5SAx6BgglqB9B78VfkUKPv4+oFZ0S5WAZOg7ji0oZc6ba7
         Up+uF0L7YXczsj5Ba/Td4ZgHbyP6OggnLu+ck+LiRuTzWIzR9ntphuut1nfrVqkoD/
         5WjibQA3rwJdugsKmzYNAeJ/bY3zgRS8Nme/GLUw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190120155231.GA30754@gmail.com>
References: <20190120155231.GA30754@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120155231.GA30754@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.0-rc3
X-PR-Tracked-Commit-Id: 99e309b6ed75fab4a43afd9e523441ecc5a1f511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 315a6d850a8290919c499cfbed08737f6164c7bd
Message-Id: <154800960258.15983.11303481624790376426.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jan 2019 18:40:02 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 16:52:31 +0100:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/315a6d850a8290919c499cfbed08737f6164c7bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
