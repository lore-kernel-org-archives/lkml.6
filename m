Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754401AbeEaKPH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:15:07 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:62972 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeEaKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:15:04 -0400
Subject: Re: [PATCH v2 4/6] bus: ti-sysc: Add support for using ti-sysc for
 MCAN on dra76x
To: Tony Lindgren <tony@atomide.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>, <paul@pwsan.com>, <t-kristo@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-5-faiz_abbas@ti.com> <20180530145726.GD5705@atomide.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <0b627ab6-59f1-4a4f-42d2-5d6846adfe0b@ti.com>
Date: Thu, 31 May 2018 15:46:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530145726.GD5705@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 30 May 2018 08:27 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
>> The dra76x MCAN generic interconnect module has a its own
>> format for the bits in the control registers.
...
>>  static int sysc_init_pdata(struct sysc *ddata)
>>  {
>>  	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
>> @@ -1441,6 +1457,7 @@ static const struct of_device_id sysc_match[] = {
>>  	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
>>  	{ .compatible = "ti,sysc-usb-host-fs",
>>  	  .data = &sysc_omap4_usb_host_fs, },
>> +	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
>>  	{  },
>>  };
> 
> Looks good to me. And presumably you checked that no other dra7 modules
> use sysconfig register bit layout like this?
> 

As far as I could see, Yes.

Thanks,
Faiz
