Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B428C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427FD20866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546121114;
	bh=lKbrUJ+intDR9shLQAix1Qf0holwIsSLkAgctOKVjfg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IUbmbkMZSPP7G7XIqeGiSpEcZzz7KelnM6QoFfHURwwkJb3vdlHHS9Rx7wbNHRfsx
	 Ew8KUIYeXKv+gcusEV7MZLYQkA2JXkARlSzhJhj80swOIUxaVv2IIo7ok9funAXyqt
	 MwfqMG1e3jl4+gAody/P+R6MlS2f50gmdH9NwkRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeL2WFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbeL2WFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:05:03 -0500
Subject: Re: [GIT PULL 4/4] Kconfig file consolidation for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546121102;
        bh=lKbrUJ+intDR9shLQAix1Qf0holwIsSLkAgctOKVjfg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tEDKwEwJ49rwcysgyB/ZbzsRTrLcFamYmOQ7/u131eaFVk7NZzfeMqLtuWwTy3fw4
         qI1VcYCmAMDmeNFkuajLt1LUq1OgKwmjhaNvFRkvcQqjnqwD4BESQVFA78+OlC0b44
         PYuazYn1tZmY01w7Wpqb+7819DXE6H0FlTZXDjcE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARm4c95_f+Z__ygHS1Npf_asse32CNYqUy-CLxHcATezw@mail.gmail.com>
References: <CAK7LNARm4c95_f+Z__ygHS1Npf_asse32CNYqUy-CLxHcATezw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARm4c95_f+Z__ygHS1Npf_asse32CNYqUy-CLxHcATezw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kconfig-v4.21-2
X-PR-Tracked-Commit-Id: 5cfc879caee810828d90aec808d85560f34f02af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 195303136f192d37b89e20a8d1d2670d0d825266
Message-Id: <20181229220502.27755.19417.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 22:05:02 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Dec 2018 01:06:52 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kconfig-v4.21-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/195303136f192d37b89e20a8d1d2670d0d825266

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
