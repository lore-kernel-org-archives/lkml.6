Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968221AbeE2WSP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:18:15 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:39225 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030224AbeE2WR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:17:56 -0400
X-Google-Smtp-Source: ADUXVKKGv+kqs7VkJxjZW3yMzU4D1hvicgQ57r87dxtHSQykVc2ayosduorR2jIdi/GtvLEb5gb/BA==
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
References: <20180529143357.2a66b0af@canb.auug.org.au>
 <20180529081205.GB1416@lst.de>
 <83024e98-8719-7ed2-a5d5-e1653162bacc@kernel.dk>
 <20180530074012.393b74b1@canb.auug.org.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <20d640dc-77df-1eb1-7310-8282a542cb59@kernel.dk>
Date: Tue, 29 May 2018 16:17:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530074012.393b74b1@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/18 3:40 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Tue, 29 May 2018 08:22:43 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 5/29/18 2:12 AM, Christoph Hellwig wrote:
>>> Meh.  Do we really need these switch to octal patches to start
>>> with?  I mean, I personally prefer octal, but just switching around
>>> in random code that isn't otherwise changed creates nothing but churn.  
>>
>> This is exactly why I hesitated doing it, I knew it would end up
>> with conflicts. The main reason was to get rid of the inconsistency,
>> since we had a fair mix of octal and symbolic names.
> 
> But the conflicts are all trivial ...

Yep, that certainly does help.

-- 
Jens Axboe
