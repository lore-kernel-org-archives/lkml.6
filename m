Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeEOGDL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:03:11 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:11684 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeEOGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:03:09 -0400
Subject: Re: [PATCH 1/3] ARM: dra762: hwmod: Add MCAN support
To: Tony Lindgren <tony@atomide.com>
CC: <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <bcousson@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <paul@pwsan.com>,
        <lokeshvutla@ti.com>, <linux@armlinux.org.uk>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
 <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
 <20180501152615.GB98604@atomide.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <b4d95a08-82fd-9f39-53e7-977351788c88@ti.com>
Date: Tue, 15 May 2018 11:34:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501152615.GB98604@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tuesday 01 May 2018 08:56 PM, Tony Lindgren wrote:
> Hi,
> 
> * Faiz Abbas <faiz_abbas@ti.com> [180408 09:59]:
>> From: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> Add MCAN hwmod data and register it for dra762 silicons.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index 62352d1..a2cd7f8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -1356,6 +1356,29 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
>>  };
>>  
>>  /*
>> + * 'mcan' class
>> + *
>> + */
>> +static struct omap_hwmod_class dra76x_mcan_hwmod_class = {
>> +	.name	= "mcan",
>> +};
> 
> Looks like you're missing the related struct omap_hwmod_class_sysconfig
> entry for this with the rev and sysconfig registers.
> 

Sorry, I missed this email earlier. The MCAN module doesn't have
sysconfig registers.

Thanks,
Faiz
