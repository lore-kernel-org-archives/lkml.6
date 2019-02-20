Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E7A2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550692321;
	bh=VbVjbGVhbfgjIWtwQzUqWtABCBRR8bz3dAxdur7izXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VTzVnsFUnDKJgPkrvguc6yLvTrkskk3Dgfsdw4HVp0QkpGzWs594t4K6GKFV5j/co
	 J4qZ4R2edPBfy5cmeNgXGckN860yGw4FFtPwr2dUSpXRVUW5cockOzLX/WH9f8MbMO
	 4g6i5WtlWIHvogui7KdiwAHmfRzR0OvIe1SJEeGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBTTwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTTv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:51:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A897E2086A;
        Wed, 20 Feb 2019 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550692319;
        bh=VbVjbGVhbfgjIWtwQzUqWtABCBRR8bz3dAxdur7izXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKWoGyZp0VW+EGHjpGi7HsxMacX+F5MWLfC6iXN9fup20GcPN7hPVBgzyzysm+K6G
         BtDGbNEoZ2+T72QKrCSBVCrmN2gMLK+n6KwFlBZXb80VuIzujHOFnngxD51zselHYU
         ccOFSQOWZTUjQ6TMMBG1FTZWanhY5hz1glwmt3/w=
Date:   Wed, 20 Feb 2019 20:51:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        devel@linuxdriverproject.org, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add mailing list for Hyper-V CORE AND
 DRIVERS
Message-ID: <20190220195156.GA32021@kroah.com>
References: <20190220194823.20298-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220194823.20298-1-haiyangz@linuxonhyperv.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 07:48:23PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The new mailing list is: linux-hyperv@vger.kernel.org
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86aa227b5782..ef65de3cfe1b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7137,6 +7137,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
>  M:	Stephen Hemminger <sthemmin@microsoft.com>
>  M:	Sasha Levin <sashal@kernel.org>
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> +L:	linux-hyperv@vger.kernel.org
>  L:	devel@linuxdriverproject.org

Why not just drop the linuxdriverproject one when you do this?

I for one will not mind :)

thanks,

greg k-h
