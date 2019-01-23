Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B0521841
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548225809;
	bh=p9fPylSWmP2ZXZ0c+v+MkRqPiU5n7FJpXntihbaTFIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AQ3fZ/5SL7Z8pXDdMzMbHk2XlaWOBGVca9GwW5LyvltxwWc5bVHLFpO6Q0meS2DDD
	 XdOY1NYFdAREdX/BGv8TTWbpFmh2V7lYNiMdqAUL9pov3jPiH/ZBx9iaEfsNPpIMkG
	 gRRT7ONFd58GOnGyB2LcNB6YuCGOSnIBkJCMMpNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfAWGn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfAWGn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:43:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BDC221726;
        Wed, 23 Jan 2019 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548225806;
        bh=p9fPylSWmP2ZXZ0c+v+MkRqPiU5n7FJpXntihbaTFIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdGRGgdy+ttzItd2wTu4kufYvfOR1rVkOFVnVfW5vsYLhZ6detjpM+2Blpgy+rgN7
         Caehiibd5EtXfhLn5s+DuOrBkTzLycJKC+tu/e5mqAEKSuqdWCWcbGMdlrmCeQp93+
         Nb/32rG36rW2XJsoyyJhm/HCXTw78jjR/FE+eZ5M=
Date:   Wed, 23 Jan 2019 07:43:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
Message-ID: <20190123064324.GE26046@kroah.com>
References: <20190121122455.819406896@linuxfoundation.org>
 <20190122192425.GC2224@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122192425.GC2224@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:24:25AM -0800, Guenter Roeck wrote:
> On Mon, Jan 21, 2019 at 02:41:54PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.4 release.
> > There are 111 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jan 23 12:23:56 UTC 2019.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
