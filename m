Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8FFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0FE218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548275410;
	bh=gQSqgebifWAw13l1NKIVq4Nu02bbuCB1opJxE/Xyxfw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ylMMxhY3VTv8h2ud5GNwVvrAjkjPyjkv7LlXCBZK0R/ppyWWQLGRV66+Sx1l8o5ap
	 Y10T30sBM4fCT/L+tpQ3RJRw2oyWxbZU7Vc3w04ceZ281dyFvvZgA5dff4y/91GnnE
	 SvnLQZvuOcjhVdeWleWO4ZRiCI4VWO02kF87yCyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAWUaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfAWUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:30:05 -0500
Subject: Re: [GIT PULL] IPMI serious bugfixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548275404;
        bh=gQSqgebifWAw13l1NKIVq4Nu02bbuCB1opJxE/Xyxfw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vDLln3ZlnMD1H48ArBaffPm6GyqXFBRj7eaYz3DssoSgJrjIpcfqFoSM/nOpGzhpf
         X4T+L6cr8cq9adXFKzsd2x0qqcy0HkcTkphd5CyN7aJ398skWXuII+B6q23EdT4qZQ
         g4nAiqftEUtX6XCPMLzF0qi61GJKswCeZe+tCR8g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <200450ff-49dd-da74-53b6-b0a0d71b4c8a@acm.org>
References: <200450ff-49dd-da74-53b6-b0a0d71b4c8a@acm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <200450ff-49dd-da74-53b6-b0a0d71b4c8a@acm.org>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 913a89f009d98c85a902d718cd54bb32ab11d167
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db781446312314fb11a860ece9a757db2c2d69f1
Message-Id: <154827540446.2661.16841279585553546091.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Jan 2019 20:30:04 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Jan 2019 11:28:37 -0600:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db781446312314fb11a860ece9a757db2c2d69f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
