Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4161AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6362178F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6362178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeHRRD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:03:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbeHRRD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:03:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BA2EF0B2C6D6;
        Sat, 18 Aug 2018 21:56:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Sat, 18 Aug 2018
 21:56:04 +0800
Message-ID: <5B782572.5000802@huawei.com>
Date:   Sat, 18 Aug 2018 21:56:02 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Himanshu Jha <himanshujha199640@gmail.com>
CC:     <Julia.Lawall@lip6.fr>, <Gilles.Muller@lip6.fr>,
        <nicolas.palix@imag.fr>, <michal.lkml@markovi.net>,
        <yamada.masahiro@socionext.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Coccinelle: remove pci_alloc_consistent semantic to dectect
 in zalloc-simple.cocci
References: <1534593700-3036-1-git-send-email-zhongjiang@huawei.com> <20180818125228.GA1000@himanshu-Vostro-3559>
In-Reply-To: <20180818125228.GA1000@himanshu-Vostro-3559>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/18 20:52, Himanshu Jha wrote:
> On Sat, Aug 18, 2018 at 08:01:40PM +0800, zhong jiang wrote:
>> Because pci_alloc_consistent has been deprecated. We prefer to use
>> dam_alloc_coherent directly. Therefore, we should remove pci_alloc_consistent
>   ^^^ typo "dma"
>
> Also, typo in the patch subject "dectect" -> "detect"
 Thanks,  will fix it in v2.
> Otherwise,
>
> Acked-by: Himanshu Jha <himanshujha199640@gmail.com>
>
> Thanks for cleaning up, we still have few more *_alloc/memset
> in the mainline, especially in the scsi subsystem, even after
> I cleaned up with two long patch series in the past.
>
   I post same patches like *_alloc/memset in the scsi subsystem. Unfortunately,
   Maintainer maybe do not care about the change.  therefore,  None of my patches
  are received and rarely feedback.

 Thanks,
 zhong jiang

