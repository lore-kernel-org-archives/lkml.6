Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A7C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4D921479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544123104;
	bh=bfhUj3t/d8XzSFanOKAa67E/M7lp9jPjnpebJbWRK1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vUHe48kTCcot/56G2M7vy8l8EfLjgNsA9XhI5LXWOzjRYhB0VMcW0sNH/g2PkNZQM
	 2hHNf8fsCMEFG+Wx/HfVqCNTU5BoilJ9CtS18FZcEHy6Z5Bbx6z21gPCJrad3WjmPI
	 MUrbgU61FzvDlDwOn2M8+kvZhP5GHMQd4235vORs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4D921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLFTFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFTFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:05:03 -0500
Subject: Re: [GIT PULL] C-SKY update for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544123102;
        bh=bfhUj3t/d8XzSFanOKAa67E/M7lp9jPjnpebJbWRK1c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vPDsfyTJzJFUOFjc5Cz/v4fJl/QlGwt6EPpbfeboylL7AN6rlnnQI9vyyss4BCzjM
         3QnT+QWfenf7n97E1nAXEA3AxhScTcJx6OGCjA8aThz60MOJQE2pfGoSDXJmtxtgoz
         uVE/ZZNGEjji/osrwlRYGbts9TNS7gwzLnpALcSo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1544074378-5878-1-git-send-email-ren_guo@c-sky.com>
References: <1544074378-5878-1-git-send-email-ren_guo@c-sky.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1544074378-5878-1-git-send-email-ren_guo@c-sky.com>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 63e19c8216bb03a1b4d10f6637d1324ae7a2b612
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 002f421a84c5a9260bf0e312af5d5043b3555511
Message-Id: <20181206190502.10356.49493.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 06 Dec 2018 19:05:02 +0000
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        guoren@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Dec 2018 13:32:58 +0800:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/002f421a84c5a9260bf0e312af5d5043b3555511

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
