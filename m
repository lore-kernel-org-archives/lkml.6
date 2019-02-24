Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D42C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 18:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F8E20661
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551032118;
	bh=aqzZ/gtdSg/64v6hosRhqHXdDzaGpgHY2k5reixdpp4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=modQIFzZd6nrhHc/CmTF1QtOmN0KuhwGoFMqLMPdSYzhomhL4oozxVmk/LIrQeZLY
	 P3L1+8AAU6J2jGZ4/Rs/TRGBGA+kKLGxvdDj7RUcuqjKNARo0jSde+CyhUrHAFS554
	 JIPenNUxPQWqVhnX9CwBGKckzQKdfg5ePhEJ74rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfBXSPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 13:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfBXSPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 13:15:03 -0500
Subject: Re: [GIT PULL] KVM fixes for 5.0-rc8 or final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551032102;
        bh=aqzZ/gtdSg/64v6hosRhqHXdDzaGpgHY2k5reixdpp4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lmPA4DLBVlylfiNB8wvpZpkMS2i9YuHRIRze+wm9dbKZj9APr9LOmpDjifK5DG3s+
         HApKMESYOuwnTJqpFsrDzgngY4cE6VOdt49xZAH39YGUC2Q3fZ1RPqP3nVAsK5nI1E
         sKC0q0JOh3QvZJuo3R8LhlZT/2vXfRlt2czu4tpI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1550996613-8729-1-git-send-email-pbonzini@redhat.com>
References: <1550996613-8729-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1550996613-8729-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: de3ccd26fafc707b09792d9b633c8b5b48865315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3619a482e15d98e1d2eb6b32952e753077e7545
Message-Id: <155103210244.9905.2354450083908684501.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Feb 2019 18:15:02 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Feb 2019 09:23:33 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3619a482e15d98e1d2eb6b32952e753077e7545

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
