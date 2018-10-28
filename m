Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D6C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA14D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1MvZflGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA14D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJ1Xqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 19:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbeJ1Xqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 19:46:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C879F20831;
        Sun, 28 Oct 2018 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540738903;
        bh=tit+rmZ8zkS7C8lSzPySlQXLeWRij5KV68SOS0iKrH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1MvZflGGsnKUerHILEwRizsn5ZhgM9g1XJrkDARQ8fG9qqwfrZrVu91OUiewCNyDa
         a9IJHIbXwHrECZtfurBHOf4EoljAw/2rtOW5yEX0r1NBnFZYzfjnrxeRYSuAFm9UqB
         VQBC6MQtGaKtQxinmnBZwII2qVaChxN8sMExBqz8=
Date:   Sun, 28 Oct 2018 15:01:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Victor Colombo <victorcolombo@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/2] staging: iio: ad5933: Remove unnecessary blank line
Message-ID: <20181028150138.78754acf@archlinux>
In-Reply-To: <20181022204127.ususo2472wcum24f@smtp.gmail.com>
References: <20181022204127.ususo2472wcum24f@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 17:41:27 -0300
Victor Colombo <victorcolombo@gmail.com> wrote:

> This patch fixes the checkpatch.pl warning:
> 
> WARNING: Blank lines aren't necessary before a close brace '}'
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore it (we'll be testing the other patches I
applied today rather than this one which can't really be wrong :)

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 7a216ea90784..f9bcb8310e21 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -267,7 +267,6 @@ static void ad5933_calc_out_ranges(struct ad5933_state *st)
>  
>  	for (i = 0; i < 4; i++)
>  		st->range_avail[i] = normalized_3v3[i] * st->vref_mv / 3300;
> -
>  }
>  
>  /*

