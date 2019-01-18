Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3851CC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2FE20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547834714;
	bh=Z+7hSqDd3JLBui8tmnwRuYS0OYlDwP6eYlEi8l+zqBo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N4rwA43ymeJLa6qzQ08cH5XmhoemcHfChS3QYQ1fOXzxv+3Jjky2oK9ULz548hVxT
	 xrBeF06BpohJclDEz0AUWIyYdDKpqBeqFbCxCDWXSNR5qrXJMOSMLSGiqgVuqqsj+e
	 ShC8yow0M3YJtAqTUBcF2qVCrOgayuHYErlYolbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfARSFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfARSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:05:04 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547834703;
        bh=Z+7hSqDd3JLBui8tmnwRuYS0OYlDwP6eYlEi8l+zqBo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U9lJra8SWsHtqt93DyrgnTi2C8sJ6cUhLiutFjVYBVTsuwpe5ZL8pI+rm3mHGVV0l
         C9lUCfZDtGo85G3zSRJir+8zK5ydMZnTdZio4MrHTfFx+LFHcoO8ZdfU8/bSSrWkNA
         y1n1HJloAwb1FPIXCF7Rk6EVILIAWFzjeXxyseok=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875zum3zje.fsf@concordia.ellerman.id.au>
References: <875zum3zje.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875zum3zje.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.0-3
X-PR-Tracked-Commit-Id: 7bea7ac0ca0121798f3618d16201ca4dc4e67a00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5b709804ed7d36c45b5efa170d9e3ea8c29b865
Message-Id: <154783470393.23992.17025385605395029072.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 18:05:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jason@zx2c4.com, christophe.leroy@c-s.fr, dan.carpenter@oracle.com,
        fbarrat@linux.ibm.com, leitao@debian.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 23:45:09 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5b709804ed7d36c45b5efa170d9e3ea8c29b865

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
