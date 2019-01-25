Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60710C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B566218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548400475;
	bh=DazPEjlUA7+C96D+03AZOX6jc1Kt/wMoHysqnUFavkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S1TTThwwJk/uce0AXUAsh0pSTALQ8iIAPU4aecRY1KnBv10mqPpb3rF8C83FDumXB
	 FZC1lOpqxINGv4kEyXSGVDPqFYEMvnk7Iv6j+/3UNxB+wAPwAmZ5kwnPo0Vk6H2HTw
	 CMRK4imFMyGsZqnoMqdkuvScDh7AtY3YwLtbPwuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAYHOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfAYHOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:14:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BF29218A2;
        Fri, 25 Jan 2019 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548400472;
        bh=DazPEjlUA7+C96D+03AZOX6jc1Kt/wMoHysqnUFavkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2dBeVLGRO0qsLuaICcuYMAwQ8p/8Z6SmojaD/8TshT8s1WQ4DTlt3HLI3n+XhJK1
         zTXDPE+OYj3MD2BK/7bUUoxxFmcpGzXbDYDAVTTtisXIBEZVdd3emfFMwgJbXCP8gr
         yl5xUpTiEwZy2HWSyv9E98QU4+WdL/sGvhj3KY/I=
Date:   Fri, 25 Jan 2019 08:14:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cezary Kierzyk <virdipravum.n008d3v@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtlwifi: replace ---help--- with help in Kconfig
Message-ID: <20190125071429.GB11891@kroah.com>
References: <20190124205719.GA10685@pravumPC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124205719.GA10685@pravumPC>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:57:19PM +0000, Cezary Kierzyk wrote:
> This patch fixes the checkpatch.pl warning:
> 
> WARNING: prefer 'help' over '---help---' for new help texts
> 
> Signed-off-by: Cezary Kierzyk <virdipravum.n008d3v@gmail.com>
> ---
>  drivers/staging/rtlwifi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

$ ./scripts/get_maintainer.pl --file drivers/staging/rtlwifi/Kconfig
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM,commit_signer:1/1=100%)
Corentin Labbe <clabbe@baylibre.com> (commit_signer:1/1=100%,authored:1/1=100%,removed_lines:10/10=100%)
devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)


Why did you not cc: the driverdev mailing list?

Please fix up and resend.

thanks,

greg k-h
