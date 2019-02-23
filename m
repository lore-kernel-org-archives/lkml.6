Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F1E20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550926753;
	bh=URtqAbFknCcwvo/VzvLUW5RZFktZe2xJ609TnGFWeg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hBye/qP3JLv+4IspEjXT1HRjQsOg2twd/HGPX5QhvcMguaz2L1r3myFmlwu0Z51IF
	 Ej8vBE6yALOlN4RE81ZSgv0Vs+rSviaSvWMNRDv6jb+Un0wf0HPbxRC2c8V3Zx3lzZ
	 RNKC4Ec47BURcqhqDNixuaFF/YSklg/DdwnjdPW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfBWM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 07:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBWM7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 07:59:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B220120675;
        Sat, 23 Feb 2019 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550926751;
        bh=URtqAbFknCcwvo/VzvLUW5RZFktZe2xJ609TnGFWeg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbtnKcfTcqWnBKd7zBR4S3bPJBJyE1Ru424iFFHx/YFl/JXDuik1xo/vOQDeDTYyA
         9CYA6UoP30d5VOHgFlWrSgMWOztwTzVBVveT7HbQQmw2dfHDayuZZBK1ni3MTGLqiT
         lFenWzRbfsSM7IZIRQFfAE6yonjXwcw6zqAEwasE=
Date:   Sat, 23 Feb 2019 13:58:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     jreuter@yaina.de, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        ralf@linux-mips.org, netdev@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] net: ax25: Add SPDX License to fix missing License
 warning
Message-ID: <20190223125859.GB16686@kroah.com>
References: <20190223111100.13983-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223111100.13983-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:11:00AM +0000, Jules Irenge wrote:
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

I know I never take patches without any changelog text :(


> ---
>  net/ax25/af_ax25.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
> index 5d01edf8d819..5048790a75f6 100644
> --- a/net/ax25/af_ax25.c
> +++ b/net/ax25/af_ax25.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0

That is the incorrect license of this file!

NEVER add or modify a SPDX line if you do not really really really know
what you are doing.  Putting the wrong license tag on a file is worse
than not having any tag at all.

BE VERY CAREFUL ABOUT THESE THINGS, they matter.  If you get them wrong,
lawyers get very grumpy :)

thanks,

greg k-h
