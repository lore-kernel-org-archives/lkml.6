Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E8AC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970A32089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548108013;
	bh=gysH0vObyoQeCBPejdV0ZE/imP8En1ypYG1dGi0qnHM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KJ2LSF4AB1Ml9eWB7sWFexCOP4sMdWvVjzyJyFSu9lLCjIqCCIWDmn4PDXb3ak4cs
	 y/PVZb/VTI1PPsRTWIKLBW6hW1SoSpBwVcyoVFR8QURJELsXGjFXwiDzvZbnc1DIa1
	 8GC+WB126w6m/ZD/fKbRDMnXnqJPF5VVMR/ZLFN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfAUWAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfAUWAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:00:05 -0500
Subject: Re: [GIT PULL] pstore fixes for v5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548108004;
        bh=gysH0vObyoQeCBPejdV0ZE/imP8En1ypYG1dGi0qnHM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n1/7VjoZHTfSa0S5kULpP9Mu6NrQdRxJ1dZlN8/z277H9VMwvlEEjZoXbfX4rtLGz
         jTsgNgvJX4amKWp3Tl0xWTzu++KMsgayj+pUmAVM7TnsPmhxeaLApYqlrFKiutvaXx
         k7M2XX6AxMhoaGMffpVBrTJ5O/eExyy7l8Xd60OU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190120230608.GA20111@beast>
References: <20190120230608.GA20111@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120230608.GA20111@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.0-rc4
X-PR-Tracked-Commit-Id: 5631e8576a3caf606cdc375f97425a67983b420c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e556ba3b673166e28d5489b80c11e0605a86403
Message-Id: <154810800469.17432.8877255202707005539.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Jan 2019 22:00:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Yue Hu <huyue2@yulong.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 15:06:08 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e556ba3b673166e28d5489b80c11e0605a86403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
