Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC392217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfADChf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:37:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfADChe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:37:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2D10D33A197CA;
        Fri,  4 Jan 2019 10:37:31 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 10:37:24 +0800
Subject: Re: [PATCH -next] f2fs: remove set but not used variable 'err'
To:     YueHaibing <yuehaibing@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <1546565909-17400-1-git-send-email-yuehaibing@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e879debb-e000-3f97-9b99-e7e84d167903@huawei.com>
Date:   Fri, 4 Jan 2019 10:37:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1546565909-17400-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/4 9:38, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/f2fs/data.c: In function 'f2fs_dio_submit_bio':
> fs/f2fs/data.c:2585:6: warning:
>  variable 'err' set but not used [-Wunused-but-set-variable]
> 
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

