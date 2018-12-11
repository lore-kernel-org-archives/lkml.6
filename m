Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED730C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802C22082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802C22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLKJSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:18:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeLKJSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:18:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C47B40ED1AF1;
        Tue, 11 Dec 2018 17:18:33 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 11 Dec
 2018 17:18:25 +0800
Subject: Re: [PATCH] drivers: staging: erofs: Fix styling issues
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
CC:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@i4.cs.fau.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181211090627.2194-1-aaron.strahlberger@posteo.de>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
Date:   Tue, 11 Dec 2018 17:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181211090627.2194-1-aaron.strahlberger@posteo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On 2018/12/11 17:06, Aaron Strahlberger wrote:
> Fixed following checkpatch.pl styling issues:
> 
> - 17x CHECK: Alignment should match open parenthesis
> -  7x CHECK: Comparison to NULL could be written ...
> -  1x CHECK: Lines should not end with a '('
> -  1x CHECK: Please use a blank line after ...
> 
> Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
> Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
> Signed-off-by: Dominik Huber <domi250@gmx.de>

Thanks for taking time to work on this submitted patch. :)

As a matter of practice, it is perfered to keep each patch
fixes one kind of these issues you found...separate into 4 patches could be better...

In addition, you need send to Greg Kroah-Hartman <gregkh@linuxfoundation.org>
for upstream...

Thanks,
Gao Xiang
