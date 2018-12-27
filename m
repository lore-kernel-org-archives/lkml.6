Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5DDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D384021908
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948356;
	bh=go5URAXFf2ZEMbue32tUscL1vPDN9coKr9DIlSAUjew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lN1H+ZqyFRCPyaqaCqOwrA7ydMqBIqN9R4ZMFOdmFpgOiQPeqLYhNWfpDLsAtsUXW
	 BN8dDw+iu+WiHuZ+lOF+ldvoqLB1fvpFYfVHZhVTLlmn0liyCLkLIAiLKdKPJVa69B
	 DD1slV8Uu0NDKhZQjngXQDSw6SWaWjpsrFIsSW4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbeL0WFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731502AbeL0WFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:04 -0500
Subject: Re: [GIT PULL] Audit patches for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948304;
        bh=go5URAXFf2ZEMbue32tUscL1vPDN9coKr9DIlSAUjew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gRobahn8M8jmVt4cB3QKKP9OfFXoJvrvkPhGb/RIfdL1eOjlwkkk/chALOm6zYEeD
         G6aa4rsD1W+IDnrH7P2k8pfTcvxDNBAF3XqrvMnWtBDt9suRWYm91PYIDfwVcj4vc6
         7Cm+fprRxODFz0jRj39qPXlw8ibgu6Vnj08APkKk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTBp2XO4nDuJTe+tkALokHY+Ly-1fkD_Wubsci+vOp=Sg@mail.gmail.com>
References: <CAHC9VhTBp2XO4nDuJTe+tkALokHY+Ly-1fkD_Wubsci+vOp=Sg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTBp2XO4nDuJTe+tkALokHY+Ly-1fkD_Wubsci+vOp=Sg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20181224
X-PR-Tracked-Commit-Id: d406db524c32ca35bd85cada28a547fff3115715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 047ce6d380e8e66cfb6cbc22e873af89dd0c216c
Message-Id: <20181227220504.24636.48734.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:04 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 11:26:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20181224

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/047ce6d380e8e66cfb6cbc22e873af89dd0c216c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
