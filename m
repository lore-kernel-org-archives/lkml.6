Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F53C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032272084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xWzGC6RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032272084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeLEG7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeLEG7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:59:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 892D62082B;
        Wed,  5 Dec 2018 06:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543993190;
        bh=t8ntykznXuZj8Unko3FrLg3hRSHbE8SXfiH7FEQKddM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWzGC6RMbOg4Q89FdnyAe8dPOqHNRCwdRBGZLVNlqsx+0J34AQun+jxL2RIe5sNQ3
         7d4w+KpYxpsmSkhNzNYIDM9XBFil7Eo/Su3H6S/gaAqX9ViSt4BslCP9igbiw5H+MG
         O4QS1aaqy0QCtvVQDHiJQnHz623cGNfl9DMK6IIw=
Date:   Wed, 5 Dec 2018 07:59:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
Message-ID: <20181205065947.GC16346@kroah.com>
References: <20181204103649.950154335@linuxfoundation.org>
 <d6f93f1a-7882-1df6-679a-130244f7da1f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f93f1a-7882-1df6-679a-130244f7da1f@roeck-us.net>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:42:47PM -0800, Guenter Roeck wrote:
> On 12/4/18 2:48 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.7 release.
> > There are 139 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 337 pass: 337 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all 3 of these and letting me know.

greg k-h
