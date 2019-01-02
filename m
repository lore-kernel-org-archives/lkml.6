Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D9C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E924218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546456205;
	bh=OPTX946he2OdtrktKkgEcIcP+4aU4qPZt3tvFaoNHRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Wn8P0X0JLB6skW/Vc0mHW3aiCoiZBsjxiq1AwNHJVPNehsqU0noDSSmp4U8C3LRQZ
	 migvaDoEotkPqugtqFq2C0kDiLpg9BM8VWDy3h8qlNRo62glR5Mhbx3v+cWs0Eb82q
	 5fP7vBohQlK4kBpnV2/KPiFjJ9uzQ+qZ71JZz+3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfABTKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfABTKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:10:04 -0500
Subject: Re: [GIT PULL] security: integrity updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546456203;
        bh=OPTX946he2OdtrktKkgEcIcP+4aU4qPZt3tvFaoNHRI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l2O3JEEajsNvBbxSjH9ElTfNvqLOBnp3w8NmbItM6SYSTX7ptFXP0Hae+QtA0L5Zm
         69TTwxm7lOwlsyshtVccomMswSt1/K1ptOtKuqtqOAx4N5VvlEZ9P4AGX108pJzBET
         TzzQQJipgQqr3pYhKapYd1hjXxwd8jlophEyMi64=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1812311509450.1435@namei.org>
References: <alpine.LRH.2.21.1812311509450.1435@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1812311509450.1435@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-integrity
X-PR-Tracked-Commit-Id: c7f7e58fcbf33589f11bfde0506e076a00627e59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f218a29c25ad8abdb961435d6b8139f462061364
Message-Id: <20190102191003.32204.22067.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 19:10:03 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 15:11:33 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f218a29c25ad8abdb961435d6b8139f462061364

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
