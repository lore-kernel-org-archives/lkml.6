Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE809C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADBE222E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550368220;
	bh=ibMEoFDPTKWmqS1VaU3P+5VKNrOFsJ1QLpwGguQwHRw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l6W6o+v94znSuP14cImLg6Pmgk7WCWJmSzYQaWaG3YZLCC0xwP3zhSLgtgnId+QAq
	 XdgeNm0ynlJ3r3jIcEM0DoSP6kd/U51q84hN0ZonWsP6yfEDKqu06xrezoYCht4xks
	 5bqD2K/MmrWtn4GS3kxOZmcafCoTylWoGc2HzBfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbfBQBuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 20:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731196AbfBQBuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 20:50:04 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550368204;
        bh=ibMEoFDPTKWmqS1VaU3P+5VKNrOFsJ1QLpwGguQwHRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Afl2avWfs6mcnDjGTe7ifxXBaRHr1JCL4n35Okr/pwtPUNMg/2DlK/l6SfjcXq/4u
         Wn2NIJAQGe9Kkp+KAXSGkDpp9cFQGxiu7G/sc/haoKPzROP0POvin5gInEYWuuOXSS
         SXkDogqvrdr6QSLu5f8ljxUamhw6eAkPh6Gf6wso=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
References: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 410d7360541c0e21b58e56b64e5bcdbec9c1d285
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64c0133eb88a3b0c11c42580a520fe78b71b3932
Message-Id: <155036820398.25738.788305032317721076.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 01:50:03 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Feb 2019 21:20:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64c0133eb88a3b0c11c42580a520fe78b71b3932

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
