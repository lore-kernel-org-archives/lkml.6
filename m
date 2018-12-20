Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACDFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A50120989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545274210;
	bh=UgyHOboadKliCyzKFkZCbVC2t/DIuu9YdvmlTKDX5Xc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=S7GTO7ERVS6ravMxj80jh9Yl4fJydEI3yWiBA8/NHOdo+R+PwcNmcejzPGXn18ADl
	 nBFeCJoN9vwv3Ywx6QIrcrFjHcoFYS5qsNbzEDioLMVQxQylWKTCVZyjP21zOnUWa3
	 Y+UjGKusQCNKgsKGujFE6m2WYLfIhR1GsvOtce9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeLTCuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbeLTCuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:50:02 -0500
Subject: Re: [PULL] virtio fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545274202;
        bh=UgyHOboadKliCyzKFkZCbVC2t/DIuu9YdvmlTKDX5Xc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=juyitBOHCvs6nx+XbaVhAaEB9GI4TwgCgqhVUd501yqKuET2ov7IdShS1ObyOw7Rj
         juyE4/5neZofOiVL1/O8Y7Cc4U7nFd/dlgqVVJ+ry5HUNs0f6ryTjRIa6lTKh1kLwD
         GyItgFuVisRgRvZ8Zaqho6zQ01eBUFn4OWM3TZNk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181219182958-mutt-send-email-mst@kernel.org>
References: <20181219182958-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181219182958-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: c5c08bed843c2b2c048c16d1296d7631d7c1620e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab63e725b49c80f941446327d79ba5b68593bf5a
Message-Id: <20181220025002.15095.33661.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 02:50:02 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Dec 2018 18:29:58 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab63e725b49c80f941446327d79ba5b68593bf5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
