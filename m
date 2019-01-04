Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5BFC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB762184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546575610;
	bh=FK9iL4a4UPNxi03J+KCDYHYJ1lrIqWm5EapifALBziI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e76PwvlW63WyAJWbEAegsPqKNiDNZFrQqWLKFWBBCMu9Qs6gmZBzPyOqypSyiV3NQ
	 wViokSufpVtXTdMAoJo81tgBbiA189IVkcVAIHI1EKtHwJ8p2PBDJNLRJojlZDVFoO
	 yjVTjakC3wQbh+h8n6Z74G9W4a6YIurfP14CyopI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfADEUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfADEUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:20:03 -0500
Subject: Re: [GIT PULL] File locking bugfix for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546575603;
        bh=FK9iL4a4UPNxi03J+KCDYHYJ1lrIqWm5EapifALBziI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Iq2QrMUJnLITN+wrFmdo2WCkAOGrzwT9mQ8elk5kn14zHDgFkBSA4gna4xcATGU/m
         FFMi2YmDhW1vxIRviQgrQPWmuRojjJz526iq8FR6heFuZ3pusXixKYKCJh5wrxm0/F
         SpZKM0AjNdzz8hhnkq/v/N5gSAvaeRhafIGH1QkI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ce790e2af03fadddc6ede9de94a59c72d13cf591.camel@kernel.org>
References: <ce790e2af03fadddc6ede9de94a59c72d13cf591.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ce790e2af03fadddc6ede9de94a59c72d13cf591.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 tags/locks-v4.21-2
X-PR-Tracked-Commit-Id: bf77ae4c98d721a9aae3840970d46669a78e034a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 135143b2cac43d2a1ec73b53033b9473fbbcce6d
Message-Id: <20190104042003.16893.8319.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 04 Jan 2019 04:20:03 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Neil Brown <neilb@suse.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 03 Jan 2019 09:08:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v4.21-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/135143b2cac43d2a1ec73b53033b9473fbbcce6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
