Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553A220851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfAQQ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:29:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbfAQQ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:29:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22911804F8;
        Thu, 17 Jan 2019 16:29:13 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CD1C60933;
        Thu, 17 Jan 2019 16:29:11 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     dave@sr71.net, thomas.lendacky@amd.com, mhocko@suse.com,
        linux-nvdimm@lists.01.org, tiwai@suse.de, ying.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, bp@suse.de,
        baiyaowei@cmss.chinamobile.com, zwisler@kernel.org,
        bhelgaas@google.com, fengguang.wu@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 0/4] Allow persistent memory to be used like normal RAM
References: <20190116181859.D1504459@viggo.jf.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 17 Jan 2019 11:29:10 -0500
In-Reply-To: <20190116181859.D1504459@viggo.jf.intel.com> (Dave Hansen's
        message of "Wed, 16 Jan 2019 10:18:59 -0800")
Message-ID: <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 17 Jan 2019 16:29:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> Persistent memory is cool.  But, currently, you have to rewrite
> your applications to use it.  Wouldn't it be cool if you could
> just have it show up in your system like normal RAM and get to
> it like a slow blob of memory?  Well... have I got the patch
> series for you!

So, isn't that what memory mode is for?
  https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/

Why do we need this code in the kernel?

-Jeff
