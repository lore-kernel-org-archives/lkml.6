Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74066C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B7206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322216;
	bh=ZMkT6m36QhnVZvTHZ3PwX8OmTGX9YkOkK+wYEDQtHK0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GwtJn9H1dM1ouzQve3XGeZXxAXDV+to3IpTFhq/UZgJrKQGfrjEAoByGIxDCQgYG4
	 Q9VTCrUDgA2ys64P+n9NPyuEau199yOA0uQOjE+yj9k2r2wndreBKMdUVo+nlwgcM2
	 zmB8qBs6K8suumKKleuco8TTDDzSXL7SKHEQiWSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeLTQKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbeLTQKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:03 -0500
Subject: Re: [git pull] m68k fixes for 4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545322203;
        bh=ZMkT6m36QhnVZvTHZ3PwX8OmTGX9YkOkK+wYEDQtHK0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UFAVEfiJxBi7pSl2DgmJz+urCF4W3e4ylh/CnNbw8JqVZsaFYAPpSHUFG5KD1q7bU
         pl2uoUrMfc6qaOoK8T2LuEAFahqeUHwcFz/cNrHA79MakyyVpaC30two30UtWLe3Zn
         FnQ8mL4WHPhXH9WrOrYb9ZyIKLpapwxRdyEKzP2M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220151647.26469-1-geert@linux-m68k.org>
References: <20181220151647.26469-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220151647.26469-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v4.20-tag2
X-PR-Tracked-Commit-Id: bed1369f51901b17108a4bb4f7210aab183bea42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d51b4b1d3f2db0d6d144175e31a84e472fbd99a
Message-Id: <20181220161003.12746.34350.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 16:10:03 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 16:16:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v4.20-tag2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d51b4b1d3f2db0d6d144175e31a84e472fbd99a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
