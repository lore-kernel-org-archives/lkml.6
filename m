Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754902AbeDDBRC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 21:17:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753124AbeDDBRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 21:17:00 -0400
Subject: Re: [PATCH] f2fs: remove unmatched zero_user_segment when convert
 inline dentry
To: Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1522755761-131554-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <8c280631-71a6-4432-898e-1662b2c6c8a7@huawei.com>
Date: Wed, 4 Apr 2018 09:16:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1522755761-131554-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/3 19:42, Yunlong Song wrote:
> Since the layout of regular dentry block is different from inline dentry
> block, zero_user_segment starting from MAX_INLINE_DATA(dir) is not
> correct for regular dentry block, besides, bitmap is already copied and
> used, so there is no necessary to zero page at all, so just remove the
> zero_user_segment is OK.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
