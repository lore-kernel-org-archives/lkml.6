Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6338C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91236208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyGvmZkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91236208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966006AbeFOQUY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964836AbeFOQUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:20:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C3E208AF;
        Fri, 15 Jun 2018 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529079622;
        bh=9f4/5cHOqaEJEOWuM8QfmmfOeAHr8xAqgsB8m6+CRBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyGvmZkwfMR10h+aTGrf2QUQHcJWisMoYqOcl8ztSigKR3IfCxBzsFkb1cBNzwhww
         buLmF2EzIprpblpzmMoPyy0kSAwdHfqUjFaXoMOVuHNP/9+aqhzKw3zZSb0OsCT4i3
         +5YUivw67ekRnqxHnCIJ5bDPveFmZVPZpE9+uMfg=
Date:   Fri, 15 Jun 2018 18:19:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/45] 4.17.2-stable review
Message-ID: <20180615161948.GA10689@kroah.com>
References: <20180614132126.797006529@linuxfoundation.org>
 <20180615152010.GE28450@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615152010.GE28450@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 08:20:10AM -0700, Guenter Roeck wrote:
> On Thu, Jun 14, 2018 at 04:03:51PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.17.2 release.
> > There are 45 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Jun 16 13:21:05 UTC 2018.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 134 pass: 134 fail: 0
> Qemu test results:
> 	total: 150 pass: 150 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
