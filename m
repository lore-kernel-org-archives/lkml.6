Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C27C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2105D2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549133107;
	bh=czMBSunXmX0o56KjWsXLChVB9GUwGkLtkUkVFOGLNFk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BNw9R1bT/TIoIaFrhWLOUyXKYe/NacRZ8e7xJuVOGoRpGQia1Ksi3SKpTbUVl1oI6
	 vKDPZ718YERsGoydlxYnXVITH4c/Ar8oHIlPe0wibolaXgh8ZDQ19WIYkPUqk7o5jD
	 atbwBB6+xuLhfG9aWuU382GWQi/DPtC5NcTotkzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfBBSpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 13:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfBBSpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 13:45:04 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549133103;
        bh=czMBSunXmX0o56KjWsXLChVB9GUwGkLtkUkVFOGLNFk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2nG/rKmp3l3Jr2SNIlkpLzJWDdReaTRr8pciKsGAAOI4ilyKXwvLzSGnXA6qOwt0c
         dy0PGS+fU9W07RKeAFfSriaHR6BWgAvnCggP9mO2z5n20wgzU3CZcYyDOLrKAR4FQt
         hybpcDA1uNiXYpZFgRpDNianc2zBIUBSgyMEhqnU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1549066005.2964.12.camel@HansenPartnership.com>
References: <1549066005.2964.12.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1549066005.2964.12.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 8437fcf14deed67e5ad90b5e8abf62fb20f30881
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cde55ee7921609331178c84cca485491c97df2a
Message-Id: <154913310366.3857.17186316293757104027.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Feb 2019 18:45:03 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 Feb 2019 16:06:45 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cde55ee7921609331178c84cca485491c97df2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
