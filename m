Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054DDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4A8206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546279516;
	bh=CPwgeh9by+9NlQ2bdqb8yZ9W1sc0TVlf/UTzabunRxc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VIf0gm9cNPiz4SyFhh4FzgjefH8Zl9py706mc+lNpzdosPQniiQJyZ4viVGeXh4Zn
	 NEako79hUksP8vK4ZmIMAPunG4rNUpvA/PLpnepqmJdId+qG6BYjuwzkGzquUbK1+/
	 GHAP83qSsR1239ZrqOujcyGcrXAoHtR5/nOK9A8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeLaSFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeLaSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:05:03 -0500
Subject: Re: [PULL] alpha.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546279502;
        bh=CPwgeh9by+9NlQ2bdqb8yZ9W1sc0TVlf/UTzabunRxc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rbs43b6XH2Nr2ConfvcfFc/9j2eIbgQ5u/7XiFyunr2qigjyPc5D9iXOkLFBpdoKH
         b/sQZCpbeYcsPxfG8+XzETpvMQYIuY20NzbT/z4/6dS0fNeX7U8GE/LQbrOnVGGdpC
         RvQx6yZTyPfGOb6tE8xS7Q561H3bUe7UMLd3QIQM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181230222519.GA4195@p50>
References: <20181230222519.GA4195@p50>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181230222519.GA4195@p50>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus
X-PR-Tracked-Commit-Id: 1c3243f61fa7daea78de9866af2625f559ebf456
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f12e840c819bab42621685558a01d3f46ab9a226
Message-Id: <20181231180502.27307.1063.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 31 Dec 2018 18:05:02 +0000
To:     Matt Turner <mattst88@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Dec 2018 17:25:19 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f12e840c819bab42621685558a01d3f46ab9a226

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
