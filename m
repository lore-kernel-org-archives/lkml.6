Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeCFFqj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:46:39 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18380 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeCFFqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:46:38 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 05 Mar 2018 21:46:37 -0800
Subject: Re: [PATCH] spi: tegra20-slink: use true and false for boolean values
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>
References: <20180305235339.GA646@embeddedgus>
CC: <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <68fcf8c2-e312-eb76-09db-73d2b040b33a@nvidia.com>
Date: Tue, 6 Mar 2018 11:16:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180305235339.GA646@embeddedgus>
X-Originating-IP: [10.19.64.176]
X-ClientProxiedBy: DRBGMAIL103.nvidia.com (10.18.16.22) To
 bgmail102.nvidia.com (10.25.59.11)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 06 March 2018 05:23 AM, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
