Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5FCDBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE92208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT8jL208"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE92208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965707AbeFOLCx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965590AbeFOLCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:02:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98DB6208B2;
        Fri, 15 Jun 2018 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529060571;
        bh=1pdqonnflJA6X3SKX2zHCNzpAfL7VSNDl34uu64TBJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QT8jL2084Fr49OCFmogGLZgxwdkcLEWgxzRgMIV8HAE9tuOhi6hfrwfJ4srLmB9+v
         JoiogKLINQvCKaOj4AvA9r5aOOzKAZGfH3Cl/0bJQsJy1jxPlCx+LGiidTuUKJe1M2
         YRGOd5q72KbL7B4G7RKPcoim0+Z8IZKhu0Ylkq2c=
Date:   Fri, 15 Jun 2018 13:02:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "JoonHwan.Kim" <spilit464@gmail.com>
Cc:     devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil@brown.name, christian@lkamp.de,
        blogic@openwrt.org
Subject: Re: [PATCH 1/2] staging: mt7621-spi: change indentation from space
 to tab
Message-ID: <20180615110228.GA3107@kroah.com>
References: <1646985.m1Qjj59is2@joonhwan-virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646985.m1Qjj59is2@joonhwan-virtualbox>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 03:03:27PM +0900, JoonHwan.Kim wrote:
> * fix checkpatch.pl error:
>   ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Joonhwan Kim <spilit464@gmail.com>
> ---
>  drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Someone else sent this same fix before you did, sorry.  Same for your
2/2 patch :(
