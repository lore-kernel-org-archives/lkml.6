Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A236C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECC92084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544861222;
	bh=4spaiNDd9G/ZMjl12il8daydbImfybYUy1QSjJpu1HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SplcJuGXYnjrnsNlEdHC98YPsP2VUg3+lsi87F0nC8CXCeisIldS6xw5gvScpFkQj
	 cycDTQjSdRHoKxSVVztya3licuclOw7ekFxRAYARvvZU6hhhl2zvj7L3gZz7ysLUih
	 EvzJtAh4TqPxQ/rTrYxZm/DwB82z0m+mvggffbN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbeLOIG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeLOIG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:06:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 577DA2080F;
        Sat, 15 Dec 2018 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544861219;
        bh=4spaiNDd9G/ZMjl12il8daydbImfybYUy1QSjJpu1HM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9J6Tp1s4ab7VprGWds2fL6n+ICUjcYh6FSWa++KuF5ZEILPmqJpcleXaKUKbCU13
         zWeTT8xk6+XtcK59MNv8uM77zmUBR9+EYcDBffncgIlS0R4iLVSsR4byTXu1GTbMoI
         r7BedBzXa3f18YOEHwwqe4bKlmtpllWdiFtH0CqY=
Date:   Sat, 15 Dec 2018 09:06:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
Message-ID: <20181215080656.GF10074@kroah.com>
References: <20181214115747.053633987@linuxfoundation.org>
 <74dfaa4d-24e0-d894-29b1-d17e1d022869@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74dfaa4d-24e0-d894-29b1-d17e1d022869@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:06:10PM -0800, Guenter Roeck wrote:
> On 12/14/18 3:58 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.10 release.
> > There are 142 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 337 pass: 337 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.  I'll work on the
4.4 tree later today...

greg k-h
