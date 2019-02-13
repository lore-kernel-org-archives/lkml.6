Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE99C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574D721872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbfBMRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:12:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:58320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729760AbfBMRMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:12:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0599B157;
        Wed, 13 Feb 2019 17:12:36 +0000 (UTC)
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>, hch@infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, stable@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org>
 <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz>
Date:   Wed, 13 Feb 2019 18:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> Hi Andrew,
> 
> On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>>
>> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
>> > Does anyone have any further comment on this series? If not, which
>> > maintainer is going to pick this up? I assume Andrew Morton?
>>
>> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
>> this should go through mm.
> 
> Gentle ping on this series, it seems like it's better if it goes
> through your tree.
> 
> Series still applies cleanly on linux-next, but I'm happy to resend if
> that helps.

Ping, Andrew?

> Thanks!
> 
>> Regards,
>>
>>         Joerg
> 

