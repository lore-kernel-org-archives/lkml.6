Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3821C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868622232D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546719615;
	bh=NTz6FmCD1/9yD7gRjF9QfOauKC+nALxgNOzOeFDfVS4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pr0qnpWCP3jTDyOfno+zvfyc8j2bk9V5Q5MCJ+JJpIy3DY85NXaIyAZYjlX+zUx7k
	 3AhHKbg2OUg9karvJcuOcd/faprR7uW5xtijplrEdEd6RY6lIlUN/+KQToi4g2MtH8
	 Qd07B64XpDTD2/LxcP7J633D1JYLA8H8bcqR6D3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAEUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfAEUUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:20:06 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.21-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546719603;
        bh=NTz6FmCD1/9yD7gRjF9QfOauKC+nALxgNOzOeFDfVS4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lpYBgENwGTXDud0Cd2J/8CnrpfYhnxphGLzfEyLtl1gI5diIwcyBXRAQltnVRu3ar
         Q+NDT+PRGntNiZw/gOTyK1XDWg7CW4Iirsy7/7XIdUWr0sGi1W1SI6VxEXBoXlAzPz
         WMYhlAsBgFvdADpZForAL4tx0XB5lVwgVDIAoPPs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ftu8y3vw.fsf@concordia.ellerman.id.au>
References: <87ftu8y3vw.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ftu8y3vw.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-4.21-2
X-PR-Tracked-Commit-Id: 074400a7be61250d9f0ccec07d5c35ffec4d8d22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1c2f8857c5aa6c92aa903bc06437503422e5925
Message-Id: <20190105202003.12651.6172.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 20:20:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, chunkeey@gmail.com,
        diana.craciun@nxp.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, malat@debian.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 05 Jan 2019 00:00:03 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.21-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1c2f8857c5aa6c92aa903bc06437503422e5925

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
