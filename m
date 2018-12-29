Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13B520869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047046;
	bh=9R3nlf67LxdJWbw31D1CRPsJaIk871lddAly1zuLQZ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QvKEzA7jGhDo+9Vl8qCbQ06/E6DxAs4wxpvsOFOb+QPEFITD3s9z4HgSThBEr1wBc
	 WILoCHdFW2z6g2wCDrlAjDqODmheTSHMwmU1fNcPjrQ2G3ppksUhY8DtbCycCn2VJf
	 J157Txpe/u2VZ6mTdojbmTbbNp3h96O84BwuymxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeL2Bap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbeL2BaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:03 -0500
Subject: Re: [GIT PULL] first round of SCSI updates for the 4.20+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047003;
        bh=9R3nlf67LxdJWbw31D1CRPsJaIk871lddAly1zuLQZ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zVMR/ADJuLyVuuYFPurWwkfKI61/47x265Z0nW4cT/S3EfFslkyFDHC5SxgdGawbn
         UWMwsYxsi9KQXC/HPqa+Z7P1dRO4PK5u3KaHU+TTKDi+WpSoAiqyI4KHrIcbCwY+xA
         g2r5EiSIuYMvr1X6O0Zbq7M0atIbNxfoAGyRrcFM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1545671993.2810.25.camel@HansenPartnership.com>
References: <1545671993.2810.25.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1545671993.2810.25.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: da7903092b880b25971ca9103cb0b934a44ace2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 938edb8a31b976c9a92eb0cd4ff481e93f76c1f1
Message-Id: <20181229013003.17208.15554.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:03 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 09:19:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/938edb8a31b976c9a92eb0cd4ff481e93f76c1f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
