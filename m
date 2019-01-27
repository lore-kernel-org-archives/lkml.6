Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F0EC282CB
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B4B2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548609918;
	bh=572MUlVY2gAmgv1I+IwJS05ywa1uY9zKD/iHX4JmM4s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xkSZa00S8nYmTIPt/xgSIQgBjuCI8/uioMfADMJpUVg2aRwlSDWbhfkwCYZuGm/Zp
	 ZZiN7eseS25bJXj7b6dyniylAP0REpy+ZLEwyGs0LqwEObvCJ5dufL/fus3D/CEKY5
	 PjGD9pRzHb/N+UCYM50iuQaIO8gFzKbdhKiSrBtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfA0RZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:25:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfA0RZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:25:05 -0500
Subject: Re: [GIT PULL] KVM fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548609905;
        bh=572MUlVY2gAmgv1I+IwJS05ywa1uY9zKD/iHX4JmM4s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i8IU95ha6LDMjMeEJ6tDOcQ0pqfoZVoSKbJ6QK+vA3/zEkYeECDT9i+pxUyF2yX64
         ZeSPem9SNm48cKodO0QJ0CmD7h/eXvDaXUVCm23J3EYN9CuilogSwOjrqO+3+OcaPR
         3zuIIT4D8aq1OFGITmkfnx78J/PVATgWtQBu7D7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1548492041-46410-1-git-send-email-pbonzini@redhat.com>
References: <1548492041-46410-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1548492041-46410-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: b2869f28e1476cd705bb28c58fd01b0bd661bb99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fc7f56db7a7c467e46a5d2e2a009d2f337e0338
Message-Id: <154860990498.19009.3506420851195943918.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 17:25:04 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Jan 2019 09:40:41 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fc7f56db7a7c467e46a5d2e2a009d2f337e0338

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
