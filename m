Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeEOXLw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:11:52 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:23142 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeEOXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:11:51 -0400
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw-phy-sel: check
 bus_find_device() ret value
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
References: <20180515230149.6547-1-grygorii.strashko@ti.com>
 <CAHp75VdXjiis9R6a1EZO9q3fawB_nSmJhqRSvv_7yggTr-EBOA@mail.gmail.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <623a9ea1-3caa-3eeb-718b-e1e82fbfa87f@ti.com>
Date: Tue, 15 May 2018 18:11:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdXjiis9R6a1EZO9q3fawB_nSmJhqRSvv_7yggTr-EBOA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2018 06:07 PM, Andy Shevchenko wrote:
> On Wed, May 16, 2018 at 2:01 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> This fixes klockworks warnings: Pointer 'dev' returned from call to
>> function 'bus_find_device' at line 179 may be NULL and will be dereferenced
>> at line 181.
> 
>> +               dev_err(dev, "unable to find platform device for %s\n",
>> +                       of_node_full_name(node));
> 
> Sorry, isn't %pOF works for this?
> 

Thanks, will update.

-- 
regards,
-grygorii
