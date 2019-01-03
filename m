Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C566C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6A2204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484710;
	bh=KU/xKgY6WMyQQJShUKlQpNlSeDLwGoAuQ//hVXVXEFk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=11OH9a2oMIUX8eA9bo1lapbFltLyDrzeUKdagloWXOzPZZ+1kq5WHfz1sspQsQCUc
	 Rbnk1mH2/tuC/N3RTVtJKqobYPFjTOhngReyBDi+bK5H9thqF8WjulxHmDiOuMHaWb
	 qz8diib1dJWHBP23Q5h3oS1FDp8bYMiuWkFz+esI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfACDFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfACDFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:05 -0500
Subject: Re: [PULL] virtio, vhost: features, fixes, cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484704;
        bh=KU/xKgY6WMyQQJShUKlQpNlSeDLwGoAuQ//hVXVXEFk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ylitfz4tp2oQXdtZmCPVKjbm5eSgmUvIVrlKWHhZuFPJfi1u3dzdecdPzm/j96C5n
         r2ouBHzZxDeD9dclT+S48H5HlNjgQIHXW6qHrd3onK5OeQvk8jA2cDlI0PzOPY+lQp
         opecJ7LXLfXlfclMOmTYu/v+z+GKYHVPmtcu1LWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190102162323-mutt-send-email-mst@kernel.org>
References: <20190102162323-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190102162323-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: a691ffb46edd7cb12a17ff0965ab59dbc95f48de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d548e65904ae43b0637d200a2441fc94e0589c30
Message-Id: <20190103030504.10885.56728.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:04 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        changpeng.liu@intel.com, dongli.zhang@oracle.com,
        dverkamp@chromium.org, jasowang@redhat.com, mst@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, wangyan122@huawei.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 16:23:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d548e65904ae43b0637d200a2441fc94e0589c30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
