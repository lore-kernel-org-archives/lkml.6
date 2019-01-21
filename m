Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ADC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D821019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548108006;
	bh=21ieOg3u8BhvK6L9Cm8i4lvccV+4vpE4wlN64sZfoTk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GliVyDLtuAI9C6lTUsy8ej9v5SpKk311o20c1VYPlildADd3INPkfw3IsN01k9/VW
	 cikHVCZFOOEYQY+99VW53V7GhxBf8A9D8TvkMcwwWGMs+85h5+u6ki2weM84Y92IbV
	 tWxqLGz+PmKcjkt7/vOxXsvfmbg7dOdu/Rk15QD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfAUWAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfAUWAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:00:04 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548108003;
        bh=21ieOg3u8BhvK6L9Cm8i4lvccV+4vpE4wlN64sZfoTk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qz/COhstM0XsXSDQKwrkUxpbyCbPVnXky2m7wp9DZXJu93PxQ6yh1swb23kIvmuoH
         zmennj7Jf5kBX5/CIQsnYp55yGEkXe8d6bacXWKDiARyHVeOl7bAAvmGCa6neutWvl
         6EvOFYsG0AXEUIzUeJJxC2KWyPZtlRFhIoA178sQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190120.140904.1469008705040899269.davem@davemloft.net>
References: <20190120.140904.1469008705040899269.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120.140904.1469008705040899269.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: 6436408e814b81046f4595245c1f9bc4409e945c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d0ae236ed13d7645fb73b85e7c95deee46c4656
Message-Id: <154810800371.17432.17933534197531404622.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Jan 2019 22:00:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 14:09:04 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d0ae236ed13d7645fb73b85e7c95deee46c4656

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
