Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62AFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817AE20869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047025;
	bh=KVsejsSbL1DRFO2OQDXks8oWyPDhFC8DSj82MvbhKl8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GBXniTsFxOOg7i0LS+zLOOE71so/F3tLvj17wthR70wsLXrhpSZZmOJsgjS2n+jnd
	 1EGAgRBYm6xys1wzuF2P4KsHHAf2mIHeCr5SUvRU7Ux2aHsYCr7zO30KoUUXlBawRn
	 DrPY5h684bVigZuD0oDIVRhlDRHUKSDWyJXDB+/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeL2BaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbeL2BaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:04 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047003;
        bh=KVsejsSbL1DRFO2OQDXks8oWyPDhFC8DSj82MvbhKl8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0d5bvPjnrp/YqbWRhGac0YRz1fq97J/zqPSV/1mRfN+rBbZUhz1lLTYIlFFw0Yx8R
         Et4An7Qq3vs2MPRNv5hS7GPBJlX1opb2DM0+VXJ+s3kOinB7hcvUzj+m7xlkihrv3s
         k2Azn29xg4qPptaTsruwxZeWSjeCeq6T9CADHqVI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224221606.GA25780@ziepe.ca>
References: <20181224221606.GA25780@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224221606.GA25780@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f617e5ffe04fd46010b618c9eeadaa04588704c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d24ae67a961c51beb255a28c9c417d9710247c2
Message-Id: <20181229013003.17208.11235.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:03 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 22:16:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d24ae67a961c51beb255a28c9c417d9710247c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
