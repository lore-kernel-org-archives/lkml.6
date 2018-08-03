Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5701FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097A22172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097A22172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeHCJAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:00:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728147AbeHCJAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:00:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5F6F641F9A202;
        Fri,  3 Aug 2018 15:05:54 +0800 (CST)
Received: from [127.0.0.1] (10.57.77.74) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 15:05:46 +0800
Subject: Re: [PATCH] gpu/drm/hisilicon: Convert
 drm_atomic_helper_suspend/resume()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Zou Rongrong <zourongrong@gmail.com>,
        <kong.kongxinwei@hisilicon.com>, <puck.chen@hisilicon.com>,
        <airlied@linux.ie>, <noralf@tronnes.org>,
        "Sean Paul" <seanpaul@chromium.org>
References: <20180719160426.GA21958@jordon-HP-15-Notebook-PC>
 <CAFqt6zY_KUx0RgRiuTt6x6xmtfwD=iR8xR6665eZYmKmXKgDNA@mail.gmail.com>
 <CAFqt6zZdOJe1VmCC3=cEANEU_X05whezkFZsG+FtoS64FXnpeg@mail.gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Ajit Linux" <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
From:   xinliang <z.liuxinliang@hisilicon.com>
Message-ID: <5B63FE39.4070402@hisilicon.com>
Date:   Fri, 3 Aug 2018 15:03:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZdOJe1VmCC3=cEANEU_X05whezkFZsG+FtoS64FXnpeg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.77.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/2 17:57, Souptick Joarder wrote:
> On Thu, Jul 26, 2018 at 1:37 PM, Souptick Joarder<jrdr.linux@gmail.com>  wrote:
>> >On Thu, Jul 19, 2018 at 9:34 PM, Souptick Joarder<jrdr.linux@gmail.com>  wrote:
>>> >>convert drm_atomic_helper_suspend/resume() to use
>>> >>drm_mode_config_helper_suspend/resume().
>>> >>
>>> >>Fixed one sparse warning by making hibmc_drm_interrupt
>>> >>static.
>>> >>
>>> >>Signed-off-by: Souptick Joarder<jrdr.linux@gmail.com>
>>> >>Signed-off-by: Ajit Negi<ajitn.linux@gmail.com>
>>> >>---
>> >
>> >Any comment on this patch ?
> Any review comment for this patch ?
Sorry for late reply. Looks good to me. Thanks.
Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>


