Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C1A206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322225;
	bh=6Dk2jjjyYQP0cdFgMG+yd+ml9zMAGcP4aKzDShIk3wc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0iojSGBCyYJz9P24MiqyGDD5ik36G6jgqluYZPuzMKIi24jDBFnNZZXkUP0ow/9W4
	 jZ0loRwxoNHYTsWdeCVfvU8N0hWYu18iDYukN1eRYNgKhqm3Xyp97xzDEJvdsyrmFM
	 u+2gXNsa8vsvdjnP73LAKFjblv/AuUJjtWrP6I9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeLTQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbeLTQKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:03 -0500
Subject: Re: [GIT PULL] Kbuild fixes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545322202;
        bh=6Dk2jjjyYQP0cdFgMG+yd+ml9zMAGcP4aKzDShIk3wc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xJ1pz/+eRKpgmWR+gtQZFeqdjUQTKgFHDFR6aCwvflOWn5fyOg0EWEhw0+EP7FSyH
         TOqbpedQO94uKTWDiOoqK4y3h/JKhcDJ9U4u93mt5baCTp1b0xmk3J4YUuGO0VaS7A
         K0Lb2Ikg91xvOemhe0hxrNOisiWbsOBS4VVgYN88=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQHKJzY9giP-A5Q5+tp_JuH_bnDTzgbGnBCiAMbCVVevw@mail.gmail.com>
References: <CAK7LNAQHKJzY9giP-A5Q5+tp_JuH_bnDTzgbGnBCiAMbCVVevw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQHKJzY9giP-A5Q5+tp_JuH_bnDTzgbGnBCiAMbCVVevw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v4.20-2
X-PR-Tracked-Commit-Id: ef7cfd00b2caf6edeb7f169682b64be2d0a798cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0f3ece4657fe2205c1e59c5c27547d6e8cba34a
Message-Id: <20181220161002.12746.58201.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 16:10:02 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 22:12:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v4.20-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0f3ece4657fe2205c1e59c5c27547d6e8cba34a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
