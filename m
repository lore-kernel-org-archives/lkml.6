Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62485C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3146B21924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422212;
	bh=rDQkfKCBniiulviQudH2WN6QiXUVLkq/60GTE1DxP8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mo2ODlc7CBQbcN5fZYxxwPtQ0zykI3mR5v+RGAES/Umg2bktwLU7SVPMMQ3ZWUQd/
	 g0KqhCZ5ovU37sLwJjMljvBQjylK4Ko0duvn3cNdMjpU2GwH1fxKTFtJf8UDcmHZhV
	 iLgqpvyI3gimPD2+rQQk/zbugz0rpupRbkG+ff2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfBQQuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfBQQuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:04 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422204;
        bh=rDQkfKCBniiulviQudH2WN6QiXUVLkq/60GTE1DxP8g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NEw6BQg881AwtcsvJ7mcJQtdLlexKlk1ZRHd2ewc2EHlL2XBFanebiWqPOviGVt75
         MCXdZ3hFaUX01R9RSoZOSY1KVxdTpaEpVA4aWXeXVod0vNY/fvTPNuf7JXCMTn+qGz
         FSHD5vCrSsjW0g4mcetrPl+eyhIf88wMd338yaB0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k1hyddwd.fsf@concordia.ellerman.id.au>
References: <87k1hyddwd.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k1hyddwd.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.0-5
X-PR-Tracked-Commit-Id: a58007621be33e9f7c7bed5d5ff8ecb914e1044a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f1ac5e9afb199638414be77cbc22eb68e14d97
Message-Id: <155042220423.16506.13995692553358702510.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 16:50:04 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Feb 2019 19:20:50 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f1ac5e9afb199638414be77cbc22eb68e14d97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
