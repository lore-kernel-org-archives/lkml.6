Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D58C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876BC2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545303289;
	bh=LqpTB7dmOZnLvp2Gn4Zoo2H6xXDaJqUa+U8QhbrMvNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GpG4Z2T/jlFHokbRSdoJLJPhWRGa1ps+372jt5LqdgwyzVyrlb31YqOmM1xwqo4dV
	 wcs0daDZ2fU4M1Wk4QUggBKc5zkfQOw+o3VbIGHh20Tfby4FDik0Ajpu9rqQsuf3I8
	 JznAxM/c6p7lr6psS81IulM4zgnc1IhnQBNWdyuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeLTKys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLTKyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:54:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E8C2176F;
        Thu, 20 Dec 2018 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545303287;
        bh=LqpTB7dmOZnLvp2Gn4Zoo2H6xXDaJqUa+U8QhbrMvNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrx0KPIKrv3Zr3UnJUQqXEmn8GByYjTh7V4WI8Medt9AXJrkuSkfAOTlPFrfYMon2
         wGEYpu1xwx/EVHk0CBl8TY2csJ/0h1H0n0ah1S3y5meN683KODkUNsBCH+I6z68DYA
         0yS+R9doH5T9iqjBNzr/HU82j5OkumwxYw2EMm9Y=
Date:   Thu, 20 Dec 2018 11:54:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Android binder
Message-ID: <20181220105444.GB8548@kroah.com>
References: <20181220104057.18628-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181220104057.18628-1-christian@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:40:57AM +0100, Christian Brauner wrote:
> As briefly discussed with Greg and Todd, add Christian as maintainer for
> binder{fs}.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3318f30903b2..3c78cfa08c47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -950,6 +950,7 @@ M:	Arve Hjønnevåg <arve@android.com>
>  M:	Todd Kjos <tkjos@android.com>
>  M:	Martijn Coenen <maco@android.com>
>  M:	Joel Fernandes <joel@joelfernandes.org>
> +M:	Christian Brauner <christian@brauner.io>

Do you really want to be a maintainer for all of binder?  (which is fine
with me, up to Todd and others), or do you just want to be responsible
for the binderfs code?

thanks,

greg k-h
