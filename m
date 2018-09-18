Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72239C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1888C2150C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1888C2150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeIRUqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:46:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727756AbeIRUqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:46:42 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5D350BFA839BE;
        Tue, 18 Sep 2018 23:13:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 23:13:37 +0800
Message-ID: <5BA11620.5030900@huawei.com>
Date:   Tue, 18 Sep 2018 23:13:36 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, <Don.Brace@microchip.com>,
        <don.brace@microsemi.com>, <jejb@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        "\"linux-scsi@vger.kernel.org\" ar" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: Use vmemdup_user to replace the open code
References: <1534164200-28408-1-git-send-email-zhongjiang@huawei.com> <BYAPR11MB28555A88771594AA31AC7596E1390@BYAPR11MB2855.namprd11.prod.outlook.com> <5B7E9CCE.5010007@huawei.com> <5BA11315.4060908@huawei.com> <yq11s9qrgez.fsf@oracle.com>
In-Reply-To: <yq11s9qrgez.fsf@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 23:09, Martin K. Petersen wrote:
> Hi Zhong,
>
>> Can you pick up the patch?
> Please submit SCSI patches to linux-scsi@vger.kernel.org so they get
> tracked in patchwork.
Ok,   Should I resend the patch ? 

Thanks,
zhong jiang
> Thank you!
>


