Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB387C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E1721871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546389306;
	bh=Y8vVP9tET93dTKZ0ej+adEvylToLmmgGsyJw3sjqQ2c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0wcNhRYOok+Pi9tmT3SlNpYTJ/Qj44s8Qrrq91KkROaXPZCwrYfhN0UW6A6EX8vK7
	 E+HnCV1ss5TL4efJByLN3zgDQS4QigdD86jl1p6ousQvcfHATk0h+yaM/6w+48fv+y
	 mJFZ3Cc+/iJr6aAIEZrMPcpGD1o51XZ29p9R3IXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfABAfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbfABAfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:35:03 -0500
Subject: Re: [GIT PULL] dmaengine updates for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546389303;
        bh=Y8vVP9tET93dTKZ0ej+adEvylToLmmgGsyJw3sjqQ2c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y7CQweB/MlP9klzTnoFi6AvG9vPgWvg4vLi/ZPhxtKmUQwchoHoy7MXNW7i2QXJCs
         bbVyzIsJdoiWrQthcwyPOF+R4JA4JkBfnaac9dulUHB3UbtJ7sDSG2cMabSVZeJRG7
         73WSbVgGcUaM1ac7LCuXtGnJkGct9XPXvkKMTTu8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231145136.GD7581@vkoul-mobl>
References: <20181231145136.GD7581@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231145136.GD7581@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-4.21-rc1
X-PR-Tracked-Commit-Id: 660611827c03afeb0eec178dc1fb9f842332d908
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78e8696c234ab637c4dd516cabeac344d84ec10b
Message-Id: <20190102003503.1457.26882.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 00:35:03 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 20:21:36 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78e8696c234ab637c4dd516cabeac344d84ec10b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
