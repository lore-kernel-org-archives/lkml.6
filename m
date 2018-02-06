Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeBFHUV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:20:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40252 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751924AbeBFHUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:20:15 -0500
Subject: Re: [PATCH v4] ACPI / tables: Add IORT to injectable table list
To: Yang Shunyong <shunyong.yang@hxt-semitech.com>, <rjw@rjwysocki.net>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Joey Zheng <yu.zheng@hxt-semitech.com>,
        "Wang Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        Jiang Yutang <yutang2.jiang@hxt-semitech.com>
References: <1517899032-39073-1-git-send-email-shunyong.yang@hxt-semitech.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <af8f2842-0999-d673-c908-bf3b4428fe67@huawei.com>
Date: Tue, 6 Feb 2018 15:18:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517899032-39073-1-git-send-email-shunyong.yang@hxt-semitech.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/6 14:37, Yang Shunyong wrote:
> Loading IORT table from initrd can be used to fix severe firmware
> IORT defects temporarily before platform/BIOS vendor releases an
> upgraded BIOS binary.
> 
> Moreover, it is very powerful to debug SMMU node/device probe, MSI
> allocation, stream id translation and IORT table from firmware.
> 
> It is also very useful to enable SMMU and devices behind SMMU before
> firmware is ready.
> 
> This patch adds ACPI_SIG_IORT to the table, which enables IORT
> from initrd to override which from firmware.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> Cc: Jiang Yutang <yutang2.jiang@hxt-semitech.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
