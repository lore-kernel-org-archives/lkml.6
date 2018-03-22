Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCVCYG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:24:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40262 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751783AbeCVCYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:24:04 -0400
Subject: Re: [PATCH v2] f2fs: no need to initialize zero value for
 GFP_F2FS_ZERO
To: Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1521635131-137071-1-git-send-email-yunlong.song@huawei.com>
 <1521684520-142131-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <927273dc-ed76-5127-6175-02364952c36f@huawei.com>
Date: Thu, 22 Mar 2018 10:23:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1521684520-142131-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/22 10:08, Yunlong Song wrote:
> Since f2fs_inode_info is allocated with flag GFP_F2FS_ZERO, so we do not
> need to initialize zero value for its member any more.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
