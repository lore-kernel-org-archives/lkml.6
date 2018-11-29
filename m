Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73B3206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73B3206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeK2XYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:24:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeK2XX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:23:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 36DE018C907BD;
        Thu, 29 Nov 2018 20:18:41 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 20:18:34 +0800
Subject: Re: [PATCH] scsi: libsas: Add missing license and update to SPDX
 license identifier
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1543328132-243266-1-git-send-email-john.garry@huawei.com>
 <20181127144333.GA11004@kroah.com>
 <8ae3a984-b4d4-f2eb-4aaa-b460441fa403@huawei.com>
 <07b65f80-9b73-472f-1fb8-7c0133f1d1ab@huawei.com>
 <20181129121110.GA25319@kroah.com> <20181129121310.GB25319@kroah.com>
CC:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b840b9bd-81e6-ebec-1fdc-fa5417a76e18@huawei.com>
Date:   Thu, 29 Nov 2018 12:18:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181129121310.GB25319@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 12:13, Greg KH wrote:
>>> ...
>>> > >
>>> > > MODULE_AUTHOR("Luben Tuikov <luben_tuikov@adaptec.com>");
>>> > > MODULE_DESCRIPTION("SAS Transport Layer");
>>> > > MODULE_LICENSE("GPL v2");
>>> > >
>>> > > So the license specifies v2+ but module license states v2.
>>> > >
>>> > > I could not find a docment for guidance on this. I also note that making
>>> > > sas_task.c v2 would mean mixing v2 and v2+ into the module.
>> >
>> > This is not the only file in the kernel with this problem.
>> >
>> > For now, we have been trusting the "written text" lines over the
>> > MODULE_LICENSE() lines, as that seems to be the proper way forward.
>> >
>>> > > I did find an example of someone changing the license:
>>> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-designware-slave.c?h=v4.20-rc4&id=15c566fcff9cc7b8fd64461d6ee6fd1bc665b444
>>> > >
>> >
>> > Yup, not good, that should be fixed.
> I take it back, the changelog for the patch explains what is happening
> here, the people involved were paying attention.
>

OK, but these sample patches were just some I selected at random. May be 
many more (incorrect)...

Cheers,
John

> greg k-h
>
> .
>


