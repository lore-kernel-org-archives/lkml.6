Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754851AbeBPIl7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:41:59 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:43579 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754775AbeBPIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:41:57 -0500
X-IronPort-AV: E=Sophos;i="5.46,519,1511852400";
   d="scan'208";a="11426112"
Subject: Re: [PATCH] crypto: atmel: Delete error messages for a failed memory
 allocation in six functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        <linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
CC: <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <77cf1006-966d-78a9-0fdc-b53ccdd80df2@users.sourceforge.net>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <285d8666-5992-cccb-6c91-e83e85947a7d@microchip.com>
Date: Fri, 16 Feb 2018 10:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <77cf1006-966d-78a9-0fdc-b53ccdd80df2@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2018 02:24 PM, SF Markus Elfring wrote:
> From: Markus Elfring<elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 11:38:30 +0100
> 
> Omit extra messages for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
