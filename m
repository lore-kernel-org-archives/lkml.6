Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934884AbeEJKLN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:11:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934275AbeEJKLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:11:12 -0400
Subject: Re: [PATCH 32/76] fs/f2fs: Use inode_sb() helper instead of
 inode->i_sb
To: Mark Fasheh <mfasheh@suse.de>, <linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>
References: <20180508180436.716-1-mfasheh@suse.de>
 <20180508180436.716-33-mfasheh@suse.de>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <2b1f84fe-6c2a-6e3e-44f3-31a1d11234d3@huawei.com>
Date: Thu, 10 May 2018 18:10:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180508180436.716-33-mfasheh@suse.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/9 2:03, Mark Fasheh wrote:
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
