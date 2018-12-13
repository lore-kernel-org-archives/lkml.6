Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3CDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D605A20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735730;
	bh=wTNl4iXvbnlvcU4o0iko6AXfdYk1+JFnUU7dJN76+Y8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hyv8ZpFVNrwgylIF8EV/D53Ngmr9YezywcuUZ1ulSWeBGGZnczFtjvq8S7k8L11lL
	 EDZ0w8t2bBDUif4ay1aTPPeEFHTN5JI+uTUfuMQj485W9QNQwwhPWBwGpT+G7J09Ww
	 zOcx2qyG0juJfi1sxtvLG/C3Y0tDVaichdoJh4dw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D605A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeLMVP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLMVPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:03 -0500
Subject: Re: [PULL REQUEST] Please pull rdma.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735703;
        bh=wTNl4iXvbnlvcU4o0iko6AXfdYk1+JFnUU7dJN76+Y8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZwL5QuSiqSykcBtn6sqhhAEbrUspTr0y69d40xV5RQV+F8o0j7FKnV9lPn3SOWx+a
         U17yghQh2aIKfyr9o4iOsvs772E6lN45E7BEFpGqsHIzqikY4OgNCU+rWP7bZz5+X4
         +VXJkyjxZjUKLS/1AU4NSHCuFZLU1m/H/2EZC3Qg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <267101dbb3beb8883efe614e099e7ac4c7a84f37.camel@redhat.com>
References: <267101dbb3beb8883efe614e099e7ac4c7a84f37.camel@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <267101dbb3beb8883efe614e099e7ac4c7a84f37.camel@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 37fbd834b4e492dc41743830cbe435f35120abd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e10db791bf73c1973f24591897e839db2eb3c804
Message-Id: <20181213211503.3163.36451.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:03 +0000
To:     Doug Ledford <dledford@redhat.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Dec 2018 11:56:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e10db791bf73c1973f24591897e839db2eb3c804

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
