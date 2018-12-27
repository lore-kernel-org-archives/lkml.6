Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1769C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF0C21925
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948307;
	bh=/AS6EVocoGOwyO04QnN9tI9/CtlXIni1s+vulooz4Ss=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EnqZik6Y4zDvabF4LQCohzyxYvEZIkzHIxhQmCyN1QHDenI+7FGn6B3zWemahrLY6
	 S/KLnhyRBq8UAl05GRSjevtEVuvkDYuAFzTc8c8rceDlrp61WkUzcgEBbU+lqwNm+U
	 MQ4i92vfL08+jcY7bZ35oY63dcsqKjDiNRm3aq9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeL0WFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731520AbeL0WFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:04 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948303;
        bh=/AS6EVocoGOwyO04QnN9tI9/CtlXIni1s+vulooz4Ss=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KJpuvkQhNBCyobT+LPyOOLomYItR0t76tvo+yB1P/k8ZvAgAem0k0ofhKnAgC+g8R
         6Ouv7nY+I1i3zr2BEOyEYd1GnxG7MBWE3rY4TJ3lXOY9aQkxjuw5cEfckX8FvQe62m
         8xyyrksed9IPE7Kp1eWe3geT/ckPQtWFWBO5CWVs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221.162028.514870100232685504.davem@davemloft.net>
References: <20181221.162028.514870100232685504.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221.162028.514870100232685504.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
X-PR-Tracked-Commit-Id: ce28bb4453880759c5bdc2751629f1a865ea4a6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8762cdcd1d5055017770a54e2755bed30dd4f8b6
Message-Id: <20181227220503.24636.35249.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 16:20:28 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8762cdcd1d5055017770a54e2755bed30dd4f8b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
