Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A91CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5492081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544381414;
	bh=X9EZS5aksPkIICRCSEQXs2smVH3mpV4FOdFbek6iITw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=F5jRRStkqRmPHu5ebiH1gBAqmTaQ8ndeem8P+v2VsPSA2aK1yBSN0n3pZgz65kOAH
	 WN3BkT01lwW7nM4XKkK1Y9mLjCk3A8/b8sWBVRbIVVfubYPpY23Jb3+yLSfXCzaAgz
	 xex5QGKQ6426htGY9dLLS83QVXYej/St6XqWcRUo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5492081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeLISuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeLISuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:50:02 -0500
Subject: Re: [GIT PULL] dax fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544381402;
        bh=X9EZS5aksPkIICRCSEQXs2smVH3mpV4FOdFbek6iITw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Uh+A2Ia7bTrrYhRxHVWI/d6N/D6LS6O8lWc2ehrWq7r65TRAWAMszky6OMmzV3ROB
         COGCGdgVI8uDjZCm9dHSIqDbiuGBkXu1u40hRWkmcS0Imuh0K/fSJMg8ZU14qMisjo
         E3uxZBZXx91jWnwwf0aTLbcikujaewAJJa5sicQE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
References: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fixes-4.20-rc6
X-PR-Tracked-Commit-Id: 27359fd6e5f3c5db8fe544b63238b6170e8806d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa82dcbf2aed65dc3ea78eaca9ea56fd926b2b10
Message-Id: <20181209185002.3376.79242.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 18:50:02 +0000
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 06:26:39 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa82dcbf2aed65dc3ea78eaca9ea56fd926b2b10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
