Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65C9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840E32084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548153099;
	bh=WcBv6213Gp2+X3nDtP1cvSIHMkl4DC7h2zOamKRQ074=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DFMx0DRq8q8jv9+BEsPsgVCkZH5IVcudM42vIgri+B4M4FeGq20kBN7knjuF7OA1h
	 eBKnWkYmfGTJaqQnBneHGM+Wp88yhWkyKTbyK4JeSfwMl78gepGoTyvKx/dIrBOHEZ
	 2tcIb+4LMTZ+ivVX8X+O6C0Niy7faHZirvp3lqjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfAVKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfAVKbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:31:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAE6E2084A;
        Tue, 22 Jan 2019 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548153097;
        bh=WcBv6213Gp2+X3nDtP1cvSIHMkl4DC7h2zOamKRQ074=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6xQuSaxZIqFmJoc4tRyrs+pvLpbHaQ5XcmF3Z03SOJGzanY/ZZFhBBFuXMx2w3E+
         4jMC9iCLFFzFonXQnq1zahHWAp41rZxbnq8NuqBR7f8kgypF61Pj3aU8ko9j64o6qQ
         xL/2x3G9957b/QPbs2WXR74JhWqz3BI6ryFWGrmo=
Date:   Tue, 22 Jan 2019 11:31:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: netlogic: replace ---help--- with help in
 Kconfig
Message-ID: <20190122103134.GA32578@kroah.com>
References: <20190120161039.GA2808@bhar.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120161039.GA2808@bhar.linux>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 09:40:39PM +0530, Bharath Vedartham wrote:
> This patch fixes the checkpatch.pl warning:
> 
> WARNING: prefer 'help' over '---help---' for new help texts
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/staging/netlogic/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Any reason you sent this twice?
