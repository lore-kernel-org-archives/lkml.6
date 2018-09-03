Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FEB2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FEB2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeICGGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:06:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725762AbeICGGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:06:50 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15AE710C76688;
        Mon,  3 Sep 2018 09:48:56 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Mon, 3 Sep 2018
 09:48:47 +0800
Subject: Re: [PATCH 4/6] staging: erofs: formatting add spaces arround '*'
To:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Gao Xiang <gaoxiang25@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <ldv-project@linuxtesting.org>
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-4-git-send-email-zemlyanoy@ispras.ru>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9112fd55-d689-ff9a-b18b-b5a10293387a@huawei.com>
Date:   Mon, 3 Sep 2018 09:48:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535642042-5336-4-git-send-email-zemlyanoy@ispras.ru>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/30 23:14, Pavel Zemlyanoy wrote:
> This patch does not change the logic, it only
> corrects the formatting and checkpatch check by
> adding spaces around '*'.
> 
> The patch fixes 1 check of type:
> "Check: spaces preferred around that '*'".
> 
> Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

