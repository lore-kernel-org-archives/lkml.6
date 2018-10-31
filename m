Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC5620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC5620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeKAHH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:07:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49626 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAHH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:07:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5505123B76;
        Wed, 31 Oct 2018 18:07:54 -0400 (EDT)
Date:   Thu, 1 Nov 2018 09:07:51 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Boaz Harrosh <ooo@electrozaur.com>
cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: remove exofs and the T10 OSD code V2
In-Reply-To: <6794b3a0-fe57-cd8b-3ad3-3a590121b12a@electrozaur.com>
Message-ID: <alpine.LNX.2.21.1811010846490.8@nippy.intranet>
References: <20181027082019.20838-1-hch@lst.de> <c9740eeb-6b96-35b6-a436-7537669da1a9@electrozaur.com> <1541006979.196084.138.camel@acm.org> <6794b3a0-fe57-cd8b-3ad3-3a590121b12a@electrozaur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Boaz Harrosh wrote:

> > [...] All changes made by other kernel developers than you are the 
> > result of tree-wide refactoring, compiler warning fixes, fixes for 
> > issues detected by static source code analyzers or spelling fixes. 
> > Hence my question: how big is the user base of the exofs and osd 
> > kernel drivers?
> > 
> 
> Not big at all. And none of them production setups. As I said mainly 
> used by academia.
> 

For its part, academia has provided tools to automate the mindless and 
error-prone refactoring which Bart points to. I'm mainly thinking of LLVM 
and Ocaml. (I'm not a computer scientist.)

But I fear that code transformation tools lie beyond the skill and ability 
of those of us who submit spelling fixes.

So the tools need to be made more usable in this setting. Corporate users 
of kernel code who happen to have their own IDE products (Microsoft, 
Google, etc.) have an opportunity here.

-- 

> Thanks
> Boaz
> 
> > Thanks,
> > Bart.
> 
> 
