Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeDZFm3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:42:29 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:44888 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeDZFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:42:26 -0400
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <20180425132746.13911-1-kishon@ti.com>
 <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2d03fa36-5fa1-322c-cc82-2dc3749dcaa3@ti.com>
Date: Thu, 26 Apr 2018 11:12:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 25 April 2018 11:10 PM, Santosh Shilimkar wrote:
> On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>> binding.
>>
>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>> Everyone who use a custom .config should also enable
>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>
>> This series should be merged only after [1]
>> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
>>
> Keep me posted once the dependency gets merged.

sure.

Regards
Kishon
