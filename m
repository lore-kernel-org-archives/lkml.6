Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeB0KcV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:32:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53980 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752695AbeB0KcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:32:19 -0500
Subject: Re: [PATCH 4/5] f2fs: issue discard aggressively in the gc_urgent
 mode
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180226174731.26679-4-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <bbf2f777-0a34-7bf7-3e3b-7e2bfb29729c@huawei.com>
Date: Tue, 27 Feb 2018 18:36:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180226174731.26679-4-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> This patch avoids to skip discard commands when user sets gc_urgent mode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
