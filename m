Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85108C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588FC218FF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685005;
	bh=zg+Ej0D/7BhoH1v/DwKVwEnzQ3Gs2hKPIFRdMtQx6Fs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FuFSb6AF9oW7FR4MEn+PFKZqjQLUvbiIaS9AcFjuNb9VQKbZ1nNSvEWfTy4RdZnG8
	 RxqV0lXUwJdyfBwGFbOXTgTNraro8rnlX04UNZktJBlgQg56Jz/RDPfCH61UtTe5Nt
	 tw1JwmOcXaPZXxCEEOEuLnHPylX0t0h5rysVO7Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBTRuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfBTRuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:50:03 -0500
Subject: Re: [GIT PULL] mtd: Fixes for 5.0/5.0-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550685002;
        bh=zg+Ej0D/7BhoH1v/DwKVwEnzQ3Gs2hKPIFRdMtQx6Fs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bhm5vt6ckYnfBfzeVos418IUynFUekxz1N9nEN0+1xjaqoLPb0bsD2ECwYQKlF2g1
         TZNWlcNXUHNw/7oWofjWKYlPrK9yAVRznI+tSx8683PQedkNkrm6y/y1+diQwrvFWD
         b17daVGyCKfgi6XTYO/uWuMYVggd/gReIiDv8Xd0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190220085653.182aa2c6@collabora.com>
References: <20190220085653.182aa2c6@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190220085653.182aa2c6@collabora.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-mtd.git
 tags/mtd/fixes-for-5.0-rc8
X-PR-Tracked-Commit-Id: 3e35730dd7540bad2d4e002703996391d9be49a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d9d592caf8cc5d91f7923c5e717b69d0b1e246f
Message-Id: <155068500279.4632.10929354702405821983.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Feb 2019 17:50:02 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Feb 2019 08:56:53 +0100:

> git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-5.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d9d592caf8cc5d91f7923c5e717b69d0b1e246f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
