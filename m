Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDA6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C23F20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C23F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeLEPMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:12:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbeLEPMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:12:45 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E5DE6FA444DF;
        Wed,  5 Dec 2018 23:12:40 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Dec 2018
 23:12:32 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 4/4] scsi: hisi_sas: Add support for DIF feature for v3
 hw
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1543838994-30028-1-git-send-email-john.garry@huawei.com>
 <1543838994-30028-5-git-send-email-john.garry@huawei.com>
 <yq1ftveszew.fsf@oracle.com>
 <358aae82-394e-9df2-6b05-5af8e0f196b3@huawei.com>
 <yq1k1kosorw.fsf@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Message-ID: <9c08d3fa-5043-7d38-7b6c-574b7344409b@huawei.com>
Date:   Wed, 5 Dec 2018 15:12:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1k1kosorw.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 02:14, Martin K. Petersen wrote:
>
> John,

Hi Martin,

>
>> Are you happy for us to make DIX support in this driver "hisi_sas DIX
>> experimental" short term?
>
> That's entirely your call, it's your driver/controller.  I just want the
> experimental tag to be due to reasons on *your* end.
>

Well unfortunately at the moment we cannot definitively say that it is 
an issue on our end. There's a reasonable chance it is.

> If it's reasons on my end they'll need to get fixed. We shouldn't have
> drivers circumventing features because of bugs in the core block/SCSI
> code...
>

Right, of course not. I'm just a bit stuck now, since we need to 
upstream the DIF support ASAP, but it is being held back by the DIX support.

You did request not to throw away DIX support, so I can send a new 
patchset with DIF and DIX support separated out, and we can leave the 
DIX patch in limbo until we get to the bottom of the DIX issue.

I hope it's ok.

Thanks,
John

