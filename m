Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6A420855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6A420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeIJOpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:45:00 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49331 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:45:00 -0400
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="19658441"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Sep 2018 02:51:46 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Mon, 10 Sep 2018
 02:51:46 -0700
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
To:     Lee Jones <lee.jones@linaro.org>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <jslaby@suse.com>,
        <richard.genoud@gmail.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <akpm@linux-foundation.org>,
        <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180910094817.GJ28860@dell>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <2a8ccc95-bbf0-2211-0f88-c5a594600d34@microchip.com>
Date:   Mon, 10 Sep 2018 11:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910094817.GJ28860@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 10/09/2018 at 11:48, Lee Jones wrote:
> On Tue, 04 Sep 2018, Radu Pirea wrote:
>> Well, this is the 12th version of this patch series.
>> In this version I fixed a warning from kbuild-robot and I have no idea
>> how I forgot to add static in declaration of that functions. Also I
>> fixed the example for the SPI driver in bindings.
> 
> Okay great.  So which patches still require Acks?

None I would say: everything's ready to be integrated into your MFD tree 
as you proposed some time ago.

We are looking forward seeing this series integrated in linux-next as 
soon as possible.

Best regards,
   Nicolas


>> Radu Pirea (6):
>>    MAINTAINERS: add at91 usart mfd driver
>>    dt-bindings: add binding for atmel-usart in SPI mode
>>    mfd: at91-usart: added mfd driver for usart
>>    MAINTAINERS: add at91 usart spi driver
>>    spi: at91-usart: add driver for at91-usart as spi
>>    tty/serial: atmel: change the driver to work under at91-usart mfd
> 


-- 
Nicolas Ferre
