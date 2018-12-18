Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE265C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909C321873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545155704;
	bh=IoMiYz+gSBEtmjBCTyyXjEIwy5z1s+RId0CWejJZEDs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uaLX3Pcpa47IpDtRgdr1z+iMYLXVMgTAwzF+zbjCTndHdX7eowoLASucyl3sG50d1
	 E091mEBEXq5EWyWo76WHClRjlAR6ZtyZ04Go1+H2pmVPxmodlI+16y2qRPGTOJLNwz
	 E5kvcM/BVpkSW90Ha9s6EtbMOhLn3Aw7lTZRxlic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeLRRzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbeLRRzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:55:02 -0500
Subject: Re: [GIT PULL] SCSI fixes for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545155702;
        bh=IoMiYz+gSBEtmjBCTyyXjEIwy5z1s+RId0CWejJZEDs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aZlHRobC3riT9KI8yik7jVWGCuRprDDgYJ1sQw+hT4gWK1TE2rugD7ogl2OtPFvVq
         m6YAnaJTZSA2CgyTpt5I63yFxuFWOlt8InWE0fMUZOJlTGNA+B2Ox6GX7Of0263p55
         L56AZRRr7VCcpfa3usehURJMBuO7yI05zUYm9mFY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1545148634.2837.6.camel@HansenPartnership.com>
References: <1545148634.2837.6.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1545148634.2837.6.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 60a89a3ce0cce515dc663bc1b45ac89202ad6c79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddfbab46539f2d37a9e9d357b054486b51f7dc27
Message-Id: <20181218175502.21421.6167.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 18 Dec 2018 17:55:02 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Dec 2018 07:57:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddfbab46539f2d37a9e9d357b054486b51f7dc27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
