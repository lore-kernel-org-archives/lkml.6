Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52961C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177F22146F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545274204;
	bh=8RRYEJcJFRQh2Godl2zgZQqNCrBEoVvBgkCfwLFKVaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2Qz2VRopWHEql4Vb+UGrtt9IgXj+PAHSxgfqQLrp8w+ZCJqcZ/rABoW0/w7RVXpjz
	 1u5rycdQaSItnHmkPcW+zNo+PhhiAdotCwCpwf2ID3XxYAF08uDXjIrQCVyT2ewv/5
	 R1vRMC74wCbprbTe/LiyVpmuassnykBaATqiJskE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeLTCuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbeLTCuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:50:02 -0500
Subject: Re: [GIT PULL] KVM fixes for 4.20-rc8 (or final)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545274202;
        bh=8RRYEJcJFRQh2Godl2zgZQqNCrBEoVvBgkCfwLFKVaY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZNv4Ca1LB84YprwdMlLLyrX52yEqlLfy9B63Wxy186OvrpM854yZEZguRFHgiytRG
         3Z2fAKQ1Bq06FM0/g6Xv3wQ+pQZj4mruw3Wr2Wa9oabbFi+QWCukKChm5V5abS6GP1
         iL5cYpAC4GKFwfACk1K5UqE0NpljpTgBfN9yvDHo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1545230713-12173-1-git-send-email-pbonzini@redhat.com>
References: <1545230713-12173-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1545230713-12173-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 0e1b869fff60c81b510c2d00602d778f8f59dd9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe112793600bb14cfd519ed148ca2f252d7b14bc
Message-Id: <20181220025001.15095.51728.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 02:50:01 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Dec 2018 15:45:13 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe112793600bb14cfd519ed148ca2f252d7b14bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
