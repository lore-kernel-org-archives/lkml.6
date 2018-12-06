Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98792C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565CD214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544058604;
	bh=BF+8MI51s76ZiLOzg1A3JgSDu3mjJ5lr+Q/VCLDz+oQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jsc2Cda/w9Nu27n8WgG6YJRUX8EksNUj1MJtSrfXS9gOSPNg1wwfAXFTIPwFxFMki
	 KgsflxqagNIJM2MFUHlDuvDVChHm72sBC18xe4hPevHyTWhAzQaVeYPe7QnmzQ8bg5
	 H5UGCTlOBVblGBxMSM9C8IihaAHlrlIIZFj8qIr0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565CD214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeLFBKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeLFBKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:10:02 -0500
Subject: Re: [GIT PULL] SCSI fixes for 4.20-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544058602;
        bh=BF+8MI51s76ZiLOzg1A3JgSDu3mjJ5lr+Q/VCLDz+oQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GeKGB5JBrajdF5o2RgJ3aFioytfyhTK0XDxgZQm+okkABR0Kp0HANT1x8FJCorMv5
         uAgnVILboQ/KRlO5rBqEsYH85ZLRXHDQqLZTmFpPXG/BffE/vGsLDVJstAax2l5Lx/
         TrGLLrIAIKRTDITAvrFtggwipn/0r0KVfODEFce0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1544056700.3414.6.camel@HansenPartnership.com>
References: <1544056700.3414.6.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1544056700.3414.6.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: c967590457cae5ba4f018704c341641bdcecfdcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf76c364a1e1e5224af80edf70a1e3023e1fcf8c
Message-Id: <20181206011002.3849.4627.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 06 Dec 2018 01:10:02 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Dec 2018 09:38:20 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf76c364a1e1e5224af80edf70a1e3023e1fcf8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
