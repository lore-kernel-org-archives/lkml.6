Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeBHKCn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:02:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50881 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:02:42 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Hanjun Guo <guohanjun@huawei.com>,
        Yang Shunyong <shunyong.yang@hxt-semitech.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Jiang Yutang <yutang2.jiang@hxt-semitech.com>
Subject: Re: [PATCH v4] ACPI / tables: Add IORT to injectable table list
Date: Thu, 08 Feb 2018 11:00:58 +0100
Message-ID: <2093275.xlNqpblbep@aspire.rjw.lan>
In-Reply-To: <af8f2842-0999-d673-c908-bf3b4428fe67@huawei.com>
References: <1517899032-39073-1-git-send-email-shunyong.yang@hxt-semitech.com> <af8f2842-0999-d673-c908-bf3b4428fe67@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 6, 2018 8:18:02 AM CET Hanjun Guo wrote:
> On 2018/2/6 14:37, Yang Shunyong wrote:
> > Loading IORT table from initrd can be used to fix severe firmware
> > IORT defects temporarily before platform/BIOS vendor releases an
> > upgraded BIOS binary.
> > 
> > Moreover, it is very powerful to debug SMMU node/device probe, MSI
> > allocation, stream id translation and IORT table from firmware.
> > 
> > It is also very useful to enable SMMU and devices behind SMMU before
> > firmware is ready.
> > 
> > This patch adds ACPI_SIG_IORT to the table, which enables IORT
> > from initrd to override which from firmware.
> > 
> > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> > Cc: Jiang Yutang <yutang2.jiang@hxt-semitech.com>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> 
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Patch applied, thanks!
