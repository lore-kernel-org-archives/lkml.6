Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDCCm0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:42:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60725 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751476AbeDCCmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:42:25 -0400
Subject: Re: [PATCH] f2fs: make assignment of t->dentry_bitmap more readable
To: Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1522671740-92824-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <b68f7f6c-0a3b-f1f2-41a0-2b03c7681944@huawei.com>
Date: Tue, 3 Apr 2018 10:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1522671740-92824-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/2 20:22, Yunlong Song wrote:
> In make_dentry_ptr_block, it is confused with "&" for t->dentry_bitmap
> but without "&" for t->dentry, so delete "&" to make code more readable.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
