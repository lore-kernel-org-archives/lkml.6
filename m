Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FAC2176F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546086045;
	bh=b1+c5di2GmnfSvZwshmtQ2T8E3BRE9Ve2IUlBrrLLfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KaM/4qSxvQ6xMngzqAJ4XNxBj+i2sdiSCYUnhAh3458AnerJSCHirPRaFHPlTVJMG
	 jANl0jrE/9Mf4+L2Q58krvDl9dAjnK6aQaV9jk9xLxjDGtvchdx6pr4q+sOfOvI5kt
	 7AX9w/EUCt4I+v4fgZp48tjO4+wcBnDeDFhhEtlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeL2MUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:20:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbeL2MUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:20:44 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10A32070D;
        Sat, 29 Dec 2018 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546086044;
        bh=b1+c5di2GmnfSvZwshmtQ2T8E3BRE9Ve2IUlBrrLLfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3wu/HsRyag1ZsmjQtcEWFkYgitiEZpe44lBf0oAL7M7xzi/9F4L+ToPU2HSHRQNZ
         ZF84XBkSdra4rX4bAF2PMexmFXJlzJ2OgUvpXJwq0/gZI1Nh0VPD/dIMV8zO2BztXF
         Pcp2dskmbSyeM3qjc8i9XDjE4gsgEquOfzgR0suc=
Date:   Sat, 29 Dec 2018 13:20:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.13-stable review
Message-ID: <20181229122040.GB24238@kroah.com>
References: <20181228113124.971620049@linuxfoundation.org>
 <20181228212909.GC32706@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228212909.GC32706@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 01:29:09PM -0800, Guenter Roeck wrote:
> On Fri, Dec 28, 2018 at 12:51:54PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.13 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Dec 30 11:30:49 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 332 pass: 332 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

greg k-h
