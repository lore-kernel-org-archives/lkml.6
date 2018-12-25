Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC11AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBCF218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780094;
	bh=4Bf0tFi+yqRTHPneajSSWAw5w6A5KqzTcOz0OHwKQWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zG4hs9rudtsPvyCYqG1BZTeUpaIROr+UEoDmaDUOgBxVNdYTOj9oCMqOB+twZyCQq
	 T4GXz4KkBLN2c7eE57nO45DfdV83waKoqdtnnXIpDCRRyrdzIrANu9R6P4wKDm+25G
	 DYdNo214zxulIC0IMGtTBGe96iT7ykT4GOE3A9QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLYXUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeLYXUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:03 -0500
Subject: Re: [GIT PULL] i3c: Initial pull request
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780003;
        bh=4Bf0tFi+yqRTHPneajSSWAw5w6A5KqzTcOz0OHwKQWU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GPz/6TqnlULhb6Nmw4zYtG6wmKXGWADD5KY+nMxM+cSBYhjvpF2h2bipjGThrd8YS
         +hx8Vzlld22/fZ3WsuB1TymooanCv5NjyZpFSt3eCHrBvROjqdkzXEtn/cJgTS2pj3
         P8agx07us3vlesZbFKS/nEHbSfFM2ebRHH+ZOykM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181219165447.2db6a689@bbrezillon>
References: <20181219165447.2db6a689@bbrezillon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181219165447.2db6a689@bbrezillon>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-4.21
X-PR-Tracked-Commit-Id: 25ac3da61ba144f8dbfe377eeec6b1da7ad0854a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3cc2bfe7244e848f5e8caa77bbdc72c04abd17c
Message-Id: <20181225232003.23808.40308.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:03 +0000
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Wolfram Sang <wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Dec 2018 16:54:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3cc2bfe7244e848f5e8caa77bbdc72c04abd17c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
