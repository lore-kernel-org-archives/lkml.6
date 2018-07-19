Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77437ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B95720850
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B95720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeGSCgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 22:36:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730094AbeGSCgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 22:36:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 39AEDB71206AD;
        Thu, 19 Jul 2018 09:56:01 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 09:56:00 +0800
Subject: Re: [PATCH] f2fs: avoid duplicated permission check for "trusted."
 xattrs
To:     Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>,
        Hyunchul Lee <cheol.lee@lge.com>
References: <20180719002357.9882-1-hyc.lee@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5e90e70a-64d9-7aef-315e-72e576a2164f@huawei.com>
Date:   Thu, 19 Jul 2018 09:55:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719002357.9882-1-hyc.lee@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/19 8:23, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> Because xattr_permission already checks CAP_SYS_ADMIN
> capability, we don't need to check it.
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

