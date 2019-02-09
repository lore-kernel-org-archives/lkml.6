Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F34C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D6920844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672814;
	bh=xsF8nzW7KA4G0+LaoHiOvQsKTUG0QQTEtzvv0kikEgY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Zd8L1ecRkPKtbI5n/DRgxy7+bhCtXd6c0DDbftX80Tt22dukEyEO4yh8z6iRdv+mf
	 Bcv07SvpC8sLCsXOCBrAU/KLkfLPPVPUeuQCkq4m8vYa0+lg1UAZ3q3eL/jN+D0cx7
	 maCtg2ORE3utIFWhqGxpzzP2lKxKBPJg/P/4/zcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfBIAkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfBIAkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:07 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes for linux-5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672806;
        bh=xsF8nzW7KA4G0+LaoHiOvQsKTUG0QQTEtzvv0kikEgY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C+UsFwmreU+dRTi6lklqabECI6oAMWYzDwyZbD3idLDKUYfsJYmUciAWbDqwwngAz
         QtS4Rc1/annaPNqF4GorAIkFs0BQppeqA8bSr/jrr24VNthRxljvAy35qyzMMhgNn0
         rCahW/X66hkiS1jaMnk7aQlcf1vrP3oXh7xNCypU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1riu3bpUf492t1zmw-jA5AcP2CQOaKYM_BgfPpdaBJ=g@mail.gmail.com>
References: <CAK8P3a1riu3bpUf492t1zmw-jA5AcP2CQOaKYM_BgfPpdaBJ=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1riu3bpUf492t1zmw-jA5AcP2CQOaKYM_BgfPpdaBJ=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git armsoc-fixes-5.0
X-PR-Tracked-Commit-Id: d0f9f16788e15d9eb40f68b047732d49658c5a3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46c291e277f93737877305f5626a2c5c35522cb1
Message-Id: <154967280661.26526.2498192879181673865.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:06 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Feb 2019 00:27:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git armsoc-fixes-5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46c291e277f93737877305f5626a2c5c35522cb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
