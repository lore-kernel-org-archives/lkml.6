Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E1CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF33020863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfBKJZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:25:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfBKJZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:25:15 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED7685E75737B8776189;
        Mon, 11 Feb 2019 17:25:09 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Feb 2019
 17:25:03 +0800
Subject: Re: linux-next: manual merge of the scsi-mkp tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190211153127.09756262@canb.auug.org.au>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e2f8faf4-143f-2d1d-efe8-bd30b593a2fd@huawei.com>
Date:   Mon, 11 Feb 2019 09:24:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190211153127.09756262@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2019 04:31, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>
> between commit:
>
>   7bb25a89aad2 ("scsi: hisi_sas: Set protection parameters prior to adding SCSI host")
>
> from Linus' tree and commit:
>
>   b3cce125cb1e ("scsi: hisi_sas: Add support for DIX feature for v3 hw")
>
> from the scsi-mkp tree.
>
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>

The merge looks ok, thanks

JFYI, I did mention in the relevant patchset cover letter that the 
series depends on commit 7bb25a89aad2 ("scsi: hisi_sas: Set protection 
parameters prior to adding SCSI host"), which was not on Martin's 5.1 
queue. The series seems to apply cleanly to that same branch without 
this patch.

John

