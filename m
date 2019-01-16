Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0454620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547675137;
	bh=0tDV9QCDhraxYjEEqaDOwIv6UtUxkajb7TxyGAvKQK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R8DQPjN56Fmvl1sbu9WlLRFG9BpDQIckwT53TzRvG4cx00+oWDDZO/urs2WtvFUVw
	 8uX0Oigbq7fg1vwspUUulQILRzOQyt0cncx6kyeVal0bOlNPmrSUeYnfzDgealvloX
	 nHIGJ7MiC14dIlhNsXDz0kEgfAqLRSsbBOZo3Gr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfAPVpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbfAPVpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:45:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA8FC20652;
        Wed, 16 Jan 2019 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547675133;
        bh=0tDV9QCDhraxYjEEqaDOwIv6UtUxkajb7TxyGAvKQK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kz45gBhHcXFIN2TZOSd2d+d1pnNDFWvpdsI3HZOCEYRqQaIY4vb7Gph3gyYoOFB1T
         rihfhHU7WIde/OXac9KD3lrFJEsD2kKJR2lGqAydSR2nMjSroJlyyXktwj6FZG1n9t
         se8szR7briYbotRDyjmoQTubRbRwTbNPHJp4TpIs=
Date:   Wed, 16 Jan 2019 22:45:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/57] 4.20.3-stable review
Message-ID: <20190116214531.GA12062@kroah.com>
References: <20190115154910.734892368@linuxfoundation.org>
 <20190116203844.GE1302@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116203844.GE1302@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:38:44PM -0800, Guenter Roeck wrote:
> On Tue, Jan 15, 2019 at 05:35:41PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.3 release.
> > There are 57 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jan 17 15:48:32 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
