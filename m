Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83732C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5455520827
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5455520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJ2F54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:57:56 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJ2F54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:57:56 -0400
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue009
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MFbeI-1gLoIo3JCY-00H3DJ; Sun, 28
 Oct 2018 22:11:44 +0100
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue009
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MFbeI-1gLoIo3JCY-00H3DJ; Sun, 28
 Oct 2018 22:11:44 +0100
Date:   Sun, 28 Oct 2018 22:11:43 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dave.stevenson@raspberrypi.org
Message-ID: <847891613.4295.1540761103425@email.ionos.de>
In-Reply-To: <20181026134813.7775-19-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-19-nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 18/18] staging: vchiq: add more tasks to the TODO
 list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:6u8sDlr00Xti4xgt9XmtPwhhj5UMR6w8+UyiWlgBJ7/OCc3mm9f
 zkFwNOTXB7G/U0reyduRdJHR3XvZKDW6yPuSujczytzbqzy6rPydAziVbaP+jWh7VWkZ3Po
 bNQA0IDxR8JjXAOc7DH2GHieDVJ/wtP4h+pjpJFU6ow6K0m2HX7nFQzBB1nys/SjS9wMbKG
 DdE/HelR7/dWyqUWdXMkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ysKt6YBQcG0=:fypeZRFMPtqbWOnzpiJzFZ
 uBv2Pp6v2MN4g3WgQoceStbKYoF2YfEvi3ZHbDLun+/VIdg3x5nx41qBANjKbDJJcR3YL0HkZ
 oBIyu4Y9NU1nGny/Kzy7rVaw4dUjDWgkRdzM6c3CGqHeg1EWHJKou8Dikrq0HtfoWUVkg1kFF
 gLgZufuv+AGj77XWdHdtmMI3dlcmnrmiRvHDJwYDkiQW1ycvGJNgG7OV5YB301ro0nwhXtFF6
 dq3EdFR6qakRSjXFsixd5I/yOh2L5ikqjBLbeadvFjURDexIjkX91GbnsNPIzcAeC4rDHGglv
 uAoaQsRkFDV9QeIQy2dM2YnlD46KgwwVfqGJR+FFV0jxeFfuGPcjc9fcBTYRzi6ix5irN4WBG
 QkL/9AFHxv9LVJStk6vrFpoQeIKDhkA2cwfReQeplJIZu9KA4hMRjEX/BdziYcQW+6wAmfjtb
 LDTXXvwvefvBiQAHrN9Aq2R+/vOJFhPkcAxLU2lmMevNvlSa9FW6cWDgUJjGTgWnKsNN7UnDv
 PQZCzL2PE0SymgqQ6HPOUv1JKoJV69mMm1UKm88Aqf9XFt9EQX6BjVqYPxkDaKY3dUkHd2vxv
 JroKGiqUgp0hTYLRqi8xdgQ6UZLxdymYIZXhUDNI+CZ/O8KYrKpjBddjCKXKdrT5/eMyQIMOz
 rTJbCWwhT4lwOCoFXE+fFaLHFRmrrPsHVrh4k+Xb+1HW3u8jaqSRXbkgJzuBQRg32j1ltis/c
 iXXpzzFaIMAsX4Ni
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> The more the better.

Please try to find a better commit log ;-)

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../staging/vc04_services/interface/vchi/TODO | 46 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/TODO b/drivers/staging/vc04_services/interface/vchi/TODO
> index 0b3ec75ff627..bf2135826431 100644
> --- a/drivers/staging/vc04_services/interface/vchi/TODO
> +++ b/drivers/staging/vc04_services/interface/vchi/TODO
> @@ -27,8 +27,8 @@ unused.
>  3) Make driver more portable
>  
>  Building this driver with arm/multi_v7_defconfig or arm64/defconfig
> -leads to data corruption during the following command: 
> -  
> +leads to data corruption during the following command:
> +

I assume this wasn't intended.

Btw after applying Phil's patch series. This point can be dropped.

Beside that i'm fine with the additions.
