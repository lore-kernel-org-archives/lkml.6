Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDABC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CE121872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546575604;
	bh=6xblsTIYoN8WnguHziEC/wymg4pJ5l2TfFfjOCn6IOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T/FOPBAkHPvf/T0Cnk0I8FAMDEiOwqWUuzEEd1mLIjYqpxs5LaXj7YZFLzcyCHtGh
	 nbmIndMMMFej8Z7I9VOGfhQe1DGsbLg8WDSzMq2ox5f1AsiF42yk6UXsZWhOV5RKr4
	 4pDTxCY4guafVKva6srocvYKOtko3ua/m41uyd1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfADEUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfADEUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:20:02 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546575602;
        bh=6xblsTIYoN8WnguHziEC/wymg4pJ5l2TfFfjOCn6IOc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zK7P/H4oTpRGlPGdjZtlRiixgNq/REnHphrTNh/anhNjI2xUHhF8bE56tlBqsh5V3
         HqD/igPb8UiqNXV6S3mBEiKpPSNX2Kvrxx1vBvd0jsBNj7TyB2MTdwxHZDSHPeCvvv
         sbQ1qhXqthMoymxALsrl0DOzMuzRBog0DfGOsn3Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190102.221213.1813991188278531637.davem@davemloft.net>
References: <20190102.221213.1813991188278531637.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190102.221213.1813991188278531637.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: c5ee066333ebc322a24a00a743ed941a0c68617e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43d86ee8c639df750529b4d8f062b328b61c423e
Message-Id: <20190104042002.16893.69357.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 04 Jan 2019 04:20:02 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 02 Jan 2019 22:12:13 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43d86ee8c639df750529b4d8f062b328b61c423e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
