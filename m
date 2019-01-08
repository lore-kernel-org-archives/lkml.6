Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9DDC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C3D2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546950050;
	bh=Qn9sYGNAP7N4s1jFV2TvwA3hkapcyN7gJtqqMh2OEU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vOwgwPkd6Xc5Jx5uof48E5A/jtdD9mMDbT6bLdb3v8zxTLA23+DGWmjvC1AVV6tuK
	 jPqh4Ql/RAVO4ouWr1KYPCfdbn8jNL2Pz7e2RzvOtBmKx+1Y64nhI8aKSeETsa5a/e
	 c0z2tMo7sjJsNakNQxXOCoN5+0IcYLsTEuECpnIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfAHMUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfAHMUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:20:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D29206B7;
        Tue,  8 Jan 2019 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546950048;
        bh=Qn9sYGNAP7N4s1jFV2TvwA3hkapcyN7gJtqqMh2OEU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vxfvl9kBj/vXeCWVhIo0Xu55Cn0L433u2WGVbjZmhJ2MPegS9+bzAYx9sRwV08ZIF
         2BXEi6xbrhtQlVsUZ7bZ7Ol5qfpguR564e0gm9bsGg1SkhuBrolOfYfgqCcQx9wgOp
         ufvxUzxLRaeJMb/nfodVwWveQglRE+QijgjBVYz8=
Date:   Tue, 8 Jan 2019 13:20:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190108122046.GF3884@kroah.com>
References: <20190107104437.308206189@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:30:37PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.1 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.1-rc1.gz

-rc2 is out:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.1-rc2.gz
