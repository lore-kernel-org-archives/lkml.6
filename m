Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D1EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B59F20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B59F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeIYNtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:49:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbeIYNtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:49:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7AE9990F19C9C;
        Tue, 25 Sep 2018 15:42:12 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Tue, 25 Sep 2018
 15:42:12 +0800
Subject: Re: [f2fs-dev][PATCH] f2fs: fix remount problem of option io_bits
To:     Chengguang Xu <cgxu519@gmx.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180922144309.1969-1-cgxu519@gmx.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b3b7f158-97ef-ed7f-1287-e0d461be473b@huawei.com>
Date:   Tue, 25 Sep 2018 15:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180922144309.1969-1-cgxu519@gmx.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/22 22:43, Chengguang Xu wrote:
> Currently we show mount option "io_bits=%u" as "io_size=%uKB",
> it will cause option parsing problem(unrecognized mount option)
> in remount.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

