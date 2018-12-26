Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A143C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496E0214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545855313;
	bh=CflrujVFMY3ycFzVbfksyE7U1Lk7n+PTHFZll1XeUjU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2Z1ueDFY8ILqGp3YDOujH1Yd+pyCD343vFaw7FJpBvslGsZSBrywlluw/rkD6RDle
	 n+eD6Q2FPi3bGejUwE1fx7FiyCfSzomZbN+D3/n419ZcICXryXai6Kp8J//MF+Lwkc
	 xdsqkAHw7WXFKvRYhYENyqeOeHF7pPoO9fYADK2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeLZUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbeLZUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:15:03 -0500
Subject: Re: [GIT PULL] Changes for KVM 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545855302;
        bh=CflrujVFMY3ycFzVbfksyE7U1Lk7n+PTHFZll1XeUjU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U40J1AmQLunRKpJ/qivxbui0lBCVrgP4j3RBA8USku/7ySTW8PMR/7YpJIZutYulB
         9q6SyZjLmEsyisu2hWqadmQp4TbMUrxdG9pyr6Hpv6Ql4yiiYEzG9hKhE1u/uVK7d3
         J23Ic9aEEMr16Zi9P0L/nxImapwkxJxS360TmuGQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1545556455-53839-1-git-send-email-pbonzini@redhat.com>
References: <1545556455-53839-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1545556455-53839-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: a0aea130afebcd091d5396d13f25b9da24c9144a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42b00f122cfbfed79fc29b0b3610f3abbb1e3864
Message-Id: <20181226201502.31976.76740.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 20:15:02 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 10:14:15 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42b00f122cfbfed79fc29b0b3610f3abbb1e3864

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
