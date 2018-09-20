Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80313C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CDE2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CDE2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbeITQAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:00:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731194AbeITQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:00:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13679E52;
        Thu, 20 Sep 2018 10:17:45 +0000 (UTC)
Date:   Thu, 20 Sep 2018 12:17:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     mchehab+samsung@kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH] MAINTAINERS: Add csky
Message-ID: <20180920101743.GA19885@kroah.com>
References: <1537438447-24631-1-git-send-email-ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537438447-24631-1-git-send-email-ren_guo@c-sky.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:14:07PM +0800, Guo Ren wrote:
> Add a maintainer information for the csky(C-SKY) architecture.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d870cb5..6b7c1be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3211,6 +3211,22 @@ T:	git git://git.alsa-project.org/alsa-kernel.git
>  S:	Maintained
>  F:	sound/pci/oxygen/
>  
> +C-SKY ARCHITECTURE
> +M:	Guo Ren <ren_guo@c-sky.com>
> +T:	git https://github.com/c-sky/csky-linux.git
> +S:	Supported
> +F:	arch/csky/

Shouldn't this patch be part of the original patch series for the csky
port?  No need to put it separate.

thanks,

greg k-h
