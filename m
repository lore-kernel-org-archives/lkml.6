Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1966C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721B4218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548919124;
	bh=PsDDf1sBnKmWlkvpyctZtidpmGHgarjsO8iClDJntE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RFjpCncczO+L0S8DqXNOmWQnkaj4HeNwONmlVDwgWH/fYW+2969yH7H9+zdM3Z4aa
	 QGQicCkw2XjkgXEi41ZkVPX7p6gvF6g7gXbRDVd+LIj+uTcXIgV5DozQFeHr1QYSFe
	 JlmGvWujS3Ahx3sP/bwuYs2n3CcdgMdEX2OLipts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbfAaHSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfAaHSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:18:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87B22087F;
        Thu, 31 Jan 2019 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548919122;
        bh=PsDDf1sBnKmWlkvpyctZtidpmGHgarjsO8iClDJntE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTFOBypxj5P4/Muk2WTZVgK9S2NYrj+K0MDw8Ui+chEn5k/hquZ79FSvd35GOCUjY
         uD7H97S3ZPvT9jE7fdcWP1JGSDcrBP1hgiHnmLQMRiJlgO9tObqv3m+PBGX6ZC+XF7
         bVJImNMdKY4l5y3NUWJugio70bdNbfEdhjMxMrOA=
Date:   Thu, 31 Jan 2019 08:18:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/117] 4.20.6-stable review
Message-ID: <20190131071839.GD4500@kroah.com>
References: <20190129113207.477505932@linuxfoundation.org>
 <20190130221435.GD26954@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130221435.GD26954@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:14:35PM -0800, Guenter Roeck wrote:
> On Tue, Jan 29, 2019 at 12:34:11PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.6 release.
> > There are 117 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jan 31 11:31:34 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> For v4.20.5-119-gef18d4260339:
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
