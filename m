Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCF2C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9092184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfAWUbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:31:55 -0500
Received: from ale.deltatee.com ([207.54.116.67]:33958 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfAWUby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:31:54 -0500
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.205])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gmPBS-0005d3-BA; Wed, 23 Jan 2019 13:31:39 -0700
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        dalias@libc.org, ysato@users.sourceforge.jp,
        linux-kernel@vger.kernel.org, sbates@raithlin.com,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        dan.j.williams@intel.com
References: <mhng-96f28491-e123-459a-b09c-88732de06bbf@palmer-si-x1c4>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <eca31a2b-1e19-0b4b-afd9-0204c9aba125@deltatee.com>
Date:   Wed, 23 Jan 2019 13:31:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <mhng-96f28491-e123-459a-b09c-88732de06bbf@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: dan.j.williams@intel.com, hch@lst.de, linux-riscv@lists.infradead.org, sbates@raithlin.com, linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, robh@kernel.org, hch@infradead.org, palmer@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-01-23 12:56 p.m., Palmer Dabbelt wrote:
> On Tue, 15 Jan 2019 09:30:44 PST (-0800), logang@deltatee.com wrote:
>>
>>
>> On 2019-01-15 6:58 a.m., Christoph Hellwig wrote:
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Probably no need to keep this in a series with the RISC-V code, this can
>>> be queued up by the sh folks independently.
>>
>> Oh, yeah, sorry, I obviously didn't pay enough attention to this when I
>> resent it. I sent the similar Arm changes to the appropriate list and,
>> yes, the sh ones should go to that maintainer.
>>
>> @Palmer: if you can just look at taking the second patch, I'll resubmit
>> the first one to the appropriate list.
> 
> Works for me.  I'll queue the second patch into my staging branch, targeted for
> the next merge window.

Thanks!

Logan
