Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7ADC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD782085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546806018;
	bh=PWhpPuK5TsQRkK17p6XxZuAaRmI1nSpXv7gsVzlgaTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dkjCW+AJdwlhNJLSYRaIRsQPGFgYCUycbnv8yNDaBp7q/pcHn6qDnFoWYJtvxfAw0
	 AXLX+I5beAWeZEdPjpNkovYnQR5g+sbU96izqXfjr1kHMCre4OCbem5iqWMOjNCx37
	 gB0DjZyteSTsrm4m/p4m7VKbXwW6nzCiXg3PRuiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfAFUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 15:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFUUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 15:20:14 -0500
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546806013;
        bh=PWhpPuK5TsQRkK17p6XxZuAaRmI1nSpXv7gsVzlgaTU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b9My1aqUsk1PR4J8xBBpnbMLfjRFkpTyQSki/9dVydjuvNhthe+bN35StCi5GdMKQ
         O51HIQ8GDGmineldKD+CxHqf+menYZ9SE9GL6jLuzVjhlzHWIF53jNfQCv9bnHHXQe
         7iyDa2EFbsNUhtNSrajqfOqAPb0xma7rpRgBFu1g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190106182846.GA10665@infradead.org>
References: <20190106182846.GA10665@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190106182846.GA10665@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-4.21-1
X-PR-Tracked-Commit-Id: 8270f3a11ceef64bdb0ab141180e8d2f17c619ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2b745f469ec0f3165ba5ffaee3ce40f98d77878
Message-Id: <20190106202008.19789.61915.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 20:20:08 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Jan 2019 19:28:46 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2b745f469ec0f3165ba5ffaee3ce40f98d77878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
