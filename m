Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0660C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16302229E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780005;
	bh=1UTODwk8mwaBVOKcrw+Yfeowtnu9yU1ImFDqKLPwrpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TrjVOF4CBQzqTQheslr6dPjJOqOOH3cYtEQpXd3B529SrI5J7DABYQ69Sw/EGs6Fa
	 wDoyYHeKJnb8VY27kMYttLNcU7L8BL1dIDKpFYXbQYvAhNVj/8325ZkyMhVpBOm4kl
	 bHqGsriGk4+XEwAHbRQ3ipSTe8a4PJvqJKy6PdFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeLYXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeLYXUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:04 -0500
Subject: Re: [GIT PULL] mtd: Changes for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780003;
        bh=1UTODwk8mwaBVOKcrw+Yfeowtnu9yU1ImFDqKLPwrpo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X3nWDdc/duK3zdbFP96Sh7Eq3h7Z/l0/WpcQytu8Q6ATcORCmt9AicyWvFQQMEnzO
         TNjXObxpPj/A4w1QNpprgz5zFmtOERUEQNeZdqNL0YvAvh3/GOgA1KAdIEefVhSjwD
         PJjykfyGmHHLDjL5I0knyIjbRyHQn14u9NNpxh/c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181219170722.349d7b61@bbrezillon>
References: <20181219170722.349d7b61@bbrezillon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181219170722.349d7b61@bbrezillon>
X-PR-Tracked-Remote: git://git.infradead.org/linux-mtd.git tags/mtd/for-4.21
X-PR-Tracked-Commit-Id: f366d3854ec0fec0f9949dac46431598614a956b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaa76499711535fd64d747cc4ef0d78ab0fd41c6
Message-Id: <20181225232003.23808.86276.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:03 +0000
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Dec 2018 17:07:22 +0100:

> git://git.infradead.org/linux-mtd.git tags/mtd/for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaa76499711535fd64d747cc4ef0d78ab0fd41c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
