Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99EBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B1820675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550950505;
	bh=m7VGVngWijZ4MuL3ySsJrUUlRlzGcKPydH34DMPYXUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N19UrvHsU5yPpPNiEAUame8lzKN0qOgiW4FQcqHy4m0peqTPm4lKuAuxbVCUWznb7
	 n+dn2vFc2iMAy9S1SkMB8TmTs9e6zsbZ+ZKr6aMDoVaBzn2SN06qXg9ueIzEDNxKJ2
	 9f0UNirXepAN8U2N1DcnRp0j+RtLsdGNg3X69i9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfBWTfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 14:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727752AbfBWTfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 14:35:03 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550950503;
        bh=m7VGVngWijZ4MuL3ySsJrUUlRlzGcKPydH34DMPYXUk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J4IUDzgWA8WyvprnzMya+6j2/C6NEIYCBaZTVNFTiPsZZXEkPUc4hcvRUZ9W0+GqZ
         uMsH2bZSUis9h3jjf34p3tZywPpPLKncunwcGWY6zvUyk5kBAS+BBlO4Vt2HYO/vD3
         HibCu5A1qjeFZugnpL6CF115h9jW0FOViqpPzpJc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1550891280.3577.36.camel@HansenPartnership.com>
References: <1550891280.3577.36.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1550891280.3577.36.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 4a067cf823d9d8e50d41cfb618011c0d4a969c72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6089a91fc02e0a4f8962f0df1be236c44248d7ea
Message-Id: <155095050312.13236.6480512437158522820.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 19:35:03 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 19:08:00 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6089a91fc02e0a4f8962f0df1be236c44248d7ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
