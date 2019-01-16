Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87452C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5866B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391593AbfAPJUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:20:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731474AbfAPJUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:20:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48FDB22363962AE585F8;
        Wed, 16 Jan 2019 17:20:12 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 16 Jan 2019
 17:20:03 +0800
Subject: Re: [PATCH 2/5] staging: erofs: localize erofs_workgroup_get
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190116085956.21004-1-gaoxiang25@huawei.com>
 <20190116085956.21004-2-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8dfe2593-270f-e8e6-e14b-bbc1291ab7dd@huawei.com>
Date:   Wed, 16 Jan 2019 17:20:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190116085956.21004-2-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/16 16:59, Gao Xiang wrote:
> Staticize erofs_workgroup_get since no external user
> out of utils.c directly calls erofs_workgroup_get.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

