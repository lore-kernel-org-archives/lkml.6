Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC74AC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105520989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548830959;
	bh=paZZBv5E4b0qzHb4eVzgkrfqXT30+ojLQ35+g/+xSlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HfYSb2iqIoyb8Nefi5MAZF6S3BOg4kKCGq49iMcdz2Fc3CfpgcJtoB+gXp+4vpBhW
	 twEGNdU597/mazYMXxypXCp9JciacFfEtYWlqUyBgRXJhzt95sCZ+h9Vge13PiEzqn
	 n8h3Q1xxFB9I5XvLubXIvos21md8uQ3EHIjbOBlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfA3GtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbfA3GtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:49:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C6F2083B;
        Wed, 30 Jan 2019 06:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548830957;
        bh=paZZBv5E4b0qzHb4eVzgkrfqXT30+ojLQ35+g/+xSlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adOb/ayKt0224jRzezKvY5GTl+EjM6c0nx4Wtgpf1XNbfIxNfUFBUQriC2rEVi8MA
         MH/kJNAKyi3Hfjmemas023dWVYLkSyiCPLaF2dJUJBld1GnrSsZFQFmeXJ/Kyby57f
         hIA/flzDAHGbv98QYzSdk3IvWcASYcvGxLvm4fD4=
Date:   Wed, 30 Jan 2019 07:49:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/117] 4.20.6-stable review
Message-ID: <20190130064914.GA846@kroah.com>
References: <20190129113207.477505932@linuxfoundation.org>
 <532413d4-6e3b-19b4-5369-b02215ddb583@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <532413d4-6e3b-19b4-5369-b02215ddb583@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 07:07:58PM -0700, shuah wrote:
> On 1/29/19 4:34 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.6 release.
> > There are 117 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jan 31 11:31:34 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.6-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
