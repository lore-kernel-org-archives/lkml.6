Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F80C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C767C218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545244653;
	bh=GXs49hkX5EpN36vRnkjpIbpQWZ6JvkCDv0Hm/PUiZuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k1/23fJ1vQBR7qGV9PJ4+KY5Cl4EAPjJnP5JoHWtE+Nv6ThXC0fQKQyPd2rtVzrMy
	 fxOFtJWIv67IzvmEPACsgHCsYt2Zy+y/Nfn6gO0FqsQ8vBqm/yUqxUjFfIAoHWz7J3
	 XgYjfiIZgN3oeDkJZNdpuDZ+Rbhn0p6bSQ6FXR0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeLSShc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbeLSShc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:37:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8262080D;
        Wed, 19 Dec 2018 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545244651;
        bh=GXs49hkX5EpN36vRnkjpIbpQWZ6JvkCDv0Hm/PUiZuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=14/zehvI4O/C899kSD5+mW7Ygvn2YLXTZrZrWQgJwoMzYK13SUqb1WlLHK20d3L7M
         2mGLc6/LRkRtJYtS5lxB4bEEUbY3LrBC27altXKln7i+m9yE5us27uYzSMBAxH6+7+
         6/UUu8jqGTk9+A28UJ/F8ckNCvEBTQ0HFA9EVxoE=
Date:   Wed, 19 Dec 2018 19:37:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/44] 4.19.11-stable review
Message-ID: <20181219183729.GA32592@kroah.com>
References: <20181218163927.119623235@linuxfoundation.org>
 <20181219172358.GA26604@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219172358.GA26604@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 09:23:58AM -0800, Guenter Roeck wrote:
> On Tue, Dec 18, 2018 at 05:39:12PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.11 release.
> > There are 44 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec 20 16:39:02 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 338 pass: 338 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Wonderful, thanks for testing and letting me know.

greg k-h
