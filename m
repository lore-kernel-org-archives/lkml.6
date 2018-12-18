Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D857AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70302133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeLRImg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:42:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:45546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbeLRImg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:42:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01DC9AFC5;
        Tue, 18 Dec 2018 08:42:34 +0000 (UTC)
Date:   Tue, 18 Dec 2018 09:42:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the printk tree
Message-ID: <20181218084234.sa2gplversistjzf@pathway.suse.cz>
References: <20181218070807.07cb795d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218070807.07cb795d@canb.auug.org.au>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-18 07:08:07, Stephen Rothwell wrote:
> Hi Petr,
> 
> Commit
> 
>   503283fa006d ("printk: Add caller information to printk() output.")
> 
> is missing a Signed-off-by from its committer.
> 
> Moreover, that patch appears twice in the tree (the other time properly
> signed-off),

Thanks a lot for the report. I have fixed it.

Sigh, I guess that I left there the duplicated patch from testing.
It is pity that git did not complain. I need to be more careful.

Best Regards,
Petr
