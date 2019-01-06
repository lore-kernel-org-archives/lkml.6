Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9802BC43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B8A2146F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546806014;
	bh=Gb5IhbBjv4I6Zn6lWD0P5t2F7KWM6U366CcM7014wHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WzPqJ/gXE9AQNr6WlSt/bI9IPbp0Zk9PZ/1HIzD1H4EJwPczlrl8VqIZJWGlVA/TM
	 Fi4AGs/7OStZLYITU0Pp5UGDZHJczsUJuUZI+VjmK5QcrYiNRaEqLLZjFyV4r3Jt6h
	 JG5wyYUGMR4+R1bwkZ5FANyxS6NLlVsMsuogVq+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfAFUUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 15:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFUUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 15:20:13 -0500
Subject: Re: [GIT PULL] chrome-platform updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546806008;
        bh=Gb5IhbBjv4I6Zn6lWD0P5t2F7KWM6U366CcM7014wHk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ur/J2E6PzZ9FBHcIkcl1XF82MvK3QUYYnde848b7ftVoFMwyHexgs8bv2TERiMG9k
         hUnJ4ucKC5/zzB7ZX0NrLhsLJWvlbRbtyg5qCJCTS7MJjPamtscoC0eN8ryvPceOLL
         xi9f+URQUHHMfVGoLWmL55tOJuui7Pg5ApJPpkfk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104145310.GA83219@google.com>
References: <20190104145310.GA83219@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104145310.GA83219@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 tags/tag-chrome-platform-for-v4.21
X-PR-Tracked-Commit-Id: cdd6a4a0e2ec590c30ad0e965fa08bf37461cadb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12133258d7fe309b42a35677549c606b15a0822d
Message-Id: <20190106202002.19789.86388.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 20:20:02 +0000
To:     Benson Leung <bleung@google.com>
Cc:     bleung@chromium.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@google.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 06:53:10 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git tags/tag-chrome-platform-for-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12133258d7fe309b42a35677549c606b15a0822d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
