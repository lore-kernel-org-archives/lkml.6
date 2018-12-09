Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E9C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63E12082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544381423;
	bh=kvLYer+quvp1QVwT07WWYNrJaqtA3fG/sSKoS4u+aIg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SAtiQM2LxRqqRjKnVl5JuecnLrsM6SEHj3HeXAkaA7h1fknCmlN9qQruAWrmKixps
	 eEEnWoYMTLB+pRvCVE5dn6pR8qvH2ObjscrFRK3e3eYw0MepaxJvJ+D9DmNZxT5rL4
	 uHOHzySUc66mgFVaOMQOZEqyWr3M6dEVO00TXXlI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeLISuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeLISuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:50:02 -0500
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544381401;
        bh=kvLYer+quvp1QVwT07WWYNrJaqtA3fG/sSKoS4u+aIg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y9pk09HsLUea+Xba4Bo7ncRzCknCLmNgTu7kzz5ptmdFvfVl4NOey6P7lptdQkAzi
         TmpCTkodxWCOrZWRUqwKyYX2wnhKE1thZt7s9MfV3VhSjzmUFdM/2Xm6G8rQ7SGngm
         Q/AnTpt2vBguwPGPXkoXfH5eNWaTexCiquFUTKGE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181208212847.GA3352@localhost.localdomain>
References: <20181208212847.GA3352@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181208212847.GA3352@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 fixes
X-PR-Tracked-Commit-Id: 1aea7aee805e3d1288f9f1fa4484964b51664960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ec067e3a4492569699676d75a21fcee22fefc5b
Message-Id: <20181209185001.3376.71229.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 18:50:01 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Dec 2018 13:28:48 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ec067e3a4492569699676d75a21fcee22fefc5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
