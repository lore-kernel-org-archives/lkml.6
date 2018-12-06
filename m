Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E7320989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544123113;
	bh=m1wlGTAcsCsDd1gI+T6UUN0+58hz3EJ43ljKuBeacBM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aoi4t6YdBa97fEExmKQc8Psz+udNIxANmEtcQiwVqYNAeoLSIJx/blL6HhC/bhKq3
	 /Lh8xQdhq101t4mTAeFmIzelH803701gJVwRxfeXaFyjwgiYfRWcNusVjgmImGuaXu
	 sEJeDjCZ1QBSLAXQix47gVkUHt60Igh+tkh6YApE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E7320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLFTFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbeLFTFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:05:03 -0500
Subject: Re: [GIT PULL] Uprobes: Fix kernel oops with delayed_uprobe_remove()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544123102;
        bh=m1wlGTAcsCsDd1gI+T6UUN0+58hz3EJ43ljKuBeacBM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qkQweCd21vxqeOwCHa9O+027Z55+RZoLy2QWDJanKH+r9BuqkL93IqffaaCAhVj+T
         pd7z+uhc/dtio/0eRXnhmk5vlqHk+k0KH7tpuUQnLBcp3RJEUxWK+eimGaxrFCvEqi
         SfHJ2rgRfvKklE5PjuDXOhDILaPl4CwqddHPvGfQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181206124719.1fa76d92@vmware.local.home>
References: <20181206124719.1fa76d92@vmware.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181206124719.1fa76d92@vmware.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v4.20-rc5
X-PR-Tracked-Commit-Id: 1aed58e67a6ec1e7a18bfabe8ba6ec2d27c15636
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abb8d6ecbd8f7801c048f6543f79d22d24cead7b
Message-Id: <20181206190502.10356.48100.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 06 Dec 2018 19:05:02 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Dec 2018 12:47:19 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v4.20-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abb8d6ecbd8f7801c048f6543f79d22d24cead7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
