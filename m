Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeFAJ2R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:28:17 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:50824 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeFAJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:28:12 -0400
From: Richard Weinberger <richard@sigma-star.at>
To: Gao Xiang <gaoxiang25@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, miaoxie@huawei.com,
        yuchao0@huawei.com, sunqiuyang@huawei.com, fangwei1@huawei.com,
        liguifu2@huawei.com, weidu.du@huawei.com, chen.chun.yen@huawei.com,
        brooke.wangzhigang@hisilicon.com, dongjinguang@huawei.com
Subject: Re: [NOMERGE] [RFC PATCH 00/12] erofs: introduce erofs file system
Date: Fri, 01 Jun 2018 11:28:07 +0200
Message-ID: <1670077.cnVahIradn@blindfold>
In-Reply-To: <aae078b7-c364-106a-dd56-91abc945d7bb@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com> <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com> <aae078b7-c364-106a-dd56-91abc945d7bb@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 1. Juni 2018, 11:11:21 CEST schrieb Gao Xiang:
> > In which sense is it extendable?
> 
> Actually, the meaning of an enhanced (means not just read-only, but with the scalable
> on-disk layout, compression, or fs-verify in the future) read-only file system is emphasized.

ah ok.
 
> We also think of other candidate full names, such as
> Enhanced / Extented Read-only File System, all the names short for "erofs" are okay.

TBH, I read "erofs" as "error fs". ;-)

> > How does it compare to existing read only filesystems, such as squashfs?
> > 
> 
> You are quite right.
> 
> We are now focusing on improving our decompression subsystem and
> these numbers will be successively added in the future non-RFC patches.
> 
> We haven't pay much attention on comparing squashfs and erofs
> yet since we once tried to use squashfs on our products with
> different block sizes several years ago, it behaves
> unacceptable in the low free memory scenario besides its
> performance.

I'm interested in the comparison because I use squashfs often
for embedded devices on top of ubiblock (raw nand).
If there is something that can do better, I'm all for it.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
