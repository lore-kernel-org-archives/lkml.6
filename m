Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8738DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4785D20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwetOSCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4785D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeKTUMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTUMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:12:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DE120831;
        Tue, 20 Nov 2018 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542707040;
        bh=QlLYpusNt3KQwL62MK2rxRZHHPC4g3xDck/9y8o8NUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwetOSChEwRTsMdh6qzIIZRoPJwOGPcoltxBqbWD2wHS1jqrYORWVpMckNS6Tz6KL
         g2+uMbtaDUmQVua6UyPD6O9M0+dF83ltJLXjaSk5X5cgNjPbvtxEooZl8mSSPpetIz
         ScvP0eYwiOsuk9EmIs4peIjUvqxJlqMNgQb8v2VI=
Date:   Tue, 20 Nov 2018 10:43:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        David Lin <dtwlin@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Parenthesis alignment
Message-ID: <20181120094358.GA8089@kroah.com>
References: <1542569289-19899-1-git-send-email-sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542569289-19899-1-git-send-email-sicilia.cristian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 08:28:07PM +0100, Cristian Sicilia wrote:
> Some parameters are aligned with parentheses.
> Some parentheses are opened at end of line.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c       |   6 +-
>  drivers/staging/greybus/audio_codec.c          |   8 +-
>  drivers/staging/greybus/audio_manager_module.c |  55 +++++----
>  drivers/staging/greybus/audio_manager_sysfs.c  |  22 ++--
>  drivers/staging/greybus/audio_module.c         |  34 +++---
>  drivers/staging/greybus/audio_topology.c       |  70 ++++++------
>  drivers/staging/greybus/bootrom.c              |  25 +++--
>  drivers/staging/greybus/camera.c               |  20 ++--
>  drivers/staging/greybus/connection.c           |  82 +++++++-------
>  drivers/staging/greybus/control.c              |  54 ++++-----
>  drivers/staging/greybus/es2.c                  |  71 ++++++------
>  drivers/staging/greybus/gpio.c                 |  40 +++----
>  drivers/staging/greybus/hid.c                  |  26 +++--
>  drivers/staging/greybus/i2c.c                  |  21 ++--
>  drivers/staging/greybus/module.c               |  19 ++--
>  drivers/staging/greybus/operation.c            | 149 +++++++++++++------------
>  drivers/staging/greybus/svc.c                  | 100 ++++++++---------
>  17 files changed, 413 insertions(+), 389 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 4c36e88..9e2fe3d 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -78,9 +78,9 @@ static void arche_platform_set_state(struct arche_platform_drvdata *arche_pdata,
>  }
>  
>  /* Requires arche_pdata->wake_lock is held by calling context */
> -static void arche_platform_set_wake_detect_state(
> -				struct arche_platform_drvdata *arche_pdata,
> -				enum svc_wakedetect_state state)
> +static void
> +arche_platform_set_wake_detect_state(struct arche_platform_drvdata *arche_pdata,
> +				     enum svc_wakedetect_state state)

Don't change the format "signature" this way please, the whole name and
return type looks better on the same line.

>  {
>  	arche_pdata->wake_detect_state = state;
>  }
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 08746c8..d62f91f 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -70,7 +70,7 @@ static int gbaudio_module_enable_tx(struct gbaudio_codec_info *codec,
>  		i2s_port = 0;	/* fixed for now */
>  		cportid = data->connection->hd_cport_id;
>  		ret = gb_audio_apbridgea_register_cport(data->connection,
> -						i2s_port, cportid,
> +							i2s_port, cportid,
>  						AUDIO_APBRIDGEA_DIRECTION_TX);

This patch doesn't make sense at all, sorry.  Look at how the lines
align now, it's a mix of both styles.  Stick with one or the other, but
never both at the same time.

I would recommend just leaving this all alone, it's good enough as-is.

sorry,

greg k-h
