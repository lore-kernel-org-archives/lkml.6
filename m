Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3640C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD142086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2Fz7vDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD142086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbeKGVed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbeKGVed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:34:33 -0500
Received: from localhost (unknown [104.153.224.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305CE2085B;
        Wed,  7 Nov 2018 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541592268;
        bh=q4C/1JrjpexknPZm7ZcMeApTsGOJ1j+/gQawEHFi+EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2Fz7vDm8dgXu/roIyY3HGfHqbQgQ8cYaPuaq5tLAu/XHhio2+J3Tx6rEUDQSBJ5X
         KAk6aHbuPLVtU87IRIVc4PVxtchVVqUAE7nVZ59muVmD0QcxzoHNH0BfenySeuQOzv
         PLvx6TBnoxVChK83HSK0G3zRYFbQa4OV6gxiBoZc=
Date:   Wed, 7 Nov 2018 12:29:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        areklis909@gmail.com, chrisadr@gentoo.org,
        natechancellor@gmail.com, dan.carpenter@oracle.com
Subject: Re: [PATCH 1/3] staging: emxx_udc: Added static modifier to
 udc_controller
Message-ID: <20181107112953.GA31662@kroah.com>
References: <1541102337-51475-1-git-send-email-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541102337-51475-1-git-send-email-carmeli.tamir@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 03:58:57PM -0400, Carmeli Tamir wrote:
> Added static modifier to the udc_controller, since it's only
> required within emxx_udc.c.
> Previously posted without any feedback, now updated according to master.
> 
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I do not see patch 3/3 in this series.

Can you resend the whole series, properly threaded, so that I know what
to apply?  I think you send this one already and I have no idea what to
do here, sorry.

greg k-h
