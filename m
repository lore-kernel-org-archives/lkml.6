Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4409BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082CD22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082CD22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeKNK4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeKNK4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:56:34 -0500
Subject: Re: [GIT PULL] Ceph fixes for 4.20-rc2
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3F92089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181109164755.13100-1-idryomov@gmail.com>
References: <20181109164755.13100-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181109164755.13100-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-4.20-rc2
X-PR-Tracked-Commit-Id: 23c625ce3065e40c933a4239efb9b11f1194a343
X-PR-Merge-Tree: 
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d757a3b01e72368176c5ee580ea17f8c2d185cd7
Message-Id: <20181114005543.8329.30011.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 14 Nov 2018 00:55:43 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  9 Nov 2018 17:47:55 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d757a3b01e72368176c5ee580ea17f8c2d185cd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
