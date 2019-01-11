Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8472184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547238303;
	bh=puRXmLJwGLnAgxEfXk7RmjVqO5vjMYUSJNSyqswx/9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=g9IwRrVUmFXq1vzIxUJTVYGaGFzC1daEW0hLlxS2JSrbmmPq2B1ur7g7ZrOfWAcl8
	 wignJDT2sIkVV3nWBUoyNgZDICz701bTXr/RwCgrUEA7A+JzNVICUGpps4mBeh01uu
	 dTZ4P+QGkh3gku+qQFepASkTjnB1qtM9x6R8h7q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbfAKUZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389104AbfAKUZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:25:02 -0500
Subject: Re: [GIT PULL] Ceph updates for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547238301;
        bh=puRXmLJwGLnAgxEfXk7RmjVqO5vjMYUSJNSyqswx/9g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YHXGxolRWPIdcTgSgLL86gYyz3XuPjNlSyI5zOX4jEycBSvByzBw1FT8ffBemGrYs
         lhQ+P3R2UZpWbzV4Uwccc2S+YqYMN91m2ptzN1d9TJeXuqRsYy+TGlKYb8eA1CgukH
         phDSOz2rsfuDLI/izir8gasiKryHbqXfSyKY79lA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190111170226.19872-1-idryomov@gmail.com>
References: <20190111170226.19872-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190111170226.19872-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.0-rc2
X-PR-Tracked-Commit-Id: 85f5a4d666fd9be73856ed16bb36c5af5b406b29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f87092c4337fc064b52bfad1df499a5b82f6d088
Message-Id: <154723830150.26854.7747492024432343487.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 20:25:01 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jan 2019 18:02:26 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f87092c4337fc064b52bfad1df499a5b82f6d088

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
