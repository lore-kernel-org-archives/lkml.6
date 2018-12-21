Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C9C21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545376221;
	bh=zgu0PxIV62Mxic0OO2cxnS8PZo8bz5ieAIACeh7n2Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NgbphO6M1K+Zd5dzAVdYpPbk+Gik9W38Xec7Oewzzu8v20dU+Ni7eC2bfGhPz0S/l
	 YBKwK0RqqupYHoTazjchoRhJi8GKiPWbguteLtuFd90p9/pXEzDmcg5gSNyo2/uFpO
	 6cUVmH2IBURx/8I1VlsteUZNn8C+8jXeXhylCRX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbeLUHKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLUHKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:10:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C6D218F0;
        Fri, 21 Dec 2018 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545376219;
        bh=zgu0PxIV62Mxic0OO2cxnS8PZo8bz5ieAIACeh7n2Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1VKCLcG9O1juRo3X3LEQ4EAX/wv1PSu3CFvnlGMJzv4mAn2NLgP2ZQvCzBw4/Q9Gx
         KPmu0Tu2H4DDDQ4qDO27UmKw5SWVHZ/eOxJfAfp6DsFKmIrZ8JnPs9WANMakOxei9J
         Je2KBM0SWLo56witZoeliAfUgpgSadh+gk0APqSA=
Date:   Fri, 21 Dec 2018 08:10:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/67] 4.19.12-stable review
Message-ID: <20181221071016.GB19343@kroah.com>
References: <20181220085903.562090333@linuxfoundation.org>
 <20181220182959.GE12802@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220182959.GE12802@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:29:59AM -0800, Guenter Roeck wrote:
> On Thu, Dec 20, 2018 at 10:18:12AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.12 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec 22 08:58:49 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 328 pass: 328 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of thse and letting me know.

greg k-h
