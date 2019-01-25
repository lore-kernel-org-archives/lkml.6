Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D12C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2DB20881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfAYNy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:54:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfAYNy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:54:56 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A91BF4D01003F3740F2E;
        Fri, 25 Jan 2019 21:54:53 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 25 Jan
 2019 21:54:46 +0800
Subject: Re: [PATCH 2/2] staging: erofs: complete POSIX ACL support
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190125115103.47250-1-gaoxiang25@huawei.com>
 <20190125120104.15604-1-gaoxiang25@huawei.com> <20190125133044.GC1795@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c3007962-c73f-ddfc-eb39-d8d8b5fef832@huawei.com>
Date:   Fri, 25 Jan 2019 21:54:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190125133044.GC1795@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2019/1/25 21:30, Dan Carpenter wrote:
> On Fri, Jan 25, 2019 at 08:01:04PM +0800, Gao Xiang wrote:
>> Let's add .get_acl() to read the file's acl
>> from its xattrs to make POSIX ACL usable.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  This [PATCH 2/2] currently hasn't tested, please ignore temporarily...
>>  I will test it asap...
> 
> This is an awkward thing.
> 
> Just don't send it until after you test it.  We also ignore RFC patches
> so if you mark it as RFC that will be ignored if you want.

Yes, you are right.

Actually I just want to send the only [PATCH 1/2], but I missed to
change the subject of [PATCH 1/2] -> [PATCH]...Therefore I have to
send this incomplete one to complete this "patchset" by mistake...

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
