Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678E5C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3734420844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672841;
	bh=nN15dXFZ65OCJ74j5NPxi9Q9vUAFHCTZxEHHSYuCpo0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WQ+XFTD3Q+QN8BeVNyCAhKwWrZ8mAjACmTSVJkViyYY4Jc7VfkzvVfmXWgqzUp5AY
	 svQUcCtMqTMgrd04lsMhazz3f/0xr9tpJbeAIx1fa0VW+/ajzpxWzzkouc6qXkHWUR
	 5N3jN9qr6v3qJsaks1bYXs/pIyzof1SOy7K1iWkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBIAke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfBIAkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:04 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672803;
        bh=nN15dXFZ65OCJ74j5NPxi9Q9vUAFHCTZxEHHSYuCpo0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uDy4DquZ5JKoBK8NRdmOAq2/lO87dGMGobdVHY1b/yafshkpBuQLe9WhvMuHSsyao
         h8+vQaspUzPkzwIZZ+AMMW63cr/K01XkNZZ2iePYGCgcz1R6b20re3OjcFmnDiRz+1
         wkwNlBHFlUmSPLHxeqpxx2WCZH9DX7P29aY7wsQA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r2ciiftz.fsf@concordia.ellerman.id.au>
References: <87r2ciiftz.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r2ciiftz.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.0-4
X-PR-Tracked-Commit-Id: 5a3840a470c41ec0b85cd36ca80370330656b163
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 820828bffeb11eee41e197a0c9be1b72afa37482
Message-Id: <154967280358.26526.13984205969695833579.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, oohall@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 09 Feb 2019 00:12:56 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/820828bffeb11eee41e197a0c9be1b72afa37482

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
