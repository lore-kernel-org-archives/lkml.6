Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526D2206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550860814;
	bh=+4cH7d87UBsLjP60Ca0yOJ3on1BTxw8MKW2eP9qG9zw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZrP95z+gZVCK38O6gmO7S4jryq9rSp+jdbRv3rYm9qBSCYsow43LUkHxMBwOyXQUf
	 2nePBIVTx149hNTzVwB0f3pweZjDYfmTrgkodTu5jcwB+2tZigTJy9Gd7d6POHbNBn
	 BSnFYesGarQUa8aFkKs5MWad36oVjFc1b78V6rIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBVSkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfBVSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:40:03 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550860803;
        bh=+4cH7d87UBsLjP60Ca0yOJ3on1BTxw8MKW2eP9qG9zw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0ofkj9hrt+20p7C3cYW7oBaVEpz5o2a0FiXXXsyOB3vKt7rhoKJbzK+LbnBx2JAnM
         Gk8gZ/cuk0QVa2c+xfjmEkxkIi7i034NxrR/TrRvO/Tq5t72CQe4O6ZEjf3whsJpGF
         ZiR27++SkURqvU85PaIlaUdfzYavlf/H/OfSYp6c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190221230714.GA10656@ziepe.ca>
References: <20190221230714.GA10656@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190221230714.GA10656@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f09ef134a7ca3f0d2ce485a757f5b79809ebb803
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 168bd29830e8ebbffcd70d2af50249dca088e1a8
Message-Id: <155086080319.14712.5526864335331544515.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Feb 2019 18:40:03 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Feb 2019 23:07:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/168bd29830e8ebbffcd70d2af50249dca088e1a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
