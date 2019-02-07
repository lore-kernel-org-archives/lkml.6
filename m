Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1355AC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66482175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549580715;
	bh=fe9QDh4sTzA9Xev/wiNVw8XW/rRHMTj+OHZEalTz/4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J3uKPzhODHUzZi3jz66ZRabe7rrzxCtMheKVrna4uMMCssMLv1mqFkpz7onaAu3Mp
	 NVPdtyJVDUT6IKPHWGADdTouwlRAIede7A0hcaAzjjeHXDb58ND9C3ZoHH+Tors8AH
	 lWCL+N8n5BfvcfgEQUrhcI3sPit+PaoiPAgCBUIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBGXFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfBGXFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:05:05 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.0-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549580704;
        bh=fe9QDh4sTzA9Xev/wiNVw8XW/rRHMTj+OHZEalTz/4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XqFJVELi7gaCqdtTEcfSZuwcnJHu4sTYCqAAnPt+Vwo7AD8K23M2+Wqlv0k/KCLtq
         nZXH7ZIHIPxsqJsA77/m68Fgfq+YT0onTcffl0Vr3ZSlKv6PjFbpCUWCk3EXJzqSjN
         Ws44vSoC7ILdZRitkOUJTvP9LoMk1+p3aYZTIh+E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190207223017.GA27814@wrath>
References: <20190207223017.GA27814@wrath>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190207223017.GA27814@wrath>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.0-2
X-PR-Tracked-Commit-Id: 6a730fcb9cb472ba2d42b26a50ac65dacdd68882
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74e96711e3379fc66630f2a1d184947f80cf2c48
Message-Id: <154958070467.8830.353530907841079050.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 23:05:04 +0000
To:     Darren Hart <dvhart@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Feb 2019 14:30:17 -0800:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74e96711e3379fc66630f2a1d184947f80cf2c48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
