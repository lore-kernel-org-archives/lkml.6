Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeBBRco (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:32:44 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:25784 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbeBBRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:25:15 -0500
Subject: Re: [PATCH 0/2] I2C-DaVinci: Adjustments for davinci_i2c_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <310d5f2c-3a8d-80e3-a185-21da933d107f@ti.com>
Date: Fri, 2 Feb 2018 11:24:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.247.59.147]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2018 11:20 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 2 Feb 2018 18:16:14 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>    Delete an error message for a failed memory allocation
>    Improve a size determination
> 
>   drivers/i2c/busses/i2c-davinci.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
