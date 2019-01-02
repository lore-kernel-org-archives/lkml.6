Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D38DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34024218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546456208;
	bh=vxcNR6f9g1S1HltiVBujdNz8MafThx6+pKzqwc4L/9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XfV+oyJePtj8a42ZLL6uAdTHwVHIBezVpvuHLg0jVoN4jmmY0sEUYOSKIUAT0nxXu
	 XHQS7OwAaRlfYHI6pifQKEdZB3/HzdSHDxqSEgnVN+rPZasvJFGwTAhFUxZlRQDi/a
	 eI/iUpnaKmjtyIUB6eM8lqxU0lxgffpjHAemoxR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfABTKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:32940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfABTKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:10:04 -0500
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546456203;
        bh=vxcNR6f9g1S1HltiVBujdNz8MafThx6+pKzqwc4L/9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k17nlqhv5V9BBE1nISp+yDU6ez7WaJyp+nbu/wjYBl7S8G5nVC+QBgaJpAaMmC4CP
         kCJIYRrouJ3hqg16zGaXaJR2M/Km5P/RYy2F2FR4+sMAxqUaOmz2f4KDOVajKbJ2Fq
         V6sdLtRN5JjGZ+HYsZQGF9/FOG3F23DZ61PjOa4A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1812311511360.1435@namei.org>
References: <alpine.LRH.2.21.1812311511360.1435@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1812311511360.1435@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-seccomp
X-PR-Tracked-Commit-Id: 55b8cbe470d103b44104c64dbf89e5cad525d4e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9a7fa67b4bfe6ce93ee9aab23ae2e7ca0763e84
Message-Id: <20190102191003.32204.39592.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 19:10:03 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 15:15:08 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9a7fa67b4bfe6ce93ee9aab23ae2e7ca0763e84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
