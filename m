Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE204C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992392084C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548609917;
	bh=biy834JjEBi1CPBDQNfabToedyaxYyTtw82ktRIVNFo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cpVrJEF2VitKSGGeSpvNgqynpJSmGMa66gRan4y3UcEwg+ZADbW46P1T0nu1FWal5
	 j7/61jG5oF7I8WkGNhZfccvon9vOGTRfXQrxsSpw9g2xNQSNyDq7GoQWHr+IW1CZPl
	 XzUzn4FUoCkBCOZg+YeNdNTGDXoQC9HNlizxda34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfA0RZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfA0RZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:25:05 -0500
Subject: Re: [GIT PULL] dma-mapping fix for 5.0-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548609905;
        bh=biy834JjEBi1CPBDQNfabToedyaxYyTtw82ktRIVNFo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wPzob/w24Uv5jLka/GHgWLVnkt4oOx+gOndYLLBD2eNSykik5Cn5Z6P2wlqLPftTw
         rLWqypS1dmFT+fCG2SBaYLUjzmWWH2+qBbnJ9/Skyl1tHxItz+ErRpA1FpNGfvNwkA
         pAj+rAl8d3zFW71J22BbuvRoDiwWgC/b5zIFo+BE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190127092721.GA22044@infradead.org>
References: <20190127092721.GA22044@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190127092721.GA22044@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.0-2
X-PR-Tracked-Commit-Id: 60d8cd572f655aac6107a2330dced004ad1fe3d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c180f1b04be01d025aa1e6e53e1a8b6626bd90c4
Message-Id: <154860990527.19009.3637678196596036300.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 17:25:05 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Grall <julien.grall@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 10:27:21 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c180f1b04be01d025aa1e6e53e1a8b6626bd90c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
