Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36627815
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F36627815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967157AbeF1TDb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:03:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752637AbeF1TD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:03:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EE79AD08;
        Thu, 28 Jun 2018 19:03:27 +0000 (UTC)
Date:   Thu, 28 Jun 2018 10:40:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        thierry.escande@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] printk for 4.18-rc3
Message-ID: <20180628084056.nmjwk2xqndycdhfd@pathway.suse.cz>
References: <20180626141300.4tkw3lculx6seyeh@pathway.suse.cz>
 <CA+55aFwStj80KBHxn31r=Rk_M-zEMph3P6EWaT4-aJYCuvXuRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwStj80KBHxn31r=Rk_M-zEMph3P6EWaT4-aJYCuvXuRw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-27 09:13:35, Linus Torvalds wrote:
> On Tue, Jun 26, 2018 at 7:13 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > please pull one revert from
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.18
> 
> That tag doesn't actually contain any revert.

Ah, it should have been

git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.18-rc3

I am sorry for confusion. Anyway, it seems that Andrew is going to
send it as well in the meantime.

Best Regards,
Petr
