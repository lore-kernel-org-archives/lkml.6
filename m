Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBDAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74831219C5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74831219C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHFDtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 23:49:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbeHFDtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 23:49:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A19BD9EA3C94A;
        Mon,  6 Aug 2018 09:43:10 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 09:43:03 +0800
Subject: Re: [PATCH] staging: erofs: fix if assignment style issue
To:     =?UTF-8?Q?Kristaps_=c4=8civkulis?= <kristaps.civkulis@gmail.com>,
        <gaoxiang25@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20180805152101.11657-1-kristaps.civkulis@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a9f41baa-2ba0-dbe0-a521-4d7d9177d319@huawei.com>
Date:   Mon, 6 Aug 2018 09:43:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805152101.11657-1-kristaps.civkulis@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/5 23:21, Kristaps Čivkulis wrote:
> Fix coding style issue "do not use assignment in if condition"
> detected by checkpatch.pl.
> 
> Signed-off-by: Kristaps Čivkulis <kristaps.civkulis@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Thanks,

