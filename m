Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF10C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF1220652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCoUjm2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF1220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJNOfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 10:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeJNOfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 10:35:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FD320645;
        Sun, 14 Oct 2018 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539500133;
        bh=ZaY8DgsoV899tTn6FHz//rRNVRCBxFnI0afgsi95oM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCoUjm2QASEh+J+kSb/DBn3XGMR3pBiYA3iRhJmann5COW+PDvHdUheESQeX7yyGv
         Ny/rALaqszaKuSvzOfK1Dx7VN+VVcL4m7bow6enRtu64fVVYTTzsysybtU9OoGaWc4
         Y9ysiyksd7Nc93ffn7eBlmYNKqY4vdNWn1/sDZCQ=
Date:   Sun, 14 Oct 2018 08:55:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PULL REQUEST] i2c for 4.19
Message-ID: <20181014065531.GA11198@kroah.com>
References: <20181013162101.GA1321@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013162101.GA1321@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 06:21:05PM +0200, Wolfram Sang wrote:
> Greg,
> 
> I2C has one documentation bugfix for something we changed during the
> v4.19 cycle.
> 
> Please pull.
> 
> Thanks,
> 
>    Wolfram
> 
> 
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

Now merged, thanks.

greg k-h
