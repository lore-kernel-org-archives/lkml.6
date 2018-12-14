Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A43C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0B82070D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809504;
	bh=DhHXOs5LCT+t+2ZEpE4EnJzw25m8uaaObTAwGCRSlck=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0zBuHB3fggznHiAMse8qJMOB3I12+60UnG3yZMwsB0XoojTG7hyOLSLSAq5OF9YTS
	 B0U8Jj7fTEPXsf5NXYpBh0xIefolFBOm2B2MUhfaJmNpeg7i27F19yCw+JzUfnJybK
	 fEi10TVsn7MLLmZ2L+IB4s/0RUoFRhp8lj79/ug0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeLNRpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeLNRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:45:01 -0500
Subject: Re: [GIT PULL] XArray for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809501;
        bh=DhHXOs5LCT+t+2ZEpE4EnJzw25m8uaaObTAwGCRSlck=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZRIKCUoQwp4i9uAD2r1Y4zl2+JlfisHO3oTNBY2lFQWuAW6ERFH1qNFdj+ye3++R7
         hL8vXGCIvmYNblBZutID+Q1i6z56KHLTXl+3Bqog/vMA0FOX9cpJ6G0KP4MbV3nSjL
         ICaquPYAT0Rz/NJR7b/m9FATzzpE9O5uwqPr4OT4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181214000447.GT6830@bombadil.infradead.org>
References: <20181214000447.GT6830@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181214000447.GT6830@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git
 tags/xarray-4.20-rc7
X-PR-Tracked-Commit-Id: 48483614de97c4f5219abeda630e62b2bebdce62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 880b9df1bf157dc28a2e65beea6183d095e0ccb0
Message-Id: <20181214174501.32554.41117.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 17:45:01 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Dec 2018 16:04:47 -0800:

> git://git.infradead.org/users/willy/linux-dax.git tags/xarray-4.20-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/880b9df1bf157dc28a2e65beea6183d095e0ccb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
