Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B94C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02B021871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545225586;
	bh=2XimSE83Xc03rqAEzqr9byWgzv1xGWykmVAw866jMG8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=vTb2yBe03/1ECTYIVATTu9uiSVnL+4JlpTqqsFfRR6s56kBNQPqNoL8NnKUHJcCXE
	 Mlz5v90AtFrqs2AHDqp0LEfLC4ARoiEYEVUl+S071p3arPAkU3hEdg3UMJsEQdh/iJ
	 Idhf/q6Ex10f5m5dcPR6OuY2Le3PafzPWIIuM0/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeLSNTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeLSNTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:19:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F73217D7;
        Wed, 19 Dec 2018 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545225584;
        bh=2XimSE83Xc03rqAEzqr9byWgzv1xGWykmVAw866jMG8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CXKQlVDJZjOK4+M2o2dkhYbJp2zywD8sa8a2qlq2ZXD9aTZauF1AoOa+ef6z4N3ul
         MNUOUoEnxzufsuXGVVILZFgzquZ/DO7fs2QCLt+owIO/DWiXPVSU16jVsNTzh+shdN
         1ZzBTu6aGmj3MzTmKJ3bQTE8mN6AUfGI5icEZvKU=
Date:   Wed, 19 Dec 2018 14:19:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/44] 4.19.11-stable review
Message-ID: <20181219131941.GA15278@kroah.com>
References: <20181218163927.119623235@linuxfoundation.org>
 <20181218211025.cqn2djvu5n23o3mi@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218211025.cqn2djvu5n23o3mi@xps.therub.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 03:10:25PM -0600, Dan Rue wrote:
> On Tue, Dec 18, 2018 at 05:39:12PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.11 release.
> > There are 44 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec 20 16:39:02 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great, thanks for testing and letting me know.

greg k-h
