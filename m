Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C382FC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FAE20891
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FAE20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeG1K7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:59:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbeG1K7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:59:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0A4367ECEDB6B;
        Sat, 28 Jul 2018 17:33:52 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.382.0; Sat, 28 Jul
 2018 17:33:43 +0800
Subject: Re: [PATCH 00/25] staging: erofs: introduce erofs file system
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <hsiangkao@aol.com>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <miaoxie@huawei.com>,
        <chao@kernel.org>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
 <20180728072548.GA1500@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <17c86277-323d-deec-6a8d-b625d519b811@huawei.com>
Date:   Sat, 28 Jul 2018 17:33:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180728072548.GA1500@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/28 15:25, Greg Kroah-Hartman wrote:
> Thanks for submitting this, the filesystem looks very interesting.  I've
> queued it all up now in the staging-next tree.

Thanks for applying, we are continuously optimizing further and hope to attract more fs guys :)

Thanks,
Gao Xiang
