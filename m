Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA8ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B272083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jylcf/w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B272083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeJRPLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbeJRPLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:11:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E632B2145D;
        Thu, 18 Oct 2018 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539846728;
        bh=tBoEnwz2C+iieAmyNTBzWnvx6MaQsADiejVI4CmytWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jylcf/w0y3uVOE1qsBNHdRaIpE3hfAXOoWATIcwszZ6w3DCsKPh5/1B8HpaG0Djpw
         9E5kBzvH1Yi9hrpEnTEBh8ftt9JWsZMimUunQW11g6rT2YZsG0fTiY/c6Fq71oBmrL
         LHgMmjC3vSwZ8zDGO1f0zQszV43gepXa3qnsFzMk=
Date:   Thu, 18 Oct 2018 09:12:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.134-stable review
Message-ID: <20181018071206.GC3660@kroah.com>
References: <20181016170539.315587743@linuxfoundation.org>
 <20181017191939.GA1653@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017191939.GA1653@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:19:39PM -0700, Guenter Roeck wrote:
> On Tue, Oct 16, 2018 at 07:08:57PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.134 release.
> > There are 71 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Oct 18 17:05:18 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.9.133-70-gbc300460e99d:
> 
> Build results:
> 	total: 150 pass: 150 fail: 0
> Qemu test results:
> 	total: 308 pass: 308 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Great, thanks for testing all three of these and letting me know.

greg k-h
