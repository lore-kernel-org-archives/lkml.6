Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587F5218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545961506;
	bh=GsG/5sQUUzOvgbh9/aOWroc5FPxh1QmhMvZB8ehfE4E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uw/ICjMKM29xlbKeysYDYzXuPR+XX5sjrYhovCOGjjSSdGHgSzKG142w2QhkBmqyK
	 PWIKoFKvwk4WgPQqzZMDqikr5oOwV+PQIefHIZIEAc3DbKfvofmrju4neGq5lFH/fn
	 wVJlaght3/IKstjGXG/LhO/NOs5dWqf7wZND5Mag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbeL1BpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731363AbeL1BpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:45:03 -0500
Subject: Re: [GIT PULL] iomap: updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545961503;
        bh=GsG/5sQUUzOvgbh9/aOWroc5FPxh1QmhMvZB8ehfE4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wk95cp5HsLjflIw7WO3dVTZLZn0uHofCoUTpRDyj9uriVzpVV55pNYSHIR9g6KsmS
         TxsYCBf5DK/KWq75a/QIr0MBrebI45FzcMMsSpJR/zMtawrPMJhgW5fCi0riQowvWn
         FsbvogxCNs9Wvfe1st+T+Z1BW7x0tD0dmpwETAQg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224004204.GL27208@magnolia>
References: <20181224004204.GL27208@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224004204.GL27208@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-4.21-merge-2
X-PR-Tracked-Commit-Id: 3cc31fa65d85610574c0f6a474e89f4c419923d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc77789a491cdc6f47e5bbd1d04ddd283d64658b
Message-Id: <20181228014503.3597.80670.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 28 Dec 2018 01:45:03 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 16:42:04 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-4.21-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc77789a491cdc6f47e5bbd1d04ddd283d64658b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
