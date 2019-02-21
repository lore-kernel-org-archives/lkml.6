Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94380C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3B520818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550771404;
	bh=folJbZ2BHSiQAQIVF/19ibzJREmUWSXKjXyt8SezThg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JBKvgyA7awwudCxekM1MHbzny2l8sK6EqIrc+sRG02n9gULkPya9BxBRdKfqe+e5t
	 VK90srVLhWWKC4BTW5xxmr+99qSXCubswrpJKic+lwC8fQQIxYpYrTNfkdp1+oyWRP
	 Vownsah8EvR87in4S9+nFPg9q+i2PPQ2X3qSGyB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfBURuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBURuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:50:02 -0500
Subject: Re: [GIT PULL] Ceph fixes for 5.0-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550771402;
        bh=folJbZ2BHSiQAQIVF/19ibzJREmUWSXKjXyt8SezThg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hjbTriiB2iJHajVTxn51YUWc4w00fAehMjD+JeKJrtnvTiMMY+FiurusilW5xT4QI
         I/n0HNcIxwGJ3TiTeo47Funm2xlbeh0nMX4iP0+eqJFQ9Nki4485axZoqT3TNJ1xom
         2iT1MASarI+KpU0kNwMdLAJInAzBtkCLS4FP+0lc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190221171607.2756-1-idryomov@gmail.com>
References: <20190221171607.2756-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190221171607.2756-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.0-rc8
X-PR-Tracked-Commit-Id: 04242ff3ac0abbaa4362f97781dac268e6c3541a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a61716ff2ab23eddd1f7a05a075a374e4d0c3d4
Message-Id: <155077140203.20308.15307478783136609229.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Feb 2019 17:50:02 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Feb 2019 18:16:07 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a61716ff2ab23eddd1f7a05a075a374e4d0c3d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
