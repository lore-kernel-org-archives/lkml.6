Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC58C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C7E21919
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948305;
	bh=35mmqvOD1SMkEe3JwEQuy+c7ovnqdT3SNdQIhb9mpIs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rERMZKYKC5MiNPtkNfLWlr9PQ0cxo4+S6J/0hV653r/OqkRoFd6DZU3lqh3EiumHH
	 seZ1GGeXcpzdDWYO/2DIZCyv8KudZRAAugdruS8MbxQkA8kIVLa5zUPveHblQE10oT
	 oxsz1SJIFs8jr7by9S4pxyXnp4iYdVMW3NhtRVgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeL0WFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731502AbeL0WFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:02 -0500
Subject: Re: [GIT PULL] pstore updates for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948302;
        bh=35mmqvOD1SMkEe3JwEQuy+c7ovnqdT3SNdQIhb9mpIs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e8MGPPHTcosIHlDk0S7Ama2ZKTAFnCeM1DNPBHiXhQQpUh+nHIxGpxzD4C++tOJ4j
         Fh7YcWb6B4KybqMF/uywucNIcIpYLDwPMycxlASYd8xw1gb2nNFC6XGwUt6f7XVggp
         IkFb3EZkBO3aabl3fVJomJecGf3CTf2jWJCN40f0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181217235040.GA18678@beast>
References: <20181217235040.GA18678@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181217235040.GA18678@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v4.21-rc1
X-PR-Tracked-Commit-Id: 8665569e97dd52920713b95675409648986b5b0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c06e9ef6918b1a6d183f1fef78ebc66f054a7b5a
Message-Id: <20181227220502.24636.29390.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:02 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peng Wang <wangpeng15@xiaomi.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Meyer <thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Dec 2018 15:50:40 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c06e9ef6918b1a6d183f1fef78ebc66f054a7b5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
