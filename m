Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C5C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A3A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547834711;
	bh=KROlPEeY5dH6NG/l4cal9S245qbmSE5Gl6ZxikyAdOg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dJ5jQvq420zK9eba/iQRhukUh4xPtQvhDv1ODgjnzDhDKCEyQnWhL5cseaOGzVSBL
	 DQWH3IdH+Op6TQ2BuB9SYqutUfUkjmmtHS+w2e7Tnx//JAY+6CaWxnX3EA0bKyuzjV
	 HVxmY57AIhjDB92RO8fJonvJgrjtZYPMgF/chBww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfARSFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbfARSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:05:03 -0500
Subject: Re: [GIT PULL] xen: fixes for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547834702;
        bh=KROlPEeY5dH6NG/l4cal9S245qbmSE5Gl6ZxikyAdOg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ibuy9pjRFZV3N3psgbLt67U4FP8MfI/89PHmE5JI+hoz555aHjJknEwdZj/Kudg8f
         Lj0MQ8lY3vDEJnmrwwjGX+7Pt9ziZ9a5jBFbif4ItUigVlMmg3QyB6M9cuABjclhMA
         nSfDSJn0WOpaM0cO7f1qiYERNdMomm7SNFjvn+g8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190118095713.3192-1-jgross@suse.com>
References: <20190118095713.3192-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190118095713.3192-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.0-rc3-tag
X-PR-Tracked-Commit-Id: 867cefb4cb1012f42cada1c7d1f35ac8dd276071
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6ec2fda2d464938989ecd770be92e492ace3ae1
Message-Id: <154783470278.23992.869219643981363146.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 18:05:02 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 10:57:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.0-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6ec2fda2d464938989ecd770be92e492ace3ae1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
