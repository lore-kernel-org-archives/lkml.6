Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF9AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4854A224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3rU6xRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4854A224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeKMPDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMPDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:03:18 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCAE2245E;
        Tue, 13 Nov 2018 05:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542085617;
        bh=hx20JFzCkivD5s689302uV793kfpX4tf99xP8xpuLNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3rU6xRmDHLK+nFss2nGZK2JseidDwcp3B4Ggk0OfW7YyPjsVS5jQ7PLbE+4qsnRB
         CHWEh6tqGiyGHxsQQq8qRCWy/EgPC2HFwwYDp1C3YZRZcwOSGR4ZSDk981lwZEe8d9
         MPZ32yoTOxlFQ35OBpM0vMwjiQscqtSpvxxmlkKs=
Date:   Mon, 12 Nov 2018 21:06:56 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/361] 4.19.2-stable review
Message-ID: <20181113050656.GB22225@kroah.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181113005828.GD2997@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113005828.GD2997@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:58:28PM -0800, Guenter Roeck wrote:
> On Sun, Nov 11, 2018 at 02:15:47PM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.2 release.
> > There are 361 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue Nov 13 22:14:55 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 135 pass: 135 fail: 0
> Qemu test results:
> 	total: 291 pass: 291 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

greg k-h
