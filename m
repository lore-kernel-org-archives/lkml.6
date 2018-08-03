Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EFEC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5820721707
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5820721707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeHCDNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:13:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731119AbeHCDNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:13:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 12C0C9FE2B96E;
        Fri,  3 Aug 2018 09:19:42 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 3 Aug 2018
 09:19:34 +0800
Subject: Re: [PATCH v3] staging: erofs: disable compiling temporarile
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Chao Yu <chao@kernel.org>, <devel@driverdev.osuosl.org>,
        <sfr@canb.auug.org.au>, Chao Yu <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20180802143455.9214-1-chao@kernel.org>
 <20180802173319.GB24125@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <ffd4bed0-65dc-45c7-9c91-b76d830a7db6@huawei.com>
Date:   Fri, 3 Aug 2018 09:18:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180802173319.GB24125@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/8/3 1:33, Greg KH wrote:
> Sorry, I already took the first version in my tree.  Don't worry about
> it for now you can fix this up after 4.19-rc1 is out when we enable the
> filesystem again.
> 

OK, We will fix it and enable erofs after 4.19-rc1 is out. :)

Thanks,
Gao Xiang

> thanks,
> 
> greg k-h
