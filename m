Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8650C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6062085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6062085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbeKFASl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:18:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbeKFASl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:18:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A682A5B78DA7F;
        Mon,  5 Nov 2018 22:58:31 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 5 Nov 2018
 22:58:26 +0800
Subject: Re: [PATCH] arm64: defconfig: Enable some IPMI configs
To:     Olof Johansson <olof@lixom.net>
References: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
 <20181102182435.x46hvfgegxprksxq@localhost>
CC:     <xuwei5@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arm@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <97c2db1a-d7aa-aced-bd89-16527d35f376@huawei.com>
Date:   Mon, 5 Nov 2018 14:58:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181102182435.x46hvfgegxprksxq@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 18:24, Olof Johansson wrote:
> Hi John,
>
> On Fri, Oct 19, 2018 at 12:17:07AM +0800, John Garry wrote:
>> The arm64 port now runs on servers which use IPMI. This patch enables
>> relevant core configs to save manually enabling them when testing
>> mainline.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> I don't think these are required for booting to rootfs, so I'm applying
> the patch but switching them over to modules (=m) instead. Hope that's
> sufficient for your testing, let me know if it isn't.
>

It's ok.

Thanks,
John

>
> Thanks,
>
> -Olof
>
>


