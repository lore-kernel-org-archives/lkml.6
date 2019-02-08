Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582DC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567F72177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655109;
	bh=IxH9JYF0gowAzl03NpZVeOiyro/q3s/o8kI/MwLlQ9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=B9iI9i7ee8dgJdeOuTzAqz9JJXWeoNxvSMCYKRazP5nJ+teZ5e9tn43QZMkAsBwqE
	 BlSY64FDjpPXpqSzzfP3qC2A1EHyMJW+Pg1FCzYrtV7xgrXhMiTGi03DiMmxdRZSTi
	 fFC9I2XxEdI+K0YZL0oW6ajwMRRJkf2a0pujFlkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBHTpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfBHTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:04 -0500
Subject: Re: [GIT PULL] xfs: fixes for v5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655104;
        bh=IxH9JYF0gowAzl03NpZVeOiyro/q3s/o8kI/MwLlQ9o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X1nRJtmKj6+g9SFQBSxMT3A5fbqTKd/Kt/TOX/vLvpfVVBLEO/0XS7md8ERgqokh7
         gQTma+Z3Vt74EHSs362lN+DsIgtWEcV7014KVhWbxkiuUi3AcBV4Cj7C6x6FI1ii93
         SaP/03S4IFdkxWEnECWsWdCW6fc6AvJjOtqgaSGs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208072517.GL7991@magnolia>
References: <20190208072517.GL7991@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208072517.GL7991@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.0-fixes-1
X-PR-Tracked-Commit-Id: add46b3b021263c02d5a7080c58e5b459479fafd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd5ff862ec7855cc7a110891443e7dc6deeb6b84
Message-Id: <154965510418.5511.3372169854260519470.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:04 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Feb 2019 23:25:17 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.0-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd5ff862ec7855cc7a110891443e7dc6deeb6b84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
