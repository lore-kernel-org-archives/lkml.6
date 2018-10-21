Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A26ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF712083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T//Xg53C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF712083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeJVEEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbeJVEEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:04:49 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6E920779;
        Sun, 21 Oct 2018 19:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540151364;
        bh=7DDugkVi6zR83IqgKGoC/eu8nAKk36ho31VieFi1knQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T//Xg53CzLq2a/FtK1FkjhOweEeXFS7jl8swFiCAfIpt0gKHaBEOnXfF/5HFxqMcY
         SbmavQWw0EoO2vqRlu6tD+pIp4WXIlfmA0xgzXDgZdKi8LCk4m0r7NkGHDYPCRasmU
         BXOYTIkwuEgAd87tclXlJ3B/EEWvhC519xKMK46c=
Date:   Sun, 21 Oct 2018 20:49:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PULL REQUEST] i2c for 4.19
Message-ID: <20181021194922.GA13019@kroah.com>
References: <20181021104002.GA2921@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021104002.GA2921@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 12:40:06PM +0200, Wolfram Sang wrote:
> Greg,
> 
> please pull another driver bugfix and MAINTAINERS addition from I2C.
> 
> Thanks,
> 
>    Wolfram
> 
> 
> The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:
> 
>   Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

Now merged, thanks.

greg k-h
