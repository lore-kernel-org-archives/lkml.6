Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A5FC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406972081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544381437;
	bh=WIAWhsJiLn7TLWoCJsCtBSGVLvmL2hJMGWTQPVobR1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OZIMreVuAptsU+p61bJGFVe7HNTnNvcJ596yXKaX8rNupyqkjm4wSFiJxC+FMvphk
	 pZ8RV0xFRtzGtVuyIRbzLkktCZX3Wi1yfoKmRCZUGBWN30qOv818MYgi8Fo3r4ExJu
	 1DAesrleexBslovlvVifO6C1zdXwntkU08oph05g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406972081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeLISuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:50:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeLISuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:50:02 -0500
Subject: Re: [GIT PULL] libnvdimm fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544381401;
        bh=WIAWhsJiLn7TLWoCJsCtBSGVLvmL2hJMGWTQPVobR1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uDJCmNaephRFrS/fJLP6qhuXnfc5VEUyCtyiBRQ4hg3W6MPYwefdoq8GQHM+QVXvm
         4UBndqSJG6hCWGYnmWCwEAximTZmwXeaxLawywUPaCKqu0B6hgYd+iUHAHlvvDXZQD
         YoClEd/2bWXi1MaacPnTLT5ZlRPtADI4F8+87UuI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <705f91734ecb4ffbddb2470a797541c876745c6e.camel@intel.com>
References: <705f91734ecb4ffbddb2470a797541c876745c6e.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <705f91734ecb4ffbddb2470a797541c876745c6e.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-4.20-rc6
X-PR-Tracked-Commit-Id: b5fd2e00a60248902315fb32210550ac3cb9f44c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd799eb63db4c61a5f2dc941672391fbca5bcab4
Message-Id: <20181209185001.3376.78053.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 18:50:01 +0000
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 06:18:02 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd799eb63db4c61a5f2dc941672391fbca5bcab4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
