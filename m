Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7E4C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E2F2133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546727550;
	bh=fxc1VFZ6slQoJAF2QblXU7Z3EvrDDKBdWZh/CgXWU7A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IIerRGaEHQBrI+pRX/B3gBEtKC7GG6Q8uPaMlSgQ7X4u7Np6qXD0rN03dnDMpvhFE
	 tTH3vTzho85acN52fUOPY9C1CcZK/Jh8oFHhYcYzh7VIG5Or37CtGtHHIqUy110kCB
	 fXqYtUQpRHvId81nwlKbohJ+fjzaWDdwhERfilj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfAEWc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfAEWcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:32:15 -0500
Subject: Re: [GIT PULL] xfs: more updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546726502;
        bh=fxc1VFZ6slQoJAF2QblXU7Z3EvrDDKBdWZh/CgXWU7A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lEFWRbFjW7KOcTCD5s9AbeGGjiB2QooW8coFWgwWP0iKOnwaf4rrSotDn0T8N5O2P
         NtUgssFZSw1gI1ZalCncz9Oz7IypzKJNAbNBVle0+Tmb7PuetMtM4Q8AlBepcK4S1O
         A2D7CewPudki+MuEDrvOiaoEmQokC0gVXRdE/RT4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104010644.GC21010@magnolia>
References: <20190104010644.GC21010@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104010644.GC21010@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-4.21-merge-3
X-PR-Tracked-Commit-Id: 90be9b86da9039fe6cf2880dc16fd0b0899603a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acda9efa8c62d4baa0395c83bda43f252137e302
Message-Id: <20190105221502.6651.3178.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 22:15:02 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Jan 2019 17:06:44 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.21-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acda9efa8c62d4baa0395c83bda43f252137e302

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
