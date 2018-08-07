Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C621A0D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9C621A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbeHGIua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:50:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388204AbeHGIua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:50:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F101722A0A5AD;
        Tue,  7 Aug 2018 14:37:37 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 14:37:37 +0800
Subject: Re: [PATCH] arm64: clean the additional checks before calling
 ghes_notify_sea()
To:     Will Deacon <will.deacon@arm.com>,
        gengdongjiu <gengdj.1984@gmail.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
        "Len Brown" <lenb@kernel.org>, <rafael.j.wysocki@intel.com>,
        <erik.schmauss@intel.com>, <robert.moore@intel.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>
References: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com>
 <20180727100617.GB25592@arm.com>
 <CAMj-D2Ab9Txk27GDQbOy3X=Qup7BuA3sWSovsOpffpxe6UcBFQ@mail.gmail.com>
 <20180806142623.GA15275@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <2c3baa9e-c647-01a9-cef6-eb61ba6c529c@huawei.com>
Date:   Tue, 7 Aug 2018 14:37:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180806142623.GA15275@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/6 22:26, Will Deacon wrote:
>> Will,
>>      This patch will be applied, right? thanks
> I haven't queued it in the arm64 tree, since it touches include/acpi/ghes.h
> and you don't have an ack from the acpi folks. I acked it so that you could
> route it via the acpi tree without me holding you up.

Thanks the explanation.
yes, this patch touches the "include/acpi/ghes.h", I will repost this patch to let acpi
folks review it.


> 
> Will
> 
>>>> This cleanup is ever mentioned by Mark Rutland in [1]

