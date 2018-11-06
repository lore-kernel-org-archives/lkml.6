Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05923C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D6920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D6920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbeKFSgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:36:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729326AbeKFSgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:36:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77E9B9BBDA231;
        Tue,  6 Nov 2018 17:12:06 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 6 Nov 2018
 17:12:02 +0800
Subject: Re: [PATCH] f2fs: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Yangtao Li <tiny.windzz@gmail.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20181105144148.6131-1-tiny.windzz@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6e82c94f-eb28-985d-7c67-5dbb6042291f@huawei.com>
Date:   Tue, 6 Nov 2018 17:12:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181105144148.6131-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/5 22:41, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

