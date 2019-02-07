Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F4AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC91E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549527019;
	bh=YZp5j7NcO6TIgrN/26hsf/EJcqoGLDCSBqRqUYLZj3k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XVOwy1AuowhHLRqrhBNkyxmtTiFuFcKTsrZtpi+bbb0z43os4zk4kKhQgWTzf6Wtg
	 QonogjF3+3QF2T7BTIEhHXwQ9nWo7BNlC9bemIsH87NtpnigYic0MtXP2tUbQhUuCQ
	 o3trIyVfOKEdegGE0H1hmiUWT6LPcWZ+2pEwe7kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBGIKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfBGIKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:10:05 -0500
Subject: Re: [PULL] virtio: fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549527005;
        bh=YZp5j7NcO6TIgrN/26hsf/EJcqoGLDCSBqRqUYLZj3k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NvdtPsaY8d5Mvp3DxTO6n2LGpvk1FhxrrAKqNJq2zA3jN/kteIeNFAo24XLPwZbFj
         xGlHEa81tDkWyziBL9D7chNosoaHqfyySL+DpC/gffSYMZf4/vC0bU2MarhRphbtwJ
         Ny1FOJwg/+NWFHcL1dzjyirkZMf40jcb7Ftz+NfY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190206143256-mutt-send-email-mst@kernel.org>
References: <20190206143256-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190206143256-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 9c0644ee4aa8792f1e60a2b014b4710faaddafeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0314565da2b95e73feab484467ad171fcce6dff
Message-Id: <154952700528.18479.7285608057704274288.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 08:10:05 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, tiwei.bie@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Feb 2019 14:32:56 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0314565da2b95e73feab484467ad171fcce6dff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
