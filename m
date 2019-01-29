Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497C02082E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548754883;
	bh=9JEmK0oho6kukoDsJLIe0qFvGHcbKBGDy2OSPapdHRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H0rlJugJtqOczUi73eWJ870+EWMq9ZHHs37Gd47eBB3ZhY4xhspzfkvwxThDw2oIo
	 ipKJUq85H2uganVWrybTmDgjTm8PUYZc0mVgHmvEucqiEh3BK6UaFpN5nvPFd474/i
	 ciBnUE6N/ulWj7dLP1RsuzFscuGKWbBLd9oMhY58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfA2JlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbfA2JlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:41:19 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318A52082E;
        Tue, 29 Jan 2019 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548754879;
        bh=9JEmK0oho6kukoDsJLIe0qFvGHcbKBGDy2OSPapdHRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MiKxR6M0bykVIstsSK7aIZBdirKf4ETIr/opHUyko8jU78V4Vfp2o/E3pEkfU8guI
         hzqIMOyJlpVJYx6e9NeZknT8sfcC6C9nN4oBe40tEGAv3Scskk/a+vp80+1TXPoH1f
         YxORBeP0grIKkvR3ffSXhm4E/tGKKjZ5VH2WsoBk=
Date:   Tue, 29 Jan 2019 10:41:06 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: Re: [PATCH] spi: spi-mem: spi-nxp-fspi: add module license info
Message-ID: <20190129104106.4645346a@bbrezillon>
In-Reply-To: <1548750550-23565-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1548750550-23565-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 08:31:19 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add MODULE_LICENSE info to fix below warning:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o
> 

You miss Fixes and Reported-by tags here.

> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 0327216ef7aa..90f3d2e4fe5d 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -1103,3 +1103,4 @@ MODULE_AUTHOR("NXP Semiconductor");
>  MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
>  MODULE_AUTHOR("Boris Brezillion <bbrezillon@kernel.org>");
>  MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
> +MODULE_LICENSE("GPL v2");

