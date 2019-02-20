Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39130C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FFE20700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfBTKeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:34:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfBTKeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:34:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9C4289604F5342791FED;
        Wed, 20 Feb 2019 18:34:18 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 20 Feb
 2019 18:34:10 +0800
Subject: Re: [PATCH] staging: erofs: remove rcu_read_lock() in
 erofs_try_to_free_cached_page
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, Chao Yu <chao@kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190216084650.33841-1-gaoxiang25@huawei.com>
 <fc058e45-a645-c680-2ce0-19de83fffc2e@huawei.com>
 <20190220102026.GA32312@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <d26afca8-6efb-adfa-42ba-542b7949d4d8@huawei.com>
Date:   Wed, 20 Feb 2019 18:33:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190220102026.GA32312@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/20 18:20, Greg Kroah-Hartman wrote:
> On Wed, Feb 20, 2019 at 10:38:53AM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> Could you consider take some time on these two patches for linux-5.1-rc1?
>>  1) staging: erofs: fix race of initializing xattrs of a inode at the same time
>>  2) staging: erofs: remove rcu_read_lock() in erofs_try_to_free_cached_page
>>
>> It will be of great help, especially patch 1 (it could cause potential memleak
>> in the race condition without it).
> 
> Ok, I'll queue them up now, I was waiting for reviewed-by tags from
> others to show up :)

Thanks! :)
Gao Xiang

> 
> greg k-h
> 
