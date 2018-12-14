Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788ADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6872070C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809508;
	bh=lJ1/8Fff2LMjJz/8pQUkjV1SRWl+vi7VJFDvxHFJ/7I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oEIkT3IQa/tKEwPGxyE/nHFDRTq0n8nvAVfWa3XHY0OkDZ8LvzSsIcwlOVwATQ0qo
	 xAG6fnVOthvAGVt7Spp8A8xuTjxTesbvuPdfO8KcQ8cSVEMB9Jszw9S9OhzQq0VhBe
	 Kpgyg1liJHbFAY/tRlPvs8UrEmKg08t4gDBdBUy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbeLNRpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730335AbeLNRpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:45:02 -0500
Subject: Re: [GIT PULL] Ceph fix for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809502;
        bh=lJ1/8Fff2LMjJz/8pQUkjV1SRWl+vi7VJFDvxHFJ/7I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f8v+7ErbBKNXrnBTSeueBGmNhWQJ76fHSNQJ4PLoKD7gTEPJfd1ZjoX7Yef6EcXqL
         RKRalB2gvaSoc41tZexA9pacioYsvVqQelrA3nNHWdOyupdc57TvTIKIXuZYRV3fea
         9mKTWUrV7gca5IzggR0vZCFoL22bvtFbNAF3NkkM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181214154858.1155-1-idryomov@gmail.com>
References: <20181214154858.1155-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181214154858.1155-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-4.20-rc7
X-PR-Tracked-Commit-Id: 6f9718fe41c3a47e4362bddf145e2db6ad7d8e87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c19bf74fe4d979455b22a8e998615a3d46e24c92
Message-Id: <20181214174502.32554.59087.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 17:45:02 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 16:48:58 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c19bf74fe4d979455b22a8e998615a3d46e24c92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
