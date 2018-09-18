Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF70C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F28C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F28C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeIRVHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:07:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727756AbeIRVHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:07:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B286485CF9A1C;
        Tue, 18 Sep 2018 23:34:27 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 23:34:28 +0800
Message-ID: <5BA11B03.3030807@huawei.com>
Date:   Tue, 18 Sep 2018 23:34:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <martin.petersen@oracle.com>, <Don.Brace@microchip.com>,
        <don.brace@microsemi.com>, <jejb@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: Use vmemdup_user to replace the open code
References: <1534164200-28408-1-git-send-email-zhongjiang@huawei.com> <BYAPR11MB28555A88771594AA31AC7596E1390@BYAPR11MB2855.namprd11.prod.outlook.com> <5B7E9CCE.5010007@huawei.com> <5BA11315.4060908@huawei.com> <20180918151015.GA27663@kroah.com>
In-Reply-To: <20180918151015.GA27663@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 23:10, Greg KH wrote:
> On Tue, Sep 18, 2018 at 11:00:37PM +0800, zhong jiang wrote:
>> Hi,  Greg
>>
>> Can you pick up the patch?
> Nope, sorry, as before, work with the maintainers please.
Thank you for your reply timely .:-)

Sincerely,
zhong jiang
> greg k-h
>
> .
>


