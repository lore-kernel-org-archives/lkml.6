Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086EBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B4820578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546515561;
	bh=dChOx75Xj8LzA40ORlGZCYarampLptjw+x2AY5gGKb8=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=FNinVKyf1ZYa0h4Z8DMG2+m1ftF0V4OYUg2LL8xre+9rasKJmOsw38PfFKipOssRb
	 glToet0ER9JrkBwotv/OUfcfRzqW8L5Sx+tBsI8woS9EKxSaqIEXyvq3yBN8VVtl6+
	 bl7lDMS8Lzhi8S1U4xfsIs0l0yuHO2ra7QlXGICY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbfACLjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:39:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:58998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730324AbfACLjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:39:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18CD4AF8D;
        Thu,  3 Jan 2019 11:39:19 +0000 (UTC)
Date:   Thu, 3 Jan 2019 12:39:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 4.21
Message-ID: <nycvar.YFH.7.76.1901031236310.14047@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching.git for-linus

to receive

=====
- return value checking fixup in livepatching samples, from Nicholas Mc 
  Guire
=====

Thanks

----------------------------------------------------------------
Nicholas Mc Guire (1):
      livepatch: check kzalloc return values

 samples/livepatch/livepatch-shadow-fix1.c | 5 +++++
 samples/livepatch/livepatch-shadow-mod.c  | 4 ++++
 2 files changed, 9 insertions(+)

-- 
Jiri Kosina
SUSE Labs

