Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1842145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545052561;
	bh=yAdgxYtFi78BGPSM+7TimsNIQKZok/b2MlY/JMgGMGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NCNmBg18EmQPNQMuXTu1AGZsQRTHX+Sgwagf7383uhM4c7mz/gqxDnYigaiPz2i6v
	 I+Ie3MpMsMDrgPVCb0eKFsRM7jkaiwwdIXWSe8ovvduSVRoJXKkohN2rMKTEKG6b9+
	 2gpVK2Y1t0tfHAv4TQdnFLE4otF3Pb5hlWKZ+F9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbeLQNQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeLQNQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:16:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621A62133F;
        Mon, 17 Dec 2018 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545052559;
        bh=yAdgxYtFi78BGPSM+7TimsNIQKZok/b2MlY/JMgGMGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thrJlNAgh6m5ia5zxeHERo6V8XA/M02B+S641Y0iwny9MKR9zhBAKcgffz+lsAuNR
         lBdbhIa5yM66XYFnMRSXPNPBsyEnfamro2FE/w+YjkW1obWiM3lnB692MYy3mqyc7t
         S/yOo1L+ZrGwUOQ66zSqCIkPBEHsBKeqML1EVVv0=
Date:   Mon, 17 Dec 2018 14:15:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: 8255: fixed an SPDX License Tag coding
 style issue
Message-ID: <20181217131557.GA12376@kroah.com>
References: <1544719997-4490-1-git-send-email-indigoomega021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544719997-4490-1-git-send-email-indigoomega021@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:53:17AM -0800, Amir Mahdi Ghorbanian wrote:
> From: Amir Mahdi Ghorbanian <indigoOmega021@gmail.com>
> 
> Fixed a coding style issue.
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoOmega021@gmail.com>
> ---
>  drivers/staging/comedi/drivers/8255.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/8255.h b/drivers/staging/comedi/drivers/8255.h
> index 6cd1339..ceae3ca 100644
> --- a/drivers/staging/comedi/drivers/8255.h
> +++ b/drivers/staging/comedi/drivers/8255.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * module/8255.h
>   * Header file for 8255
> -- 
> 2.7.4

This patch does not apply to my tree at all.  Always work against
linux-next so you do not duplicate work others have already done.

thanks,

greg k-h
