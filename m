Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B712C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C06E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfAJQwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:52:11 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38314 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfAJQwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:52:08 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ghdYg-0004VF-PC; Thu, 10 Jan 2019 09:51:55 -0700
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Bates <sbates@raithlin.com>
References: <20190109202100.6968-1-logang@deltatee.com>
 <20190109202100.6968-3-logang@deltatee.com>
 <20190110141503.GA31328@fuggles.cambridge.arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e272894e-31b6-2698-b6f5-5321b6853263@deltatee.com>
Date:   Thu, 10 Jan 2019 09:51:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190110141503.GA31328@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will.deacon@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] arm64: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-01-10 7:15 a.m., Will Deacon wrote:
> On Wed, Jan 09, 2019 at 01:21:00PM -0700, Logan Gunthorpe wrote:
>> Cleanup the arm64_memory_present() function seeing it's very
>> similar to other arches.
>>
>> memblocks_present() is a direct replacement of arm64_memory_present()
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/mm/init.c | 20 +-------------------
>>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Did you want us to take this via the arm64 tree?

Yes please.

Thanks,

Logan
