Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6030A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545051409;
	bh=M3kaHltbgAA6L+Gl2T5glA2046hPvS+lpjRr/QtRAOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ephBrCcNVtb90kohDZoL1jfpjIsgiWTxpZCSOWHxOPojWEY3WJqnAbeaJDi8R3ndf
	 p0IMNzOwMeveTLUx2H05iRkVA9J3XvM+ZKw+9QSDKdIWN4EFYjC8jOqG66gekH9pt4
	 BxY+Czp7DLWjPcd7vg3/pbq9UgDmjOZCVsR1/tGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbeLQM4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeLQM4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:56:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1884A20874;
        Mon, 17 Dec 2018 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545051407;
        bh=M3kaHltbgAA6L+Gl2T5glA2046hPvS+lpjRr/QtRAOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEWZawSVQVJKazc6GylxnXRG20MLUjMITlJOeHtE0uLDyY8Y/g/BAxWidydsNnUMl
         6rkzwYnTiWIEGI72cW2LUPG3R5RJMYVdMH9M5+iHCN+Jwe+DlZEa6+gGyvFcqikX2S
         929GeYwJ1UD1rklmY1BheK/nFk4Ze5MLZB39ap44=
Date:   Mon, 17 Dec 2018 13:56:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3]  misc/pvpanic: return 0 for empty body register
 function
Message-ID: <20181217125645.GC1934@kroah.com>
References: <1545043394-19417-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545043394-19417-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:43:12PM +0800, Peng Hao wrote:
> Return 0 for empty body register function normally.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What is changing in these different version?

You always have to list that below the --- line as the documentation
says to do so.

thanks,

greg k-h
