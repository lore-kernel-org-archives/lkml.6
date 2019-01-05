Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F986C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9962133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546727542;
	bh=CK7L9HcZrH2uyCP0dlRTHtGCW0qui2EY3DAlKqxgd7Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BHOQfjQMsNp9XYE5dJdkCx6lGPZYZqsdKl7nwcqK7jM2BpnuTAbeWBRg+jeX3uTMG
	 BuAkp40NmTehUhRKXpLmDVohqV3h3mugpqh/A/knyjE69F3lCwutJNOEeCUxBToCAi
	 /L5NEHiOXAazQ3Hd/pN2H4biro763jWh1djsrzV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfAEWcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfAEWcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:32:15 -0500
Subject: Re: [GIT PULL] iomap: more updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546726503;
        bh=CK7L9HcZrH2uyCP0dlRTHtGCW0qui2EY3DAlKqxgd7Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ExLxRSKw+v593hz9KVg0bcBBMbekvv5KMlbZpO9xHTIrqfCEEYmIe5LPbxUGnwWld
         kQh/TvHHbi/wGErm6jTgAYebVA0hE8TzzIIMYNuM9D5LLCD0mVBezGkngA6ShzMyj4
         R907SCNfAwhUig8C19SIor4FJ9ClR204HkXw767g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104010645.GA12689@magnolia>
References: <20190104010645.GA12689@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104010645.GA12689@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-4.21-merge-3
X-PR-Tracked-Commit-Id: 31af12efd0a259de9b0d8ef626503911f13b584f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cd6d495db2a0acfd2854f43aac8bfc5914bc89c
Message-Id: <20190105221503.6651.32069.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 22:15:03 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Jan 2019 17:06:45 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-4.21-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cd6d495db2a0acfd2854f43aac8bfc5914bc89c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
