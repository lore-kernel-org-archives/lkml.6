Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C81C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4676721532
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4676721532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeHWOuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:50:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbeHWOuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:50:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D56A84638DAF6;
        Thu, 23 Aug 2018 19:21:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 19:21:36 +0800
Message-ID: <5B7E98BF.6010307@huawei.com>
Date:   Thu, 23 Aug 2018 19:21:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <alcooperx@gmail.com>, <kishon@ti.com>, <robh@kernel.org>,
        <hauke@hauke-m.de>, <ralf@linux-mips.org>
CC:     <f.fainelli@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 0/2] phy: Use PTR_ERR_OR_ZERO to replace the open coded
 version
References: <1534435135-49332-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534435135-49332-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping ,  Anyone has any objection with the patchset ?

Thanks,
zhong jiang

On 2018/8/16 23:58, zhong jiang wrote:
> The issue is detected with the help of Coccinelle.
>
> v1->v2:
>  - According to Florian's suggestion, change the subject of the patch.
>
> zhong jiang (2):
>   phy:phy-brcm-usb: Use PTR_ERR_OR_ZERO to replace the open coded
>     version
>   phy:phy-lantiq-rcu-usb2: Use PTR_ERR_OR_ZERO to replace the open
>     coded version
>
>  drivers/phy/broadcom/phy-brcm-usb.c      | 4 +---
>  drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>


