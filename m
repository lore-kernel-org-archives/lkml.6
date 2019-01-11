Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC8CC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wq/c5agS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAKK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:56:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58704 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfAKK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:56:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BAuAn2072145;
        Fri, 11 Jan 2019 04:56:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547204170;
        bh=eR6eD6q/nJ45/trmkxExdoKyplDZBZ8qqleBxBVmRac=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wq/c5agSPxlxQo0E61BpbQJT1k0ykDZasJRhoZap5x6b7M74w5m1bkBh4blwi1q3s
         W6UEeP33rHH4ea81ZYt+nCVlMHCHjqPn1yWwYOkBjpf62lMkXxCOKvrYg+I5BNEXt7
         Sr+ZSAgTel7E3zm8c+JTHsCWjWMv9nVqo0fX9qWQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BAuAMF075491
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 04:56:10 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 04:56:09 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 04:56:09 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BAu6h7012714;
        Fri, 11 Jan 2019 04:56:07 -0600
Subject: Re: [PATCH 1/5] ARM: davinci: da830-evm: fix label names in GPIO
 lookup entries
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
References: <20190103151104.11839-1-brgl@bgdev.pl>
 <20190103151104.11839-2-brgl@bgdev.pl>
 <CACRpkdapcG1bWCOk=SWHfKvpPMdBiEu0QOj4M+Zbx11Xhc59cA@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <7d73f52d-e6e3-296c-ea87-6a0cf43afb0f@ti.com>
Date:   Fri, 11 Jan 2019 16:26:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdapcG1bWCOk=SWHfKvpPMdBiEu0QOj4M+Zbx11Xhc59cA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 11/01/19 3:08 PM, Linus Walleij wrote:
> On Thu, Jan 3, 2019 at 4:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
>> automatic base selection") the gpiochip label no longer has an ID
>> suffix. Update the GPIO lookup entries.
>>
>> Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I suppose you will push this upstream through ARM SoC.

I sent a pull request with these applied to ARM SoC yesterday.

Thanks,
Sekhar
