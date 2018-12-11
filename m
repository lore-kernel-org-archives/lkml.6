Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A2BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219F62082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219F62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeLKL2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:28:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeLKL2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:28:16 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EA1AD384715A5;
        Tue, 11 Dec 2018 19:28:12 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 11 Dec
 2018 19:28:07 +0800
Subject: Re: [PATCH 3/5] drivers: staging: erofs: Fix spelling issue
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@i4.cs.fau.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
 <20181211105443.21826-4-aaron.strahlberger@posteo.de>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <b9f1bc3b-6bdc-0c6c-e3b5-edbf53d82a2d@huawei.com>
Date:   Tue, 11 Dec 2018 19:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181211105443.21826-4-aaron.strahlberger@posteo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/11 18:54, Aaron Strahlberger wrote:
> Changed "stoped" to "stopped".
> 
> Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
> Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
> Signed-off-by: Dominik Huber <domi250@gmx.de>

A typo fix... I'm not a native English speaker, help me if it has more typo errors...

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang
