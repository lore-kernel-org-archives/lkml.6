Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932086AbeE3Obp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752645AbeE3Obm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:31:42 -0400
Subject: Re: [PATCH] f2fs-tools: fix to ignore sg_write_buffer in git
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org,
        yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1527663829-144341-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <6876a6e2-4e22-1412-85d4-37fe88e2133c@kernel.org>
Date: Wed, 30 May 2018 22:31:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527663829-144341-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/30 15:03, Yunlong Song wrote:
> Add tools/sg_write_buffer/sg_write_buffer to .gitignore.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
