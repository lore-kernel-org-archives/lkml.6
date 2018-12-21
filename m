Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B608AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8295D21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545420639;
	bh=eAsfrio+ZfoZ/11yqKsbIynf1LEMeNxx8Bqy95Wmxqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RAupyY/qOD6GPmrnsY1QJ+55oPK499yjMHOjRWfKW5/vJarIGmozADLVyU0/dzmFU
	 s9QooAgexwSmh2YJ+IjUtfQ8wzK8nwOJEyuCEU9Ndx4Dz+qGTOzkc462GtM00Cu57g
	 fvukERKbIRgam9jFVnbQZ9R3DnxaaxbAUUdNBjMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404613AbeLUTai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404545AbeLUTaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:30:04 -0500
Subject: Re: [GIT PULL] Last straggler for 4.20-rc8 or final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545420603;
        bh=eAsfrio+ZfoZ/11yqKsbIynf1LEMeNxx8Bqy95Wmxqw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HceU/C2lFevp635kMfcIzGvYr8nxQmQVNlc3t6UnmanTyOV/l2ZZtjxyZDWlGbif2
         6fR+ry6jY6M00xLeRKZIetDlPqSe7BZBwZw2CuVoKUbz7FIFtIua4KG0XiaA2kd5du
         AeaxCspP8z/1R4yWO+QF56JG8wM2zydhIL5I3kQA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
References: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 3cf85f9f6bd7b172122865432b4c6f0ec844e22a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5092adb2272e1760030a889aa4a3e9cf1d5f74b5
Message-Id: <20181221193003.15695.2764.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 21 Dec 2018 19:30:03 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 14:09:02 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5092adb2272e1760030a889aa4a3e9cf1d5f74b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
