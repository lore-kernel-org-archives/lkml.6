Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C42C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EDD214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfA2IEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:04:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbfA2IEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:04:33 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9343E980716906195192;
        Tue, 29 Jan 2019 16:04:30 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 29 Jan
 2019 16:04:23 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chao Yu <chao@kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, <linux-erofs@lists.ozlabs.org>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
 <1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org>
 <20190128183053.GK1795@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <8dbd81b4-48c2-4e0c-85c7-c3bfb12785ba@huawei.com>
Date:   Tue, 29 Jan 2019 16:03:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190128183053.GK1795@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/1/29 2:30, Dan Carpenter wrote:
> Are you serious?  The standard fault injection doesn't do that???
> 
> Please fix it instead of creating a duplicate better implementation
> which only your filesystem can use.  I would have thought that obviously
> any fault injection framework could at least be configured to test
> specific code...
> 
> regards,
> dan carpenter

Since Chao is now on the short business trip, I will resend v4 and change
erofs_kmalloc into kmalloc temporarily to make sure ACL is usable first
in the staging tree.

As for the EROFS fault injection, let's wait Chao's reply...

Thanks,
Gao Xiang
