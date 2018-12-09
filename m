Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A08720831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A08720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLIGkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:40:05 -0500
Received: from [110.188.70.11] ([110.188.70.11]:39828 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbeLIGkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:40:04 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id wB96dPXq001091;
        Sun, 9 Dec 2018 14:39:25 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id wB96dLYl030500;
        Sun, 9 Dec 2018 14:39:21 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sun, 9 Dec 2018
 14:39:24 +0800
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [RFC PATCH] hwmon/k10temp: Add Hygon Dhyana support
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <clemens@ladisch.de>, <jdelvare@suse.com>, <bp@alien8.de>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1544250808-20462-1-git-send-email-puwen@hygon.cn>
 <20181208155559.GA27489@roeck-us.net>
Message-ID: <d91c04e9-71c2-3045-1e31-f2f4cc076e87@hygon.cn>
Date:   Sun, 9 Dec 2018 14:39:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181208155559.GA27489@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn wB96dPXq001091
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/8 23:56, Guenter Roeck wrote:
> On Sat, Dec 08, 2018 at 02:33:28PM +0800, Pu Wen wrote:
>> Add support for Hygon Dhyana family 18h processor for k10temp to get the
>> temperature. As Hygon Dhyana shares the same function interface with AMD
>> family 17h, so add Hygon PCI Vendor ID and reuse the code path of AMD.
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
>> Acked-by: Borislav Petkov <bp@suse.de>
> 
> Applied to hwmon-next.

Thanks a lot.

> If the Hygon CPUs have Tctl/Tdie temperature offsets similar to some
> of the AMD CPUs, please submit follow-up patches as necessary to add
> support for it.

Right now Hygon Dhyana CPUs do not have temperature offsets. Of course
I'll submit follow-up patches if necessary in the future.

-- 
Regards,
Pu Wen
