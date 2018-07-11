Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677D920693
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677D920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeGKOHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:07:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeGKOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:07:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E84DE82;
        Wed, 11 Jul 2018 14:03:16 +0000 (UTC)
Date:   Wed, 11 Jul 2018 16:03:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/56] 4.17.6-stable review
Message-ID: <20180711140314.GA8854@kroah.com>
References: <20180710182503.544433950@linuxfoundation.org>
 <45974726-40ba-b32b-a2b2-45ba08520678@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45974726-40ba-b32b-a2b2-45ba08520678@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 06:41:59AM -0700, Guenter Roeck wrote:
> On 07/10/2018 11:24 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.17.6 release.
> > There are 56 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jul 12 18:24:40 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 134 pass: 134 fail: 0
> Qemu test results:
> 	total: 158 pass: 158 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
