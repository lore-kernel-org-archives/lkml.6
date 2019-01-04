Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D7FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6D6217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546590964;
	bh=JZlGykvIu2QIqAN1U3uGIktYV2mj3WdYCGmdRH+srzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTvty6vjS4JeLOXGaQn83vsTJ+FALGRN28PT0PtMGluaMlr0eQ0rAM80zQyCjJ2xC
	 6IHnv1bTLpgLo/r+ujz7otFEfVNpRxRsZJmSj429qgcSzcbjvdl41JDiMYUYdrKabh
	 GMGC7li6IsBJ2ve+0cqtj7YfqRsd7X7tdL7yx3Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfADIgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfADIgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:36:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A40217F5;
        Fri,  4 Jan 2019 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546590962;
        bh=JZlGykvIu2QIqAN1U3uGIktYV2mj3WdYCGmdRH+srzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTMkTpccxQqFVLm4p9Y15oBQ+OukLwjCh/N8dv/WhkgPVe5evDqnICpgGAEd187/b
         sgGxj7NXUsqjNoHwiWQRm8ZgV16d7yiv/QmF25NY2oep3tm9nLzRvhWY4SoE96MO5B
         t2V+7zH59sh0KipRHHvuQ4EqLozwqj1cP67HLXAc=
Date:   Fri, 4 Jan 2019 09:36:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sushil Verma <sushil.bit.cse@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix camelcase style warning
Message-ID: <20190104083600.GC25233@kroah.com>
References: <20181228122104.GA25322@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228122104.GA25322@localhost.localdomain>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 05:51:09PM +0530, Sushil Verma wrote:
> Remove CamelCase words. Warning found using checkpatch.pl
> 
> Signed-off-by: Sushil Verma <sushil.bit.cse@gmail.com>
> ---
>  drivers/staging/rtl8192e/dot11d.c | 84 +++++++++++++++----------------
>  1 file changed, 42 insertions(+), 42 deletions(-)

Please always use scripts/get_maintainer.pl to determine what people and
lists to send a patch to, as well as always test-build your changes
before sending them out :(

thanks,

greg k-h
