Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeAaNeE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:34:04 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47947 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751700AbeAaNeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:34:02 -0500
Subject: Re: [PATCH v2] ACPI / tables: Add IORT to injectable table list
To: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC: "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
References: <1516695922-15045-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <1517276662.2652.12.camel@hxt-semitech.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <74324d8a-c144-5b21-bea1-9f2e1b891c0f@huawei.com>
Date: Wed, 31 Jan 2018 21:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517276662.2652.12.camel@hxt-semitech.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shunyong,

On 2018/1/30 9:44, Yang, Shunyong wrote:
> Hi, Rafael
> 
> Could you please help to review this patch? This is a small change to
> add ACPI_SIG_IORT to table_sigs[]. 
> Loading IORT table from initrd is very useful to debug SMMU node/device
> probe, MSI allocation, stream id translation and verifying IORT table
> from firmware. So, I add this.

It's true, mappings in IORT will be easy getting wrong, so it would be
good to test it without updating the firmware.

But I think you'd better to add your comment about why you need
IORT in the commit message in your patch, that will be useful
to convince Rafael to take your patch.

Thanks
Hanjun
