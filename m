Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187AEC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5E02184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfAWQQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:16:28 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:16:27 -0500
Received: from oxbsltgw08.schlund.de ([212.227.220.152]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3DBd-1glWmZ3IOD-003dxv; Wed, 23 Jan 2019 17:16:06 +0100
Date:   Wed, 23 Jan 2019 17:16:05 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        eric@anholt.net, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Message-ID: <2064917135.710926.1548260165940@email.ionos.de>
In-Reply-To: <20190123070507.15404-1-yuehaibing@huawei.com>
References: <20190123070507.15404-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] spi: bcm2835aux: remove unneeded NULL check of
 devm_clk_get
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:9mabrZGoQKRSZQr9I6ZiP+0AnSc72EVBNLh84GmHZAfIEIf/sqX
 eMZcGcgGn2Q1dtLEB7Ix9raatAf7ELEJCBQjUaAkYVFENuVPgu9I1B5imDoVCoiId5YSJKO
 qH4JFhNGf7OWbkJBYkZA5S0NPcx5Q1LAKQPvz4xOIqjjn+eDp0tIc6M7JguPVfAnzCPcypa
 95IDmoW/yV3ujprIBYQ5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ReyfGeQ0ng=:SMw/zddT1TPelJJ9vHqAiC
 8nUzBPzPXqUgZ+HUDDcYYoBOLRqoWIS6Dm8vDxH1D85qP/KyUNFFCJ2K7csHsFomg0+As4XWJ
 715ZEaljr2j46Tpu+BW3/M+s9+wI1DRSGoIytr5FrP3lPo77+GNl6wcuwpVqb4VUwPp1niDBV
 tesgyhckN15ugYE/SAMszS3YxSOIcCo4ewHFA11z1pXKJ3X9dvwue5wVwTo/7mohtQhmbhiir
 isGp4E4OhdqoFAYpQrbocjjdYeRxtG9l8IXkc3GVFtP7pi9UnX9FtOWp8UPFLqEZ1wKQmgVPw
 KQPdiCq7ukhkuPqp4Lg3QH0TsXoyV3EOZRi7zs0BctSGWXZl7I1K/GtO/dnTF7OsqyfQtYXKH
 K/17L8oAGJ/dWZ7miVLuR3qdre2fVDU/uehcVEv4VvkKwZLj1DK8fCpUDfWQkC0U6nA9InsfB
 w8pgsdWZ1mqCtGgbTNeHvCmvxwmyYBVGcjONWhUeF0WKnV+CPYnc8TG/cqKvTd5giWMupd82B
 X/5SEwTsdslrqqCA0yYNBweVuTmX0z6up77ACUIu8ZHiy62H/OOfVGFCv6hcdxjY47J++qbxQ
 4UXn8cYJlc7LYRp+o5BEG2wcKjk3RIvaKYynLxzHInc5iCYJ8IN/YGfGT8LYX9c+AelPCBXx8
 ADdreqXqu9JqhvMXreHLJVZufaYLG0j2zAYipyyIdJdp9G03OUBWMyr6yVqTPg9Y62ziI7isa
 0+YKjwrzEQwKL0UfDdpXMc8sjPH8+4ScHUxcLSGDFg9zBdlGTU6PRScCbx8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> YueHaibing <yuehaibing@huawei.com> hat am 23. Januar 2019 um 08:05 geschrieben:
> 
> 
> Fix a static code checker warning:
> drivers/spi/spi-bcm2835aux.c:460
>  bcm2835aux_spi_probe() warn: passing zero to 'PTR_ERR'
> 
> In case of error, the function devm_clk_get() returns ERR_PTR()
> and not returns NULL.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
