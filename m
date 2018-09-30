Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97877C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4735A2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4735A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeI3ICN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 04:02:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeI3ICN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 04:02:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE71727DA8A99;
        Sun, 30 Sep 2018 09:31:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Sun, 30 Sep 2018
 09:31:24 +0800
Message-ID: <5BB0276B.8000309@huawei.com>
Date:   Sun, 30 Sep 2018 09:31:23 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <davem@davemloft.net>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: Fix a unused function gcc warning.
References: <1538197903-37168-1-git-send-email-zhongjiang@huawei.com> <E3868752-29CA-4D84-9E09-C7E238AFEF9E@gmail.com>
In-Reply-To: <E3868752-29CA-4D84-9E09-C7E238AFEF9E@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/30 4:36, Florian Fainelli wrote:
>
> On September 28, 2018 10:11:43 PM PDT, zhong jiang <zhongjiang@huawei.com> wrote:
>> Fix the following compile warning:
>>
>> drivers/net/phy/mdio-bcm-unimac.c:321:12: warning:
>> 'unimac_mdio_suspend' defined but not used [-Wunused-function]
>> static int unimac_mdio_suspend(struct device *d)
>>            ^
>> drivers/net/phy/mdio-bcm-unimac.c:330:12: warning: 'unimac_mdio_resume'
>> defined but not used [-Wunused-function]
>> static int unimac_mdio_resume(struct device *d)
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Thank you, Arnd already sent a patch for this which got accepted:
>
> https://patchwork.ozlabs.org/patch/975088/
Ok, Thanks, I miss that.

Sincerely,
zhong jiang

