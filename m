Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbeDWIWQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:22:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59759 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753109AbeDWIWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:22:13 -0400
Subject: Re: [PATCH] Revert "f2fs: introduce f2fs_set_page_dirty_nobuffer"
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180421040825.77660-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <7529231e-e567-34dc-e649-41b0ce284d9c@huawei.com>
Date: Mon, 23 Apr 2018 16:22:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180421040825.77660-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/21 12:08, Jaegeuk Kim wrote:
> This patch reverts copied f2fs_set_page_dirty_nobuffer to use generic function
> for stability.
> 
> This reverts commit fe76b796fc5194cc3d57265002e3a748566d073f.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
