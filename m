Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C19C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC921525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAC921525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbeITOYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:24:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731492AbeITOYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:24:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8DBEE53493BBD;
        Thu, 20 Sep 2018 16:41:51 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 16:41:48 +0800
Date:   Thu, 20 Sep 2018 09:41:39 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
CC:     Song Qiang <songqiang1304521@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180920094139.000065fe@huawei.com>
In-Reply-To: <CY4PR21MB07761FEA1CDDC87FBE5568B4FB1C0@CY4PR21MB0776.namprd21.prod.outlook.com>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <CY4PR21MB07761FEA1CDDC87FBE5568B4FB1C0@CY4PR21MB0776.namprd21.prod.outlook.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 18:58:37 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v4.18.8, v4.14.70, v4.9.127, v4.4.156, v3.18.122, 
> 
> v4.18.8: Build OK!
> v4.14.70: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
> 
> v4.9.127: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
> 
> v4.4.156: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
> 
> v3.18.122: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>     4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
> 
> 
> Please let us know how to resolve this.
> 
> --
> Thanks,
> Sasha
Hi Sasha,

This is a false detection.  The stable tag is in the context of the
additions to MAINTAINERS.   I guess that is a rare enough case it's not
worth fixing in your scripts, but thought I'd point it out incase you
want to do so!

Jonathan

