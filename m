Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB662083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549216224;
	bh=vOLTAuK7IPTju4TVc3WTRnsIs1NAKPBmIq1n/Z9NMOQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bR93oIkoBw3UhN2rtfPj2Rh7sS8ESpUEdeScHAYlk3Owq0MuvyfhxIERPA8+IvWnB
	 2D24MO4IadZiGvJF7W7whIPQLmTU7zBI0f3AKWQ3lGoWpD+ni0WTAXTqr8m4qO7r4q
	 I6VjnpdQkD8gmimeYBznX/v4IiJE9xpL8twEtvl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfBCRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfBCRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:50:04 -0500
Subject: Re: [GIT PULL] Btrfs fixes for 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549216204;
        bh=vOLTAuK7IPTju4TVc3WTRnsIs1NAKPBmIq1n/Z9NMOQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wuRpx3q8Gve7psXydbh/vd0zBuExXUic/Qm1BL4YK9MUKut6IVyIJ8VBr2m0hqG0j
         uEAauVNRC196WmSZHiT+1NgLvT3TeK6xJO246pwQ//6m7GQ7Xy/pdQoXdI7wbwdeDo
         h7fvvsqV5QVpSJmLtJL9+RUMdldwZRaWnO/HGDIA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1549186243.git.dsterba@suse.com>
References: <cover.1549186243.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1549186243.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.0-rc4-tag
X-PR-Tracked-Commit-Id: 532b618bdf237250d6d4566536d4b6ce3d0a31fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 312b3a93dda6db9354b0c6b0f1868c1434e8c787
Message-Id: <154921620417.4136.10303400021704338377.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Feb 2019 17:50:04 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  3 Feb 2019 10:48:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.0-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/312b3a93dda6db9354b0c6b0f1868c1434e8c787

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
