Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2560C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687C42175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549580709;
	bh=EKcqZyaes9pFe7r3DhncW1ivIyAd22dLWx+whOqA9g0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sfq8juATCbwTl8GfdTanzmawNrY+rtCvunUyZ21v7QpNU4de0y1ukfd5BzYqTPGlx
	 30JpJSatUUygkPsPVW45mDWuzWacKkC+qk+3M1s6R8r29s0ZxVrwtTIfK3zJU/Ej4R
	 AmwnY51U+v0kIIRZMBDERcKVGGJdIjuozUs/mWao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBGXFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfBGXFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:05:04 -0500
Subject: Re: [GIT PULL] KVM fixes for Linux 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549580704;
        bh=EKcqZyaes9pFe7r3DhncW1ivIyAd22dLWx+whOqA9g0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CTz5n46fvSQjHz7BBuFd8HfyeNA9BEMonDv/hf+HXLRcl7YxkOV7sx0TSuZVhKjrK
         XFk1kjJIX5h42I8OVGRMEe5my4zt3ALzVKW3qPpdIUumKBJWMfll8SJk7lPeneUBbl
         j+Da7jS3DwSHa2R4EJlTqiZiRpCEtX8yk6+CSP6Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1549563153-6746-1-git-send-email-pbonzini@redhat.com>
References: <1549563153-6746-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1549563153-6746-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: ecec76885bcfe3294685dc363fd1273df0d5d65f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e303a067ceede918fbf90ff3dc8affbb98bad4e8
Message-Id: <154958070408.8830.1381675554347342337.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 23:05:04 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Feb 2019 19:12:33 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e303a067ceede918fbf90ff3dc8affbb98bad4e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
