Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBBL4K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:56:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbeBBL4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:56:01 -0500
Subject: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
To: Yang Shunyong <shunyong.yang@hxt-semitech.com>, <rjw@rjwysocki.net>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Joey Zheng <yu.zheng@hxt-semitech.com>,
        "Wang Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        Jiang Yutang <yutang2.jiang@hxt-semitech.com>
References: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <68362a1f-cc0c-42f9-97da-bdf379c4f5a1@huawei.com>
Date: Fri, 2 Feb 2018 19:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/2 18:25, Yang Shunyong wrote:
> Loading IORT table from initrd is used to fix firmware IORT defects.

I don't think this fix "firmware defects", it just for debug purpose,
we will not use that for production purpose, right? I think above line
can be removed.

> Moreover, it is very useful to debug SMMU node/device probe, MSI
> allocation, stream id translation and IORT table from firmware. It
> is also very useful to enable SMMU and devices behind SMMU before
> firmware is ready.
> 
> This patch adds ACPI_SIG_IORT to the table, which enables IORT
> from initrd to override which from firmware.
> 
> Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> Cc: Jiang Yutang <yutang2.jiang@hxt-semitech.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>

With that updated,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
