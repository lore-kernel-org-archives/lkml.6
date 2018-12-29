Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F040C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFDB21019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546086063;
	bh=ugloLj04rIfNFHskouhcfDSTbPQC1SkOsZ1AvUZqI7A=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=YK1AXRk/f3ha5hyWu2ysIGwQ3UbHWKivjAJT0TpXWA4HYADW9tmUuZchGTVlayBHY
	 fVarTcb/Oll4W9HhYoum6062RavC7y4iRBjtfFDXTIifUPfI49ysfyQt4a95m6h7QW
	 N0stB0z9rX9PTSpwLJwSNRrb/rF623xpk4auwAU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeL2MVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeL2MVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:21:02 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07DA220857;
        Sat, 29 Dec 2018 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546086061;
        bh=ugloLj04rIfNFHskouhcfDSTbPQC1SkOsZ1AvUZqI7A=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Lvz2y4+yWHB4XTGSXVYa9BR5P4BeES3eVv0W883Yv8IUAU2A7H1oaHT4CtNMTKjBX
         mTWEZYXa678W1SWfiMu2f2giKX+1S7H79p3NF5dd/ArMq9P0rrZDnHSPMj8MJdvDYd
         bObXwOworgVqizuYaT5ZQIq4dXHO2XXURh2Xpsrk=
Date:   Sat, 29 Dec 2018 13:20:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.13-stable review
Message-ID: <20181229122058.GC24238@kroah.com>
References: <20181228113124.971620049@linuxfoundation.org>
 <20181228175422.iagcsu3y7tzpuxq6@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181228175422.iagcsu3y7tzpuxq6@xps.therub.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:54:22AM -0600, Dan Rue wrote:
> On Fri, Dec 28, 2018 at 12:51:54PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.13 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
