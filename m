Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C53C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C83C21902
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047044;
	bh=Nl1gQ6r269k1jxuQ8HsARw8GpxfK2MxDTgxLAwonOss=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=S26G+sVuxvDiDRhr6AigoTVnTz8ArmDIqnLqXuxoDEgfC0qduG0duq7VKauarvEiA
	 aUL5ZRtESXKYG8tLykjx8mOkv4tFaTk6iWC/ntnELaYbeopPWhkR0A65yMLAuPl0dU
	 Dt0oidZOEWur/pjurdN5d6x98ZwXnae5sWNWVxuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeL2BaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728154AbeL2BaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:02 -0500
Subject: Re: [GIT PULL] y2038: more syscalls and cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047002;
        bh=Nl1gQ6r269k1jxuQ8HsARw8GpxfK2MxDTgxLAwonOss=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AophuH4wleASBbFYaUlO3sIjiRuh7jHIIqpn2cojCG89hgHvuXHkdjVzYnndizx44
         Wt7SDXBMzW9EoX98PR0AhziO0H5Q3M6BECjlQSAINfnJ0CtM+uEou5NyW6NccVS1RA
         j2yR6Pzxp7sGAR/x/E+uxvxcIprjlVIkHCdnPtW8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1t0RiYcHtpwk3jwma0SvsS3NE5PAvTbb2zR4n+wkh69A@mail.gmail.com>
References: <CAK8P3a1t0RiYcHtpwk3jwma0SvsS3NE5PAvTbb2zR4n+wkh69A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1t0RiYcHtpwk3jwma0SvsS3NE5PAvTbb2zR4n+wkh69A@mail.gmail.com>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: e4b92b108c6cd6b311e4b6e85d6a87a34599a6e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b12a9124eeb71d766a3e3eb594ebbb3fefc66902
Message-Id: <20181229013002.17208.82563.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:02 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 00:09:43 +0100:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b12a9124eeb71d766a3e3eb594ebbb3fefc66902

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
