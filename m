Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0E0EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D95208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMV1CC/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D95208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935819AbeFMUxS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935667AbeFMUxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:53:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DF6208C4;
        Wed, 13 Jun 2018 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528923197;
        bh=SDtTPhBoPI7b+/09bgn18U7qxWOoKe0LC5NeQ1B6qVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMV1CC/2f0LgVgPh+Wn9J7TsPIhQSg2LUXei5XNSD7+ZMlZKw1C5/bhukbulGuc2e
         PgAZ2IvC98ervlPxyrJGiOkV/VUXBC8vm1gdZbbMs7ZWSL6OayG3DU4FecvqIlviAX
         WWdlzfVow1k9tnrxYOKVi9pOOUskRkCoTcLI6xyY=
Date:   Wed, 13 Jun 2018 22:52:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Javier Martinez <javiermlinux@gmail.com>
Cc:     devel@driverdev.osuosl.org, jhogan@kernel.org,
        linux-kernel@vger.kernel.org, aaro.koskinen@iki.fi
Subject: Re: [PATCH] Staging: octeon-usb: octeon-hcd.c: style fix line length
 warning
Message-ID: <20180613205255.GA14313@kroah.com>
References: <20180613204015.GA15689@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613204015.GA15689@javier-Z97X>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:40:15PM -0400, Javier Martinez wrote:
> Checkpatch.pl issued a warning in the top of the commment within
> octeon-hcd.c. This is a simple style fix for that.
> 
> Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index cded30f145aa..768b0148f3d5 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -1,5 +1,5 @@
>  /*
> - * This file is subject to the terms and conditions of the GNU General Public
> + * This file is subject to the terms and conditions of the GPL
>   * License.  See the file "COPYING" in the main directory of this archive

The grammer is now incorrect :(

Shouldn't we just have a SPDX line at the top here and this whole boiler
plate text be removed?

thanks,

greg k-h
