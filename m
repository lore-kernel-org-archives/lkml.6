Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4719AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C23206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545520211;
	bh=bKGg8S8gj5Hc+++3j3E/5NjFC9/MNxwxM8w82xtqOXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oxsFg0LTy2z99fJjhRttJcVSjtmAuos9e3/F/CC1/YGA0UvU7qZpdqFTTJxTxfQKR
	 Yjfrimm70CWuhRxAUHaHWyRso7SOlLcXoF/APJadU8bvfcjXQHDhQWpbpZDYnj9KIO
	 XT2f82u/Lj47SmautcBA6Dvdtw53TLOG93gcwtAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405096AbeLVXKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405059AbeLVXKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:10:03 -0500
Subject: Re: [GIT PULL] SCSI fixes for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545520202;
        bh=bKGg8S8gj5Hc+++3j3E/5NjFC9/MNxwxM8w82xtqOXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ysntf5xm4KuQsi9t99/kbngoPGr8Htzf45uNmkUP491QBG4UK5tN+PByjTJ9Cmwlc
         2vkUOabn996eKKdcS94QMxbZEwH9DLMtOsAPiFOj73LQGcmQciRLXwURoq7D/rOpYb
         YWxU6mJ1WJsxuXmCzjasOIXTX6cyQ/wGceATx6Ec=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1545447056.2776.11.camel@HansenPartnership.com>
References: <1545447056.2776.11.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1545447056.2776.11.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 61cce6f6eeced5ddd9cac55e807fe28b4f18c1ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9105b8aa50c182371533fc97db64fc8f26f051b3
Message-Id: <20181222231002.28463.71855.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 22 Dec 2018 23:10:02 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 18:50:56 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9105b8aa50c182371533fc97db64fc8f26f051b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
