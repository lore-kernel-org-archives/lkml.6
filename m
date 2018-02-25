Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeBYPSk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 10:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbeBYPSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 10:18:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A85821736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant initialization of
 pointer 'p'
To: Colin King <colin.king@canonical.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180221181340.7596-1-colin.king@canonical.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <d7d316b1-7e55-115c-0c45-f381ce774bee@kernel.org>
Date: Sun, 25 Feb 2018 23:17:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221181340.7596-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/22 2:13, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer p is initialized with a value that is never read and is later
> re-assigned a new value, hence the initialization is redundant and can
> be removed.
> 
> Cleans up clang warning:
> fs/f2fs/extent_cache.c:463:19: warning: Value stored to 'p' during
> its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
