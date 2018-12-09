Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE88AC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F42820672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544381410;
	bh=zl+26kE9O/qHda1VWjxqzDEs41SQ+wg028cAMZKu0CI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M95AXYUaXTpOBpgt3FCFbpRvDmQ4f1hmfo9ba3u+F4DAzTOlCa7f2IwpI2+xmSgxQ
	 fhSLfDcddSaAK++C/8p2lst7v3HJPFK0rC4euoemqqP2B0aaXvS9G1Q0pSY/p86jC+
	 BXYPsIUSV/VoVZkDpH0yoxyey9cGW6tbuumChQ3Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F42820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeLISuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeLISuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:50:03 -0500
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544381402;
        bh=zl+26kE9O/qHda1VWjxqzDEs41SQ+wg028cAMZKu0CI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GcSOwISbMBqZ29d4dgi5L17wF8msQ1aPzcBPbMHU3XlnWIyghJHO7aGXXa1ChttVU
         6WbVOcvGyTPHJ2xVs99eAIfJwU93wFoQh93VvM89EeLBP7+jrEUeVEWC8n1EexPTWh
         eQ12chMYKm7ac7AValYX6FdpqcT1hT/ib5n15wWY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181209111737.GA9811@kroah.com>
References: <20181209111737.GA9811@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181209111737.GA9811@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-4.20-rc6
X-PR-Tracked-Commit-Id: 87e4a5405f087427fbf8b437d2796283dce2b38f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47dcb0802d28813e4600192ce27475681f96f230
Message-Id: <20181209185002.3376.69494.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 18:50:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 12:17:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47dcb0802d28813e4600192ce27475681f96f230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
