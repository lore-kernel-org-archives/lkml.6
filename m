Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5995DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215162089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x3lmYaPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215162089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeKKBIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeKKBIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:08:19 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D6E20818;
        Sat, 10 Nov 2018 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541863377;
        bh=J0YkNI7LmkVzDOa9pTbCdvmLZg+qxO41kepf1NXS2yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x3lmYaPLomDz4DNy3fPLtyxn1jLgUGK8VqFajYAajhOH+fVSuGqpuWfU6GYn0qzeh
         FHWitD6e+jR5qtrRSpmPnHkNapxWMyIP58Cw/Mxm0qV2opx3n+ggwVwkKP3g0Qbnxe
         +6Nv+67M8Xx+fvPwJGjs2t0mRZ+3kKjLQSdV2lMQ=
Date:   Sat, 10 Nov 2018 07:22:57 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/114] 4.4.163-stable review
Message-ID: <20181110152257.GB24724@kroah.com>
References: <20181108215059.051093652@linuxfoundation.org>
 <20181109213040.GA16915@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109213040.GA16915@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 01:30:40PM -0800, Guenter Roeck wrote:
> On Thu, Nov 08, 2018 at 01:50:15PM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.163 release.
> > There are 114 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Nov 10 21:50:28 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.4.162-116-gb63fc4e232df:
> 
> Build results:
> 	total: 150 pass: 150 fail: 0
> Qemu test results:
> 	total: 262 pass: 262 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Great!  Thanks for testing all of these and letting me know.

greg k-h
