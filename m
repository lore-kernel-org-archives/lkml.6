Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeB1Md7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:33:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752195AbeB1Md6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:33:58 -0500
Subject: Re: [PATCH v4] Revert "f2fs crypto: avoid unneeded memory allocation
 in ->readdir"
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <chao@kernel.org>, <yuchao0@huawei.com>, <yunlong.song@icloud.com>,
        <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
 <1519787857-107910-1-git-send-email-yunlong.song@huawei.com>
 <20180228054810.GB86647@jaegeuk-macbookpro.roam.corp.google.com>
From: Yunlong Song <yunlong.song@huawei.com>
Message-ID: <0a7fec6b-0f94-00f7-f5d4-8eac1f9cee73@huawei.com>
Date: Wed, 28 Feb 2018 20:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180228054810.GB86647@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/28 13:48, Jaegeuk Kim wrote:
> Hi Yunlong,
> 
> As Eric pointed out, how do you think using nohighmem for directory likewise
> ext4, which looks like more efficient?

OK, I have sent out another patch like this.

  Actually, we don't need to do this in
> most of recent kernels, right?
> 

Why? I have got this panic using arm with recent kernel.
