Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031001AbeEZBQm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 21:16:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50302 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030816AbeEZBQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 21:16:41 -0400
Subject: Re: [RFC PATCH] f2fs: add fsync_mode=nobarrier for non-atomic files
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180526010414.66014-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6bc5d3c2-811e-eb52-9148-abf79b61256a@huawei.com>
Date: Sat, 26 May 2018 09:16:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180526010414.66014-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/26 9:04, Jaegeuk Kim wrote:
> For non-atomic files, this patch adds an option to give nobarrier which
> doesn't issue flush commands to the device.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
