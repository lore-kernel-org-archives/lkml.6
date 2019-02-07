Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B8C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2593821872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549554434;
	bh=vFOgYmm5ev8qIKd5tuwU9mPW6/7TBJll/gKu0s83HLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rl2H5RaOvd6LGzE+Ni28JIIUwLYpA+2kmxT014m87kidsviBLWJm9zcdgjkJsamz6
	 l4/YCYdPI+yOXXag0UybyRj9NC1idSz7TmhzirABV8AKaBl4aQpClxCZguZWCP07dW
	 BeCR2V8uYgjgTnAeHE4GUGC+rwBkBLyToE7Y9jnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBGPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:47:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DC9218D3;
        Thu,  7 Feb 2019 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549554431;
        bh=vFOgYmm5ev8qIKd5tuwU9mPW6/7TBJll/gKu0s83HLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2fPV4NqUL/eIHylR5vZchgB0qxgvboBqnmgtR1IXpixuChBksyeGHXSwFnBGfipmS
         T7OPaYb7iclimQGT9J/RZl6F5f1uFm8N26I05u41HsKRpJ6djPBUiZ81ODZw7ZhxPK
         ab32kcv+MK583EvAFIX3Sk2Vnhf1S8m51V85unE0=
Date:   Thu, 7 Feb 2019 16:47:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
Message-ID: <20190207154708.GB7164@kroah.com>
References: <20190207113025.552605181@linuxfoundation.org>
 <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:20:43AM -0800, Guenter Roeck wrote:
> On 2/7/19 3:41 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.174 release.
> > There are 34 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 171 pass: 170 fail: 1
> Failed builds:
> 	x86_64:allyesconfig
> Qemu test results:
> 	total: 291 pass: 291 fail: 0

Oh, and thanks for the very fast turn-around time.

greg k-h
