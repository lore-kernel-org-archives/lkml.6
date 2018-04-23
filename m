Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeDWSNT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:13:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19655 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeDWSNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:13:17 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 23 Apr 2018 11:13:17 -0700
Subject: Re: [PATCH] mfd: tps65911-comparator: Fix a build error
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Lee Jones <lee.jones@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20180420092105.GA28058@mwanda>
From: Rhyland Klein <rklein@nvidia.com>
Message-ID: <df8e9468-4099-5248-3f5a-59550aa830a9@nvidia.com>
Date: Mon, 23 Apr 2018 14:13:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180420092105.GA28058@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/2018 5:21 AM, Dan Carpenter wrote:
> In 2012, we changed the tps65910 API and fixed most drivers but forgot
> to update this one.
> 
> Fixes: 3f7e82759c69 ("mfd: Commonize tps65910 regmap access through header")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

LGTM

Acked-by: Rhyland Klein <rklein@nvidia.com>


-- 
nvpublic
