Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qa3zi/at"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE31960860
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeFFKMw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:12:52 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:37127 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeFFKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:12:50 -0400
Subject: Re: [PATCH v3 0/6] Add MCAN Support for dra76x
To: Tony Lindgren <tony@atomide.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>, <paul@pwsan.com>, <t-kristo@ti.com>,
        <mark.rutland@arm.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606100937.GF5738@atomide.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <be94f43a-57a9-3e17-3753-9f53d854b42f@ti.com>
Date: Wed, 6 Jun 2018 15:43:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180606100937.GF5738@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 06 June 2018 03:39 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180606 06:09]:
>> The following patches add dts and sysconfig support
>> for MCAN on TI's dra76 SOCs
>>
>> The patches depend on the following series:
>> https://patchwork.kernel.org/patch/10221105/
>>
>> Changes in v3:
>>  1. Added reset functionality to the ti-sysc
>>     driver. This enables me to drop the hwmod
>>     data patch as everything is being done in dt.
>>
>>  2. Dropped ti,hwmods from the dts nodes
> 
> Cool good to hear that works :)
> 
>>  4. Removed the status="disabled" in dtsi
>>     followed by status="okay" in dts.
> 
> Hmm okay is the default and is not needed. I did not notice
> okay in this set based on a quick glance so maybe you already
> dropped it?

I guess that wasn't clear. I meant to say I have dropped both
status=disabled and status=okay because okay is default.

Thanks,
Faiz
