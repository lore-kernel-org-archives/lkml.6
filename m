Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF511C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1742147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549528806;
	bh=Ij43DWA8rdI55Ijzkt1Th0EmxxfoJUVooimWxX8fJ1g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RBGVKOcTAhZ4DghAKuooxleWDwfmoiUeEFMthes1c2xi7JoN3lis1KD7v9lTiN+Db
	 5NFlr6DdgGJTogoTbS1gL7+e9U631gYeXJ8FxyC0ieOX+k/He8vqQu8UVdGJiEwR0z
	 nxJwCifg5EcHG9selDwx4H4DrnF84DLR2Sgu/yM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBGIkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfBGIkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:40:04 -0500
Subject: Re: [GIT PULL] sound fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549528804;
        bh=Ij43DWA8rdI55Ijzkt1Th0EmxxfoJUVooimWxX8fJ1g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sqZcidsR7/QC98WmbImFBWjoUDVF8xw7sm5i9Kodx1rngSVduV/f9eBGLRig5T5Yr
         qHSSGLgmqKIrjKi+gdJz0lWQwTp61b1miZlU0CwHhs0Z58nUWTK+Bi2MSE/l9KQo4x
         TKzK9f4t61yXOf8otURAlP3W7Dr8eD679Kg5tfoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5htvhg9f4p.wl-tiwai@suse.de>
References: <s5htvhg9f4p.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5htvhg9f4p.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.0-rc6
X-PR-Tracked-Commit-Id: c97617a81a7616d49bc3700959e08c6c6f447093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f64e3a4de749575e4705fa53dd49aed28f92623
Message-Id: <154952880397.9255.9774096855311422469.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 08:40:03 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 07 Feb 2019 09:28:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f64e3a4de749575e4705fa53dd49aed28f92623

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
