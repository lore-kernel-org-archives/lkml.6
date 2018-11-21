Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC91BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B592145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B592145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeKUSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:30:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeKUSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:30:04 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 056DDF7936EE1;
        Wed, 21 Nov 2018 15:56:31 +0800 (CST)
Received: from [127.0.0.1] (10.210.167.253) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 15:56:32 +0800
Subject: Re: [PATCH] scsi/lpfc/lpfc_sli.c: Use dma_zalloc_coherent
To:     James Smart <james.smart@broadcom.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        <dick.kennedy@broadcom.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
 <16c3b882-6e0e-b712-b4d6-78f68172da65@huawei.com>
 <34556d50-562b-43b2-873f-ba68056e5af5@broadcom.com>
CC:     <jrdr.linux@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <brajeswar.linux@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5229ccbb-e6de-e114-52fb-235ea703a7ef@huawei.com>
Date:   Wed, 21 Nov 2018 07:56:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <34556d50-562b-43b2-873f-ba68056e5af5@broadcom.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 21:52, James Smart wrote:
> On 11/20/2018 1:40 AM, John Garry wrote:
>>
>> please ensure that you maintain alignment with opening brackets
>
> I don't think this is a requirement.  From the rules I've read
> preference is tabs-only indentation.

This is the only rule (enforcement) I see:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20181120&id=d1fe9c099cecc6e49324355f1b15573e9dbbe0f9

Spacing (less than a tab), after
> tabs, for open brace alignment is allowed, thus is coder's choice.

It seems that alignment was being implemented with tab+space, and now it 
would be tab+space but no alignment.

cheers,
John

>
> -- james
>
>
>
>
>
>
>


