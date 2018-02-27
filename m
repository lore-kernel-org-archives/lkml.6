Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeB0KcI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:32:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752757AbeB0KcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:32:07 -0500
Subject: Re: [PATCH 3/5] f2fs: set readdir_ra by default
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180226174731.26679-3-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <25e6ede2-6735-91b7-f68d-6e80e19095d4@huawei.com>
Date: Tue, 27 Feb 2018 18:35:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180226174731.26679-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> It gives general readdir improvement.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
