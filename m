Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A4F204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547565621;
	bh=q0GTjYyaAJ4gQO3NCBmTd1icIc8sxpBwgCfji6BZz+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fm9sKeEtC7Cxvw/Gk/sOsoTSxPuDtl7hudHy0KXZuf6kEJTv5HYaQDpM0SSNA8NdR
	 Fzj0Pi75oz/dC8WOfMm6qX+bZbuEy+T1QURSrBv1c3IiBvISOtnORhWY2fnNFe4XY5
	 ZJi8VfS9a1q/tczBaJAuuAXt/MdF0kWMjodGrg7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfAOPUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbfAOPUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:20:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D04204FD;
        Tue, 15 Jan 2019 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547565618;
        bh=q0GTjYyaAJ4gQO3NCBmTd1icIc8sxpBwgCfji6BZz+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+Yc6ByPS57iQ46Rn7d/qApANJ5lav7B3Y6dsabufzTnnsCq4sjwzJaCaKwXzrrMH
         qA5vB5MNweJmf8bAbrnMYGWj1Z0IffohzJzxhTnEqK2pvB5c5aLWawj2pyRsLfId2B
         kE1I0oEm587YtUQR+j0qzIagXmz1j9TtaRZW0HFs=
Date:   Tue, 15 Jan 2019 16:20:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     root <jkhasdev@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: Removed not necessary braces for single
 block
Message-ID: <20190115152015.GA25735@kroah.com>
References: <20190115145108.10249-1-root@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115145108.10249-1-root@localhost.localdomain>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 08:21:08PM +0530, root wrote:
> This patch is used to remove not necessary braces for single if block.
> 
> Signed-off-by: Jitendra Kumar Khasdev <jkhasdev@gmail.com>
> ---
>  drivers/staging/comedi/comedi_fops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

"interesting" email name you used here :)

Please fix up, it has to match the signed-off-by line.

thanks,

greg k-h
