Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C0FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69B62192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfBODLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:11:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfBODLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:11:48 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B8E11A7AFCE647DDDFD7;
        Fri, 15 Feb 2019 11:11:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Feb 2019
 11:11:35 +0800
Subject: Re: [PATCH] scsi: libsas: Fix rphy phy_identifier for PHYs with end
 devices attached
To:     John Garry <john.garry@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dann.frazier@canonical.com>
References: <1550162277-17615-1-git-send-email-john.garry@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <707fcb45-a040-4881-1863-82afcb98135b@huawei.com>
Date:   Fri, 15 Feb 2019 11:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550162277-17615-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good, I had a quick test and the issue is fixed, thanks.

Reviewed-by: Jason Yan <yanaijie@huawei.com>

