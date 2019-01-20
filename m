Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BE6C26661
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B9F2084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548009608;
	bh=kuqUskY3DoPnu4p7KbQMpdBX/vPmBqFs6E7qkIu1dME=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qNQup2Kz6tZ//MHbIaX/bLvidnQ85eB8rE6Z4iPo9Bp8bYxja24pdWdbykMN1NR/X
	 afA/+k7VF7x2gyZbBMkpLNAiGm64GNyok21qQ3uZvyBCrB22co/ll0X/DhZ7VBIE94
	 jCCYXHkZOA+Oj7BsSbH5AGF5/qo4NOQSFVxfVAuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfATSkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfATSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:40:03 -0500
Subject: Re: [PULL] virtio, vhost: fixes and cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548009602;
        bh=kuqUskY3DoPnu4p7KbQMpdBX/vPmBqFs6E7qkIu1dME=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jZY73Ol0lMIvbzwHZqY8NuDDFrmwz6EfeZ3NGtG0X0OcI0HXtLglYPA0Zb+mW4aJI
         qaAn+5vqqgwTW58nAW17LhusI8BH4RO71zV3YyNJVOAQ+3Bt4w67OoDp+3jbouosOT
         WpPckaNnTrj/yFwwYV1ZY2xeFQxx36PxkG9i0n/U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190120111420-mutt-send-email-mst@kernel.org>
References: <20190120111420-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120111420-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 8e5dadfe76cf2862ebf3e4f22adef29982df7766
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb617b9b4519b0cef939c9c8e9c41470749f0d51
Message-Id: <154800960287.15983.14811542062466778394.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jan 2019 18:40:02 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bijan.mottahedeh@oracle.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mst@redhat.com, ptikhomirov@virtuozzo.com,
        wei.w.wang@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 11:14:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb617b9b4519b0cef939c9c8e9c41470749f0d51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
