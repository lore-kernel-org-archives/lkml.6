Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeEOJe2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:34:28 -0400
Received: from foss.arm.com ([217.140.101.70]:57012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeEOJe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:34:26 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] firmware: xilinx: Add query data API
To: Jolly Shah <JOLLYS@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-5-git-send-email-jollys@xilinx.com>
 <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
 <SN1PR02MB37587E3AB2718E1DB510E35AB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <ab9632f5-882d-462d-d830-0316cad56baf@arm.com>
Date: Tue, 15 May 2018 10:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <SN1PR02MB37587E3AB2718E1DB510E35AB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/18 20:16, Jolly Shah wrote:
> HI Sudeep,
> 

[...]

>> 
>> Can you give more insight into this ? How will be this used ? How
>> this aligns with data we get from DT ? I am just trying to
>> understand how is this information split between this API and DT
>> for example.
>> 
> 
> This API is used to get clock information from firmware and register
> clocks accordingly in driver. In our case, firmware maintains
> database of all clocks available on chip. DT will provide information
> for off chip reference clocks only. This is to avoid duplication of
> clocks data in DT and firmware both as firmware anyways need clock
> data to manage them.
> 

I wanted to understand the difference with example. What kind of
information you get from DT and what you get from firmware ?

-- 
Regards,
Sudeep
