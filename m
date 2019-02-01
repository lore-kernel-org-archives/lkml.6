Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FDBC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F302A218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549046707;
	bh=JNBzyd6e+ityOzgHT6btfmG2UbkzpuFkl2b08rfJCRg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GqD+C9pEniGFl/RCDS1fhxLz3aJxktOmS4vOIESuZWZVF1ImI84akb3TF0/+ak+BM
	 fS1tTIDfdTBuh1AuKUc1WycDRvBCiRXhe9+gkiFxDZ6PIDYBP9sleAR4ZEN0LFYrFy
	 cWJ8gfIqao6jv7wxwdgZIVQsMDttNpGpTa7MXgdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfBASpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBASpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:45:04 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549046704;
        bh=JNBzyd6e+ityOzgHT6btfmG2UbkzpuFkl2b08rfJCRg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=efN8Vtr2IFbNn1xC28jEI0gIkflWpy8X8shSVa8IlKLD2GZBBI5ZvdGhBCsV6UTcn
         ko1N6P66hOsoUKQIf21EOFYRxVNFITDuxp/OF43Mp5AFS4V9UN4Wy58u6qgcrDcHrV
         ebGnG0SvXt43mT4Xe2GeZwxEsURmZycxswEmbDF0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190201174106.GA25156@ziepe.ca>
References: <20190201174106.GA25156@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190201174106.GA25156@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 7b21b69ab203136fdc153c7707fa6c409e523c2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5eeb63359b1ec4914d9898e24aa357ff930e6ee1
Message-Id: <154904670398.9551.325641010521027240.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Feb 2019 18:45:03 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Feb 2019 17:41:11 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5eeb63359b1ec4914d9898e24aa357ff930e6ee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
