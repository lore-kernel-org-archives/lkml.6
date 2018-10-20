Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB05ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B52214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIPoyYny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B52214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJTOvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 10:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbeJTOvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 10:51:46 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6329E2087A;
        Sat, 20 Oct 2018 06:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540017744;
        bh=CvnySaw9/RhjkzZP6jYLuCdotzp1sDzi9oDpt1qUx3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIPoyYnyQ35ltQQaw4YU/rHKL4V1Gls3qy+rk87t/4zZW4cS86QDJjDqbigxeP270
         e/osTUEzwHYx6zOemb+6Qf/vb77exAVfPiHXZEWFGseqqYnYmEqSl/J7oDQ5IocZ/I
         vcEFnUqJmVy/LpNF5ZLAHJJ+EzCY+tQAIULDuNiw=
Date:   Sat, 20 Oct 2018 08:42:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/53] 4.18.16-stable review
Message-ID: <20181020064222.GC15318@kroah.com>
References: <20181018175416.561567978@linuxfoundation.org>
 <20181019155029.GC2992@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019155029.GC2992@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 08:50:29AM -0700, Guenter Roeck wrote:
> On Thu, Oct 18, 2018 at 07:53:53PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.16 release.
> > There are 53 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> 
> For v4.18.15-54-g5a51f0f:
> 
> Build results:
> 	total: 136 pass: 136 fail: 0
> Qemu test results:
> 	total: 321 pass: 321 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Great, thanks for testing all of these and letting me know.

greg k-h
