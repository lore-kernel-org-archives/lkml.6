Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DD7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F36B218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546460104;
	bh=tBYhQMvdX304h8ioy4UWg0VhXiHSvrrl/LKdD3TUaRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HI4qaFREBNAjgbJZS0/BRctgxYHNxJ3xClQRflI+eXvU4fjc8co35TKNxDwQcVMDi
	 XA2+xvkfUGbDiVyYP36oA/QNv6C13NdjpUGq1+e6g8E3IjkX2FDz+8ndOXIOp3YgDi
	 budPx3f5TJp3KkyAA9rREr2jZKMZfB+Xf81E0kT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfABUPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfABUPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:15:02 -0500
Subject: Re: [GIT PULL] 9p updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546460102;
        bh=tBYhQMvdX304h8ioy4UWg0VhXiHSvrrl/LKdD3TUaRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dr8XwqaEwzh9wIpDeBYkCiJmLBaNChP5uaZwqoiSd5ukuQ3I5gRGN9S3/smxSR/9W
         vLCqxezE9lGdppG2tBUjqa7TArH4gsqKBD+XQELLjbw8DTNp1lYJzqWCOGT20Gmkge
         QUfRWPStw33W3gsqQ45k4Gs74msrfE7tenTp5vOI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190102035439.GA30733@nautica>
References: <20190102035439.GA30733@nautica>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190102035439.GA30733@nautica>
X-PR-Tracked-Remote: git://github.com/martinetd/linux tags/9p-for-4.21
X-PR-Tracked-Commit-Id: 574d356b7a02c7e1b01a1d9cba8a26b3c2888f45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85f78456f286da46fb054c7d45e4193cb757ac83
Message-Id: <20190102201502.17274.30270.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 20:15:02 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 04:54:39 +0100:

> git://github.com/martinetd/linux tags/9p-for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85f78456f286da46fb054c7d45e4193cb757ac83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
