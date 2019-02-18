Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50084C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9E62184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfBRJMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:12:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbfBRJMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:12:33 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5EAC4C7263E82816E168;
        Mon, 18 Feb 2019 17:12:31 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 17:12:21 +0800
Subject: Re: [PATCH] f2fs: correct spelling mistake
To:     Zeng Guangyue <zengguangyue@hisilicon.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <zangleigang@hisilicon.com>, <kid.jin@hisilicon.com>
References: <20190218062641.104401-1-zengguangyue@hisilicon.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <52dd2489-2391-94b9-d46e-40757bcdc29e@huawei.com>
Date:   Mon, 18 Feb 2019 17:12:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190218062641.104401-1-zengguangyue@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/18 14:26, Zeng Guangyue wrote:
> correct spelling mistake for "nunmber"
> 
> Signed-off-by: Zeng Guangyue <zengguangyue@hisilicon.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

