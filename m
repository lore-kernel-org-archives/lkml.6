Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3581C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2E120821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2E120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeJaM3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:29:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728970AbeJaM3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:29:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CFB8A4F779A22;
        Wed, 31 Oct 2018 11:32:57 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 31 Oct 2018
 11:32:48 +0800
Subject: Re: [PATCH v2] f2fs: change segment to section in f2fs_ioc_gc_range
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1540391736-20714-1-git-send-email-yunlong.song@huawei.com>
 <1540903075-62916-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d7822529-c830-dfbe-80c3-470f5ef57d4d@huawei.com>
Date:   Wed, 31 Oct 2018 11:32:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540903075-62916-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 20:37, Yunlong Song wrote:
> f2fs_ioc_gc_range skips blocks_per_seg each time, however, f2fs_gc moves
> blocks of section each time, so fix it from segment to section.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

