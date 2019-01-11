Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9A921841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfAKBtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:49:33 -0500
Received: from mail1.windriver.com ([147.11.146.13]:64856 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfAKBtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:49:33 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0B1n8eS019112
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 10 Jan 2019 17:49:08 -0800 (PST)
Received: from [128.224.162.180] (128.224.162.180) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 10 Jan
 2019 17:49:07 -0800
Subject: Re: [PATCH v2] kernel/dma: Fix panic caused by passing swiotlb to
 command line
To:     <konrad@darnok.org>, Christoph Hellwig <hch@lst.de>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <1543832571-121638-1-git-send-email-zhe.he@windriver.com>
 <b35907a9-4d30-493b-3839-731b10d71c63@windriver.com>
 <20190107090702.GA14033@lst.de>
 <CAPbh3rupHC_G0=5dBhhpoXvXO_=i-Y6p=9WdRtn9W19jRpVVcg@mail.gmail.com>
 <1cef7480-0838-c044-9bca-9b7adacb0f17@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <bf0c7631-f5c1-42cc-fa1a-d7f4f5b9e6eb@windriver.com>
Date:   Fri, 11 Jan 2019 09:49:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1cef7480-0838-c044-9bca-9b7adacb0f17@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.180]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/19 9:46 AM, He Zhe wrote:
>
> On 1/11/19 1:27 AM, Konrad Rzeszutek Wilk wrote:
>> Let's skip it. There was another patch that would allocate a default 4MB size if it there was an misue of swiotlb parameters.
> But this patch mainly fixes a crash. Could you please point me to the patch you mentioned?

And the v2 is modified according to your suggestion.

Zhe

>
> Thanks,
> Zhe
>
>>
>>
>> On Mon, Jan 7, 2019, 4:07 AM Christoph Hellwig <hch@lst.de <mailto:hch@lst.de> wrote:
>>
>>     On Mon, Jan 07, 2019 at 04:46:51PM +0800, He Zhe wrote:
>>     > Kindly ping.
>>
>>     Konrad, I'll pick this up through the DMA mapping tree unless you
>>     protest in the next few days.
>>
>

