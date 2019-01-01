Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A8CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED48C21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546307118;
	bh=vttDdXVjn+uQFGXjqG8qB3aIweRo98HkVREcbVHZa5E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=g68YBQXEVEb4schNtl8LNdqTYVpih4MXv4I46RX4RdBqcSkn5vCM+pOU6p9bT839z
	 HiK0S9Ke7SN7L2CF1uq7mM8dnuR1fxu6Uz4/sk8yRgJPEOdrE48rYlb7T6kgC9OYS3
	 aGt8mhYCF5McTD53IV9ZDY1RJR4PrJerqHc1d/Oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfAABpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 20:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfAABpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 20:45:04 -0500
Subject: Re: [GIT PULL 2/4] ARM: SoC driver updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546307104;
        bh=vttDdXVjn+uQFGXjqG8qB3aIweRo98HkVREcbVHZa5E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PDhFdVFy/pcmqMDVzGLiTlAUZmC2y74/XumNuxehpdOZoHar4MgDTpr07IfNim6rH
         EbYsbbaTpjYQynaoHvemwbOk9VUqJu/DhtDlQgyHrR1GIlr+QF/1pjPHivaUVTD7Ca
         wXkWDnV9y3wO3sRKceFYvR6dtTv/Tj2dtHT405KY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231214640.17015-3-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
 <20181231214640.17015-3-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231214640.17015-3-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-drivers
X-PR-Tracked-Commit-Id: a6f119a06960ef1dc30570401e43b71f9ebdd2c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d36377c6eb071e3d0751e9e0e3c19198c58d9a5d
Message-Id: <20190101014504.19922.13368.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 01 Jan 2019 01:45:04 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 13:46:38 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d36377c6eb071e3d0751e9e0e3c19198c58d9a5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
