Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBA5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C3120846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C3120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeFUGJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:09:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47644 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750846AbeFUGJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:09:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BFAEFBEC49097;
        Thu, 21 Jun 2018 14:09:22 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Thu, 21 Jun 2018
 14:08:20 +0800
Subject: Re: [PATCH] f2fs: use timespec64 for inode timestamps
To:     Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <y2038@lists.linaro.org>, Sheng Yong <shengyong1@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Yunlei He <heyunlei@huawei.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Yunlong Song <yunlong.song@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180620080603.4156809-1-arnd@arndb.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cda86b47-c61d-121e-a353-97f3e5447bb7@huawei.com>
Date:   Thu, 21 Jun 2018 14:08:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620080603.4156809-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/20 16:02, Arnd Bergmann wrote:
> The on-disk representation and the vfs both use 64-bit tv_sec values,
> so let's change the last missing piece in the middle.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

