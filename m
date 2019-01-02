Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7279DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4959F218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546456211;
	bh=IJ+U1cZ+JyB6do2X+4DwkOoYAp5NuyRi1TvvWnGfHE0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CIdv9C9qt5G6Fl85qzL06I2VBC0Z7I1WEBYPftvi5mP/wZ4M43wDaFFe/NWR8BISW
	 PEgOu3OSU4kEEg4H0ZQXqxCTxlxh2xOtkT1Bs3zS3GAzPPOFTSXKEu0g5cE8TM/VrX
	 OdCXXvqG3/2GJmXNC6PkeQOQGvorS2zH2CIgV5G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfABTKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfABTKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:10:05 -0500
Subject: Re: [GIT PULL] security: TPM changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546456204;
        bh=IJ+U1cZ+JyB6do2X+4DwkOoYAp5NuyRi1TvvWnGfHE0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uuq++T6gHhCu25daLCbslVEXJBLs685h1jZ54muwuwsZRsu0j8zH/bM8embRZUKF2
         dT1UnwQu4HgiUonJ5VyAReDRtrEGezUzcGD2BlU6r+3Jh8WbT/4rZYncSeu2QPnW7I
         IM/69oCYvKN8JF7/OtDlomVLE6vS6Akk8Qrg6JlM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1812311516290.1435@namei.org>
References: <alpine.LRH.2.21.1812311516290.1435@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1812311516290.1435@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-tpm
X-PR-Tracked-Commit-Id: 0db51ef26e87845d1748c363702585e2f0a06266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74673fc50babc9be22b32c4ce697fceb51c7671a
Message-Id: <20190102191004.32204.86682.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 19:10:04 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 15:18:38 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74673fc50babc9be22b32c4ce697fceb51c7671a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
