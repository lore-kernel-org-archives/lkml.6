Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B03FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD0F2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547321704;
	bh=qhXZOoNQAeF6LdrgDIlU/1dzd4Mm23ua4nCm/emC4g8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q2q0l4h477bmlwnrozvMYe1uHJtLBnchOvHi0v9uQ62JcPhq+81TiVHjHejS6jHU8
	 Uw8as5V1R71M3HNrtc35vSJ+ogOf9Eo8HvmaBxp3qyBtHVL0AFU0IIb65PVD8zuwKY
	 7RbudDjmC8NSnnLIiEgQmdfQbWIh8KmAvXBLqnI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfALTfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfALTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:35:02 -0500
Subject: Re: [GIT PULL] remove dma_zalloc_coherent
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547321701;
        bh=qhXZOoNQAeF6LdrgDIlU/1dzd4Mm23ua4nCm/emC4g8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CjqTyYoOSyvAYEqZPNujZDHE3nsybdUFJS/r5Nc6AJFxHDTXRocpzSBZuo/upMbvm
         5kogvdMqC/1N4oLh3mFm8g3BHcx294sue+xI5wpWI/i+SKf76zhARvgW3/dSmP6WhK
         31WmGC1H/eo8is2l7RX7NCM8rW45336kOZ6IxIlk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190112181355.GA31454@infradead.org>
References: <20190112181355.GA31454@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190112181355.GA31454@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/remove-dma_zalloc_coherent-5.0
X-PR-Tracked-Commit-Id: dfd32cad146e3624970eee9329e99d2c6ef751b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66c56cfa64d9dbb9efa8a06c1aece77e8d57ea19
Message-Id: <154732170177.23453.284678672823966812.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jan 2019 19:35:01 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jan 2019 19:13:55 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/remove-dma_zalloc_coherent-5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66c56cfa64d9dbb9efa8a06c1aece77e8d57ea19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
