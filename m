Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB30ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715382151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zvnvbtSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715382151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeJQWnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbeJQWnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:43:45 -0400
Received: from localhost (unknown [46.144.157.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6386A21526;
        Wed, 17 Oct 2018 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539787664;
        bh=37j/+RakVktLDVZ7rB6gM+n404inrROtpzm1Ho37VgM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=zvnvbtSOiIOnnZm+3SAV1IhxnAwSLB6mo2a015WuUz0XCOH3PIpmwyl8OoJF1ULLA
         Jst2C9peaSLygDqWq3LsUaqonE9njI6Hv4JmcTGzdf2mSTk2pZPcCpF6EfIVnlCzbI
         o1sqv5WEigtoz7Qk185UC6oa601b35PnTly2xnZM=
Date:   Wed, 17 Oct 2018 16:47:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/135] 4.18.15-stable review
Message-ID: <20181017144740.GC3094@kroah.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181017141446.ecg2ri5bv26jfozc@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181017141446.ecg2ri5bv26jfozc@xps.therub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:14:46AM -0500, Dan Rue wrote:
> On Tue, Oct 16, 2018 at 07:03:50PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.15 release.
> > There are 135 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Oct 18 17:04:43 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Wonderful, thanks for testing and letting me know.

greg k-h
