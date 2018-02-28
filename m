Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeB1JaI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:30:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751707AbeB1JaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:30:06 -0500
Subject: Re: [PATCH 1/5 v2] f2fs: add mount option for segment allocation
 policy
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180228050925.GC81737@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c0e41426-1116-8ded-0399-de9c8201b5a4@huawei.com>
Date: Wed, 28 Feb 2018 17:33:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180228050925.GC81737@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/28 13:09, Jaegeuk Kim wrote:
> Change log from v1:
>  - add doc :)
> 
> This patch adds an mount option, "alloc_mode=%s" having two options, "default"
> and "reuse".
> 
> In "alloc_mode=reuse" case, f2fs starts to allocate segments from 0'th segment
> all the time to reassign segments. It'd be useful for small-sized eMMC parts.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
