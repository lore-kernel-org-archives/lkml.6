Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeE3Ob3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbeE3Ob0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:31:26 -0400
Subject: Re: [PATCH rebase] f2fs-tools: fix overflow bug of start_sector when
 computing zone_align_start_offset
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org,
        yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1527322189-114752-1-git-send-email-yunlong.song@huawei.com>
 <1527663509-143986-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <2c8079d6-af80-52c0-5359-6c09c6cab416@kernel.org>
Date: Wed, 30 May 2018 22:30:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527663509-143986-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/30 14:58, Yunlong Song wrote:
> zone_align_start_offset should be u64, but config.start_sector is u32,
> so it may be overflow when computing zone_align_start_offset.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
