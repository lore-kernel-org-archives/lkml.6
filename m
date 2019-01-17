Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E299EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2C920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547713949;
	bh=0uJvQ3W4H7c1MH/pyaqcHH8s4UlwyDJxD2MtHLhESsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DKsJXtHVkVZGlyyRMbYl+k0IBi/tM/q0MnUBn/7ENmpgQld77K3M9G3QVdQJg3+Bl
	 KB70YHaDVRvAXhDTLa3VXS+R6W57HIdP40gUMSng4pwLPE1WVxs8xy58SshCmBu0cq
	 1Vn3HS3cq5n7z2ebR+iBI263aogjxAYKDSpuxxuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfAQIc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:32:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfAQIc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:32:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B555A20657;
        Thu, 17 Jan 2019 08:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547713947;
        bh=0uJvQ3W4H7c1MH/pyaqcHH8s4UlwyDJxD2MtHLhESsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GR3L+142e0znx0dyxakyFEkfQr2e2zivnmAmTgBZd75M7TONKmJLvWNZO3eCAcm1n
         cpcEpRkbDhb/243pnv25IW+Ey8/stjOgIVzZYRIL7YgJfoZqXXbRVl2djYbz974zWN
         dAmAIHepnTWKxGyPDVxmoSBidmFo/3fUZ5FmkSxE=
Date:   Thu, 17 Jan 2019 09:32:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     mchehab+samsung@kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: email address update in MAINTAINERS entries
Message-ID: <20190117083224.GA17261@kroah.com>
References: <20190116232820.26180-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116232820.26180-1-shuah@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:28:20PM -0700, shuah@kernel.org wrote:
> From: Shuah Khan <shuah@kernel.org>
> 
> Update email address in MAINTAINERS entries.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d04cebb4a71..6ca780f24808 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3979,6 +3979,7 @@ F:	drivers/cpufreq/arm_big_little.c
>  CPU POWER MONITORING SUBSYSTEM
>  M:	Thomas Renninger <trenn@suse.com>
>  M:	Shuah Khan <shuah@kernel.org>
> +M:	Shuah Khan <skhan@linuxfoundation.org>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	tools/power/cpupower/
> @@ -8259,6 +8260,7 @@ F:	include/uapi/linux/sunrpc/
>  
>  KERNEL SELFTEST FRAMEWORK
>  M:	Shuah Khan <shuah@kernel.org>
> +M:	Shuah Khan <skhan@linuxfoundation.org>
>  L:	linux-kselftest@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>  Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
> @@ -15842,6 +15844,7 @@ F:	drivers/usb/common/usb-otg-fsm.c
>  USB OVER IP DRIVER
>  M:	Valentina Manea <valentina.manea.m@gmail.com>
>  M:	Shuah Khan <shuah@kernel.org>
> +M:	Shuah Khan <skhan@linuxfoundation.org>
>  L:	linux-usb@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/usb/usbip_protocol.txt
> -- 
> 2.17.1
> 

I can take this through my USB tree as 1/3 of these entries come from
there, unless you want to take it through your kselftest tree?  If so,
feel free to add my:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
to it.

thanks,

greg k-h
