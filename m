Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225ECECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB897214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB897214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeIQN7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:59:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728208AbeIQN7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:59:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 186B72C0F9274;
        Mon, 17 Sep 2018 16:33:22 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 16:33:18 +0800
Subject: Re: [PATCH] ext4: fix to propagate error from dquot_initialize()
To:     Wang Shilong <wangshilong1991@gmail.com>
CC:     Theodore Ts'o <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        "Ext4 Developers List" <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180917072246.25457-1-yuchao0@huawei.com>
 <CAP9B-QmoV0RtDMpuKhEAgg4Pq+38bbPoXwXWdkFV8DHzopW-8g@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2aad2a3c-f606-f511-8222-8e2e18b4a2ba@huawei.com>
Date:   Mon, 17 Sep 2018 16:33:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAP9B-QmoV0RtDMpuKhEAgg4Pq+38bbPoXwXWdkFV8DHzopW-8g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shilong,

On 2018/9/17 16:18, Wang Shilong wrote:
> Hi Chao,
> 
>    I sent a early patch  series which included this but forgot  to send to
> f2fs list..
> https://patchwork.ozlabs.org/patch/968759/

Oh, sorry, I didn't notice that one.

To all, please ignore this reduplicated one.

> 
> It looks Ted still have some questions for my first patch, so that second patch
> is not applied yet..
> 
> Thanks,
> 

