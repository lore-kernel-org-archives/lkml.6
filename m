Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C9C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2A221855
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfAZCtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 21:49:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfAZCtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 21:49:19 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CECB52F01ACD01C94120;
        Sat, 26 Jan 2019 10:49:17 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Sat, 26 Jan 2019
 10:49:16 +0800
Subject: Re: [PATCH] f2fs: fix typos in code comments
To:     Geliang Tang <geliangtang@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <19c7195d323e7c6a4b03c1e584d070e60458b71f.1548401310.git.geliangtang@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9b3112e2-eb7d-8813-4769-353baa35dee0@huawei.com>
Date:   Sat, 26 Jan 2019 10:49:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <19c7195d323e7c6a4b03c1e584d070e60458b71f.1548401310.git.geliangtang@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/25 15:35, Geliang Tang wrote:
> lengh -> length
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

