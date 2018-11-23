Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F375EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95AF20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVl78Z0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95AF20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502233AbeKWR7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:59:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbeKWR7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:59:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4F320820;
        Fri, 23 Nov 2018 07:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542957397;
        bh=fysv1ui7R5O+Ev+qgNxdNlGFlXs6vudu3iH777glKN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVl78Z0WnNmEnvfJcrNUKVfJvEvSRCVCkgtksIbLhriu0xEhQnW9aWjrJsEqTWk12
         PG3ARF6s/9lk72xW+7/s0ANGKnn/2dXXTKI+hDN/GeIPnVrs3Cll9ey8Q1IfeuwSQj
         T6mpy7WRm9zWY6wUSdLnNy9+t7f86h0Az5uwVfEk=
Date:   Fri, 23 Nov 2018 08:16:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
Message-ID: <20181123071635.GC26178@kroah.com>
References: <20181121183147.869199006@linuxfoundation.org>
 <8cc559b4-9d61-0047-916e-191fa31e2290@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc559b4-9d61-0047-916e-191fa31e2290@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 08:36:12AM -0800, Guenter Roeck wrote:
> On 11/21/18 11:05 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.4 release.
> > There are 42 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Nov 23 18:31:31 UTC 2018.
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
