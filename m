Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A54FC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BD7208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BD7208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754911AbeFTTEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:04:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754859AbeFTTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:40 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 07098E93;
        Wed, 20 Jun 2018 19:04:39 +0000 (UTC)
Date:   Thu, 21 Jun 2018 03:51:54 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/279] 4.16.17-stable review
Message-ID: <20180620185154.GE32326@kroah.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618183049.GB29875@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618183049.GB29875@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:30:49AM -0700, Guenter Roeck wrote:
> On Mon, Jun 18, 2018 at 10:09:45AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.17 release.
> > There are 279 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jun 20 08:05:28 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.16.16-279-g957de89:
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 152 pass: 152 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.

Great, thanks for testing and letting me know.

greg k-h
