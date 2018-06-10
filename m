Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lxnLNJR0HVvaOAAAmS7hNA
	; Sun, 10 Jun 2018 18:57:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BAD3B60791; Sun, 10 Jun 2018 18:57:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCkv0v1g"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 45472606FA;
	Sun, 10 Jun 2018 18:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45472606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932293AbeFJS5V (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 14:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932094AbeFJS5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 14:57:19 -0400
Received: from localhost (unknown [62.177.166.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1CA2089C;
        Sun, 10 Jun 2018 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528657038;
        bh=QeaDTepoPyU2t3FsH/GPgWBCN2gGns2xfMa6goF5D10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCkv0v1gt4QQ9lkhEpf2TO1Mb4R2OnusVZc9fCAFXKrrUO32KQACyOB0w6t9yFZA8
         3GXKrLwN8dakz6/r7BFjIDH8iToFpnWC1z/pt7JHVW1dQC6kdaP4oxHQ7vxEySFmqJ
         9QwvNR56XQtpl1GHYs+fPf9CBBkzdpwXVULUumG4=
Date: Sun, 10 Jun 2018 20:56:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/15] 4.17.1-stable review
Message-ID: <20180610185656.GA27294@kroah.com>
References: <20180609150000.746833461@linuxfoundation.org>
 <20180610151444.GB29924@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610151444.GB29924@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 08:14:44AM -0700, Guenter Roeck wrote:
> On Sat, Jun 09, 2018 at 05:29:35PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.17.1 release.
> > There are 15 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon Jun 11 14:59:48 UTC 2018.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 134 pass: 134 fail: 0
> Qemu test results:
> 	total: 143 pass: 143 fail: 0
> 
> Deteails are available at http://kerneltests.org/builders/.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
