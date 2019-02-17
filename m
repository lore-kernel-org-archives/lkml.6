Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04355C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C068021924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422208;
	bh=iQO4AsgDTkrqWn2YQ0hQm6i28/5sFMTibR8wLvKeoSk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=at2zWYT4S+8SOBPagJQ8ueiFdBXjyTRdllt+Mn84fPZfMHnFTFFk/PuQGFwXxj35a
	 TKv5vnBRBsTNzP0kY9l+ovnE5bmoHXJoXNNCyxD/Zc8JaTbCmjLbIp/gLvMcCSEXvB
	 BAMXsV0JSTQGNtqLGUt8+TqRiK7MZMeNSfYr3zpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfBQQuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfBQQuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:04 -0500
Subject: Re: [git pull] Input updates for v5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422203;
        bh=iQO4AsgDTkrqWn2YQ0hQm6i28/5sFMTibR8wLvKeoSk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wUxv+7afalN0r/drhJuJSFpRafJMa3267YSsg/d/zjec6+qLQKil2OUYgWY6F6dXX
         G7pkrPrIx0v1uAE/YwAmqHQkw+QefF568oJKcO8wL/dqZevMK4Q/h8Syy07buIissw
         lnthqx/6qAqhR58cjdq8p1DhQNKJVPLbmmD/TzBs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190217074123.GA248187@dtor-ws>
References: <20190217074123.GA248187@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190217074123.GA248187@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 7ad222b3aed350adfc27ee7eec4587ffe55dfdce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8c82b6a3a8bee7858df08d25f5ddcfbe6210a69
Message-Id: <155042220363.16506.18207378379322497691.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 16:50:03 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Feb 2019 23:41:23 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8c82b6a3a8bee7858df08d25f5ddcfbe6210a69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
