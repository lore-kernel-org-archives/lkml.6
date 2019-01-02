Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65275C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372522171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfABMpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 07:45:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729848AbfABMpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 07:45:52 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0D6DB1A3E34D;
        Wed,  2 Jan 2019 20:45:42 +0800 (CST)
Received: from [127.0.0.1] (10.63.173.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 2 Jan 2019
 20:45:37 +0800
Subject: Re: [PATCH net-next] net: hns3: Config NIC port speed same as that of
 optical module
To:     dann frazier <dann.frazier@canonical.com>,
        Salil Mehta <salil.mehta@huawei.com>
CC:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <mehta.salil@opnsrc.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20181126184300.24964-1-salil.mehta@huawei.com>
 <20190101012205.GA22494@xps13.dannf>
From:   "lipeng (Y)" <lipeng321@huawei.com>
Message-ID: <aadad75b-a3fe-8bf1-77ce-14d3375ce4fd@huawei.com>
Date:   Wed, 2 Jan 2019 20:45:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190101012205.GA22494@xps13.dannf>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.63.173.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/1 9:22, dann frazier wrote:
> On Mon, Nov 26, 2018 at 06:43:00PM +0000, Salil Mehta wrote:
>> From: Peng Li <lipeng321@huawei.com>
>>
>> Port 0/1 of HiP08 supports 10G and 25G. This patch adds a
>> change to configure NIC port speed same as that of  optical
>> module(SFP/QFSP). Driver gets the optical module speed and
>> sets NIC port speed accordingly.
> Hi,
>
> I'm getting the following errors in dmesg about every 1s on a D06:
>
> [  766.761823] hns3 0000:bd:00.0: get sfp speed failed -5
> [  767.785823] hns3 0000:bd:00.0: get sfp speed failed -5
> [  768.809820] hns3 0000:bd:00.0: get sfp speed failed -5
> [  769.833818] hns3 0000:bd:00.0: get sfp speed failed -5
>
> Reverting this patch fixes the issue.
>
>   -dann
Hi,dann,

Thanks for your test and report.

This patch needs to match new fireware verison ,
And  it  does some work to  be Compatible with older versions.

Can you show me more information？
can you  use "ethtool -i ethx" to get the fireware version ,
and shows me  some other message about hns3?

Thanks

>
> .
>


