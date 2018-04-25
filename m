Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756010AbeDYRk0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:40:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37512 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755976AbeDYRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:40:23 -0400
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
References: <20180425132746.13911-1-kishon@ti.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
Date: Wed, 25 Apr 2018 10:40:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425132746.13911-1-kishon@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=751
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
> binding.
> 
> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
> Everyone who use a custom .config should also enable
> CONFIG_MMC_SDHCI_OMAP for MMC to work.
> 
> This series should be merged only after [1]
> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
> 
Keep me posted once the dependency gets merged.

Regards,
Santosh
