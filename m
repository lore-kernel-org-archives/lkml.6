Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeB0Kbf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:31:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53775 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752390AbeB0Kbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:31:34 -0500
Subject: Re: [PATCH 2/5] f2fs: add auto tuning for small devices
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180226174731.26679-2-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <38b99899-2e29-4f80-9552-8506900ebc96@huawei.com>
Date: Tue, 27 Feb 2018 18:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180226174731.26679-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> If f2fs is running on top of very small devices, it's worth to avoid abusing
> free LBAs. In order to achieve that, this patch introduces some parameter
> tuning.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
