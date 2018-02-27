Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeB0KaB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:30:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53353 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752090AbeB0KaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:30:00 -0500
Subject: Re: [PATCH 1/5] f2fs: add mount option for segment allocation policy
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <3dfa29d2-4a37-f2f2-648d-885dbda1cdf6@huawei.com>
Date: Tue, 27 Feb 2018 18:33:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> This patch adds an mount option, "alloc_mode=%s" having two options, "default"
> and "reuse".
> 
> In "alloc_mode=reuse" case, f2fs starts to allocate segments from 0'th segment
> all the time to reassign segments. It'd be useful for small-sized eMMC parts.

We needs to add Doc for this mount option. ;)

Thanks,
