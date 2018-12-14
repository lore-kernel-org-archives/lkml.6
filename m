Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73183206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809515;
	bh=MU3ID/F4lLc8gjYAIU9APjtwOjcyFl7w353aT43JhEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b0dQpSk4np1upxDbIYTWuQgTB8aKLJFZfHzHg7S7riqGzqJ5OjPN1jk+o1rAqfv62
	 ffxT0EL+zQPcVqTYZbYctz72mnyzvjkp3vy5k6unIlce7ssysUe2awtOP88DXWnrry
	 IwXFXk8Ne5b2aDXODHXTzddZAto0ekwz5Q948r80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeLNRpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbeLNRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:45:01 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809502;
        bh=MU3ID/F4lLc8gjYAIU9APjtwOjcyFl7w353aT43JhEY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EB4lIJCTcopIIcp64FDZ00XbIbzIQXocfCZIsucJdJBnCblQBUbX9E5NUtzew2owC
         jUuMLWkEQcWQhLgwl0YyJJiTfeTHxyY71PJ0u1/a0+GjcgziUsoVya2eXoDYZWChKp
         ILqFsVNysBUsUXsG1oxhiFrMhDuhSgH1Tbs0gqJQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ftv0uqus.fsf@concordia.ellerman.id.au>
References: <87ftv0uqus.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ftv0uqus.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-4.20-4
X-PR-Tracked-Commit-Id: a225f1567405558fb5410e9b2b90805819df1c67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4645453cefcebdff9db26f02cf325607357295c4
Message-Id: <20181214174502.32554.28644.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 17:45:02 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        benh@kernel.crashing.org, lineprinter@altlinux.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        oohall@gmail.com, paulus@ozlabs.org, radu.rendec@gmail.com,
        sandipan@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Dec 2018 01:26:19 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.20-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4645453cefcebdff9db26f02cf325607357295c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
