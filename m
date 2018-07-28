Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1641C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C55B205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C55B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeG1MAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 08:00:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727344AbeG1MAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 08:00:03 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 80AA6E26FE4DB;
        Sat, 28 Jul 2018 18:33:56 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Sat, 28 Jul 2018
 18:33:51 +0800
Subject: Re: [PATCH 00/25] staging: erofs: introduce erofs file system
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <gaoxiang25@huawei.com>
CC:     <devel@driverdev.osuosl.org>, <hsiangkao@aol.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <miaoxie@huawei.com>, <chao@kernel.org>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
 <20180728072548.GA1500@kroah.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1865a267-c8fe-50c9-3178-e203bb946c5d@huawei.com>
Date:   Sat, 28 Jul 2018 18:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180728072548.GA1500@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 2018/7/28 15:25, Greg Kroah-Hartman wrote:
> 
> Thanks for submitting this, the filesystem looks very interesting.  I've
> queued it all up now in the staging-next tree.

Thanks very much for queuing erofs filesystem, that's actually excellent news
for us that it can be upstreamed so quickly, I think it will help to attract
more developers or users' attention on the filesystem, it should be beneficial
to its growing. Anyway, hoping it can bring something different on experience of
user in linux. :)

Thanks,

> 
> greg k-h
> 
> .
> 

