Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeE3O3X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbeE3O3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:29:14 -0400
Subject: Re: [f2fs-dev] [PATCH 1/3] fs: f2fs: changed variable type of offset
 "unsigned" to "loff_t"
To: youngjun yoo <youngjun.willow@gmail.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20180529192114.GA7728@willow72>
From: Chao Yu <chao@kernel.org>
Message-ID: <1e99c70c-49b5-b109-d021-cb97af52c505@kernel.org>
Date: Wed, 30 May 2018 22:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529192114.GA7728@willow72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/30 3:21, youngjun yoo wrote:
> clean up checkpatch warning:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: youngjun yoo <youngjun.willow@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
