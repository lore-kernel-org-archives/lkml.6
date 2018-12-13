Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1180FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3B420879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735723;
	bh=Phh0EbUZU82dfiW5Fll82cxdmtlTV3RJ2KbpkyfFxWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=i8pQ2ZNIZX1HEihDnNvQcgjBi2SE/feibLAjBA2pjAWp4+pJkik9TlDko/X91G9wf
	 7nJvE6sAQpa73VcjjCkKhDr9rqFeI51SUOHZGLCOiO9XIQYHPw5Sjo4QcZMeWsE5v7
	 kFhqAt771WUDtsmCXbWFg0OlDJEfYRQB2L6zX5i0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3B420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeLMVPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbeLMVPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:03 -0500
Subject: Re: [GIT PULL] MMC fixes for v4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735702;
        bh=Phh0EbUZU82dfiW5Fll82cxdmtlTV3RJ2KbpkyfFxWo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jgt76Q2xHGfpPne9DsjZIvaVkoU9/wHeQXDxkGkLkeJo2RNaBrKnzC9CuEbcncZot
         nXhF31QDexhdgLLULBXwqUZXY3Ba1qgh+HpvL4fEBvcHYapmuCT4l847IqUrT5GCA0
         oa0yVII6fL8Tvs64+713lNUX8+qU44kC+SxO4Zcw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181213105728.32426-1-ulf.hansson@linaro.org>
References: <20181213105728.32426-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181213105728.32426-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc5
X-PR-Tracked-Commit-Id: b704441e38f645dcfba1348ca3cc1ba43d1a9f31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e861e11c5900d21afe0c3a326d1303d6f92c9f6f
Message-Id: <20181213211502.3163.69956.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:02 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Dec 2018 11:57:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e861e11c5900d21afe0c3a326d1303d6f92c9f6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
