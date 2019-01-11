Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF139C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D75F20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfAKHm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:42:27 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:59480 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfAKHm0 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 11 Jan 2019 02:42:26 -0500
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 11 Jan 2019 08:42:24 +0100
Subject: Re: [PATCH 05/41] scsi: aic7xxx: aic79xx: mark expected switch
 fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <ff0ea78271abe136badebfbeba1d4373fb836bce.1543374820.git.gustavo@embeddedor.com>
 <1d73dbbd-7e8e-e5ba-6a0f-97fdd799d4c4@embeddedor.com>
 <a676a977-c55b-a0ce-1be3-b4d53ec68411@embeddedor.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <a1c70e7c-5936-a094-7487-8b18318e6257@suse.com>
Date:   Fri, 11 Jan 2019 08:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <a676a977-c55b-a0ce-1be3-b4d53ec68411@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 9:15 PM, Gustavo A. R. Silva wrote:
> Hi,
> 
> Friendly ping (second one):
> 
> Who can ack/review/take this patch, please?
> 
> Thanks
> -- 
> Gustavo
> 
> On 12/19/18 9:36 AM, Gustavo A. R. Silva wrote:
>> Hi,
>>
>> Friendly ping:
>>
>> Who can ack or review this patch, please?
>>
>> Thanks
>> -- 
>> Gustavo
>>
>> On 11/27/18 10:26 PM, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>> where we are expecting to fall through.
>>>
>>> Notice that, in some cases, I replaced "FALLTHROUGH" with a "fall 
>>> through"
>>> annotation and then placed it at the bottom of the corresponding switch
>>> case, which is what GCC is expecting to find.
>>>
>>> Addresses-Coverity-ID: 114961 ("Missing break in switch")
>>> Addresses-Coverity-ID: 114962 ("Missing break in switch")
>>> Addresses-Coverity-ID: 114963 ("Missing break in switch")
>>> Addresses-Coverity-ID: 114964 ("Missing break in switch")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>   drivers/scsi/aic7xxx/aic79xx_core.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
Sorry, I thought I'd done so already.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
