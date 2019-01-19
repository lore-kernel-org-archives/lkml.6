Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC51820883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547937309;
	bh=9PxH6ahYUyXJ9m5v4M3PfSKb6ibV+miuNwdFEzAgx6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CHbfSi+9S63hp836qWBDhPx6d39UV30Fe0OmRDPgzybbgIrrUn6d1L0AbIFjt9+FL
	 2uKCvScXmYKQfScW/a9791fB6bC+uV9cAuGoX17RpfZ/x4+zmiSUoHuaYoeH4Pzugo
	 QMWV3s1aAnc1+T+3mfo5eRcYtslYRWLbGFcvjSoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfASWfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbfASWfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:35:02 -0500
Subject: Re: [GIT PULL REQUEST] watchdog - v5.0-rc Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547937301;
        bh=9PxH6ahYUyXJ9m5v4M3PfSKb6ibV+miuNwdFEzAgx6o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s8TJueyzQlI/Gp9KpRWM9dpNLlm9oyY25I5RxjW8LA448oiKvdRTs4YPT/istwMs1
         75oD0tSTwls13o51LnTtnJP6MD/LtvQTOd7vRAkrVBGsTBWtjSPubZVB20uKA80jtP
         NLGyuXnh3DcQWC7GrL4Nb6DbUQlBD6yYe0d63xuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190119114007.GA22111@www.linux-watchdog.org>
References: <20190119114007.GA22111@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190119114007.GA22111@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-5.0-rc-fixes
X-PR-Tracked-Commit-Id: 4a22fc534f2f55808c41197cf17d829099032acb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f403d718ebde2059de848ae7548392dfb25a13ae
Message-Id: <154793730170.16838.17686429447862894559.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jan 2019 22:35:01 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        NeilBrown <neil@brown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Jan 2019 12:40:07 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.0-rc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f403d718ebde2059de848ae7548392dfb25a13ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
