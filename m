Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CFAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8154214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfAIG35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:29:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729721AbfAIG35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:29:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85164E47F7A8699C93ED;
        Wed,  9 Jan 2019 14:29:54 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 9 Jan 2019
 14:29:47 +0800
Subject: Re: [PATCH v2] staging: erofs: Add identifier for function definition
 arguments
To:     Sidong Yang <realwakka@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20190108132454.20513-1-realwakka@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a963e1ed-2b59-fee2-cadc-d487c7c301a1@huawei.com>
Date:   Wed, 9 Jan 2019 14:29:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190108132454.20513-1-realwakka@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/8 21:24, Sidong Yang wrote:
> Add identifier for function definition arguments in xattr_iter_handlers,
> this change clears the checkpatch.pl issue and make code more explicit.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

