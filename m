Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeECSw6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:52:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeECSwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:52:54 -0400
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
References: <20180425132746.13911-1-kishon@ti.com>
 <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
 <0481f6f0-539e-4809-63cd-1134367a7b78@ti.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <de0bd46a-21d4-14de-9695-9b0f3996dacb@oracle.com>
Date: Thu, 3 May 2018 11:52:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0481f6f0-539e-4809-63cd-1134367a7b78@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=20 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=879
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/18 4:57 AM, Kishon Vijay Abraham I wrote:
> Hi Santosh,
> 
> On Wednesday 25 April 2018 11:10 PM, Santosh Shilimkar wrote:
>> On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
>>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>>> binding.
>>>
>>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>>> Everyone who use a custom .config should also enable
>>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>>
>>> This series should be merged only after [1]
>>> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
>>>
>> Keep me posted once the dependency gets merged.
> 
> Ulf has merged the sdhci part and has shared an immutable branch
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdhci_omap
> with his signed tag sdhci-omap-v4.17-rc3.
> 
> Can you use it as a base for merging this series?
> 
How about I apply only DTS patches and exlude config file update ?
You can send the config patch after the merge window. Are the DTS
changes also going to break anything without basing of this sdhci
branch ?
