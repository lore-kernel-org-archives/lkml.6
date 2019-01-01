Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED42221720
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546307112;
	bh=It5tPXSd/Qxjy6USBqSPaqQ6+Mn6pStmr1k5Y+V5blw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=R4s1r8DctgCWIpsg7KTcF4aVwmuH+MPO+dwrR2mavO60u86XziAJjuElFw4Gzlntn
	 OX5o9u/wVA/J29sVKZNBo9ObKYXZDwCu+QW4GOWlGCHN+TYmAwdW043yx/PGnKKwB4
	 C11nq6tvr5vx2gBwRzX62joxCaSIZznabQsI6mng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfAABpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 20:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfAABpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 20:45:05 -0500
Subject: Re: [GIT PULL 3/4] ARM: Device-tree updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546307105;
        bh=It5tPXSd/Qxjy6USBqSPaqQ6+Mn6pStmr1k5Y+V5blw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GNATetposYeVl/GzX835mQJCzsTDBVYvFHsOXHbqkS4mdu+Nuy/F9Zepdh99Vm9eG
         dfHGgDG/VbZAjM+YPPVeEyK7T4XUqIzUsQrFryvc7F5oZnp9kswDOiOLYjKfesGfNT
         8FqiGMgIWm8f1CS9qEfaB7PeaR0Hv7ChAoJiIVFM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231214640.17015-4-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
 <20181231214640.17015-4-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231214640.17015-4-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt
X-PR-Tracked-Commit-Id: 3f47de2c6b6068cf7d5221f8f307969e7e4f1fc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7badd1d7aa61087010803affa19bb83fb5a0af1
Message-Id: <20190101014505.19922.49869.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 01 Jan 2019 01:45:05 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 13:46:39 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7badd1d7aa61087010803affa19bb83fb5a0af1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
