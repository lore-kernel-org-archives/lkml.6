Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB8620989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545274208;
	bh=gHB4sPyV3xsmMjxvVzL4AcL6bRg8zca42DmWc0qCKM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C3ET2yrlDv/0SdXdFczU+1M+tQRGhGMptxSWxxZFYPiT7YdQ/u+usMSJ34qX6DBmv
	 SbwxiYZBv1kH78oRH1vtvSm+LycV++R0W+WZqRns8wn9PmETNQBV2kX7XKa/fHrU48
	 Shjpwe/BxFqHtfmY+9M57bbn0EMY3sQdly3CrZS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeLTCuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeLTCuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:50:02 -0500
Subject: Re: [GIT PULL] dma-mapping fix for 4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545274201;
        bh=gHB4sPyV3xsmMjxvVzL4AcL6bRg8zca42DmWc0qCKM8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tHxDaMPeuMryWOXLAWdMCNUHC7MS8yUVQdLsS4U+ZavnBCEaHvKeYkyTQnya25BYP
         oPWuupqvy6Owe3OZ+Y5+pltlL2048OcsO//hJ+CdwaHh3vXhuCnaIeF00MvpcW2OTf
         0smQqLEvgKFlNKk9TGTeURph4pyZ8WoZiYWTrC64=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181219142419.GA1112@infradead.org>
References: <20181219142419.GA1112@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181219142419.GA1112@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-4.20-4
X-PR-Tracked-Commit-Id: c92a54cfa0257e8ffd66b2a17d49e9c0bd4b769f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dd516ff7d852c2cda8c5b883d6625d1c812714e
Message-Id: <20181220025001.15095.47587.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 02:50:01 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Dec 2018 15:24:19 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dd516ff7d852c2cda8c5b883d6625d1c812714e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
