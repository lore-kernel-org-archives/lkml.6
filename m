Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCIBLm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 20:11:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751431AbeCIBLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 20:11:41 -0500
Subject: Re: [PATCH v3] f2fs: add nowait aio support
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>,
        Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Hyunchul Lee <cheol.lee@lge.com>
References: <1520505278-24735-1-git-send-email-hyc.lee@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <0ca9e2b7-eb63-65f3-ee70-a8cf5b90debf@huawei.com>
Date: Fri, 9 Mar 2018 09:11:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1520505278-24735-1-git-send-email-hyc.lee@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/8 18:34, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> This patch adds nowait aio support[1].
> 
> Return EAGAIN if any of the following checks fail for direct I/O:
>   - i_rwsem is not lockable
>   - Blocks are not allocated at the write location
> 
> And xfstests generic/471 is passed.
> 
>  [1]: 6be96d "Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT"
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
