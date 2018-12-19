Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C370C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CDC218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeLSPCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:02:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41877 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbeLSPCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:02:39 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF0AFB1BC053;
        Wed, 19 Dec 2018 23:02:28 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 19 Dec 2018
 23:02:22 +0800
Subject: Re: [PATCH v5 1/2] scsi: hisi_sas: Add support for DIF feature for v2
 hw
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1545057608-89965-1-git-send-email-john.garry@huawei.com>
 <1545057608-89965-2-git-send-email-john.garry@huawei.com>
 <yq1pntygmlk.fsf@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <66f049e4-912c-5e4d-5cd2-4e1586715b2e@huawei.com>
Date:   Wed, 19 Dec 2018 15:02:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1pntygmlk.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 04:35, Martin K. Petersen wrote:
>
> John,
>
>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>
>> For v3 hw, we support DIF operation for SAS, but not SATA.
>>
>> In addition, DIF CRC16 is supported.
>>
>> This patchset adds the SW support for the described features. The main
>> components are as follows:
>> - Get protection mask from module param
>> - Fill PI fields
>> - Fill related to DIF in DQ and protection iu memories
>
> Applied to 4.21/scsi-queue, thanks!
>

Thanks, and we're still looking at the DIX issue.

John

