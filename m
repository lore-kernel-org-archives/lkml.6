Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11677C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF87B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfBYHBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 02:01:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbfBYHBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 02:01:24 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 50F5EDFC155A78FE80C5;
        Mon, 25 Feb 2019 14:59:23 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 25 Feb
 2019 14:59:14 +0800
Subject: Re: [PATCH 2/2] staging: erofs: switch to ->iterate_shared()
To:     Chao Yu <yuchao0@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190221023411.2980-1-gaoxiang25@huawei.com>
 <20190221023411.2980-2-gaoxiang25@huawei.com>
 <9ba14947-f891-33c6-278c-7d75bd07befd@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <28d42ed8-8e6d-1eeb-76f3-1f0503aae9d0@huawei.com>
Date:   Mon, 25 Feb 2019 14:58:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <9ba14947-f891-33c6-278c-7d75bd07befd@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/25 9:36, Chao Yu wrote:
> On 2019/2/21 10:34, Gao Xiang wrote:
>> After commit 6192269444eb ("introduce a parallel variant of ->iterate()"),
>> readdir can be done without taking exclusive inode lock of course.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for review :)

> 
> Thanks,
> 
