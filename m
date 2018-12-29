Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36094C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CCF218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047037;
	bh=yIirrzVaMY48uyjen74pGhFVAXP77CIY/osIDVunH8A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p6PF0adQLD86udSfe4N5pAdMgGSJyApE51ECYwfCfmngawTQrcrNPiQrZ01E3LbaQ
	 C2hOVlfgRiRqInHlvtVE9SZMN3gNHI2oWTLgB9MBBgDcIyfhdz34x+uCH6r30X07m7
	 tjyhAcZLQ/gqbmQJzVhOsFA/cFKbfycMMwME6Us4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeL2BaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbeL2BaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:02 -0500
Subject: Re: [GIT PULL] dma-mapping updates for Linux 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047002;
        bh=yIirrzVaMY48uyjen74pGhFVAXP77CIY/osIDVunH8A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wfaa0XpICEv0g8H7Cl0pOfwa22mute22cz96QEHIil368yX55qvyT/ynP3nRS+iUB
         oQHD3hpd0NXNmPq7wgormbiKUHqBrIauHW17qYi6FJn1gYfI4bh5gNiCxT4ND95i1J
         QCVu2NJonIFqeUheWwL2o7c9ZSl8Wqq4v3FdwUfM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221094549.GA14522@infradead.org>
References: <20181221094549.GA14522@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221094549.GA14522@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-4.21
X-PR-Tracked-Commit-Id: 8b1cce9f5832a8eda17d37a3c49fb7dd2d650f46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af7ddd8a627c62a835524b3f5b471edbbbcce025
Message-Id: <20181229013002.17208.10420.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:02 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 10:45:49 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af7ddd8a627c62a835524b3f5b471edbbbcce025

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
