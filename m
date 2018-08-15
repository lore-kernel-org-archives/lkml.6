Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9CE214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9CE214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeHOSY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:24:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbeHOSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:24:29 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75363C7D;
        Wed, 15 Aug 2018 15:31:51 +0000 (UTC)
Date:   Wed, 15 Aug 2018 17:31:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@profitbricks.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/104] 4.14.63-stable review
Message-ID: <20180815153147.GB524@kroah.com>
References: <20180814171515.270692185@linuxfoundation.org>
 <20180815061429.GB1253@kroah.com>
 <CA+res+SSVV04eawQ6wDX6_gdd9G0FbQ=uWFy0tOgSX=+T0s2MA@mail.gmail.com>
 <CAMGffEnBBFZMfN=veC9GHb_6BU6b+k_h2DfseVxgq1ivRNDyEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEnBBFZMfN=veC9GHb_6BU6b+k_h2DfseVxgq1ivRNDyEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 05:02:16PM +0200, Jinpu Wang wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: 2018年8月15日周三 上午8:15
> > Subject: Re: [PATCH 4.14 000/104] 4.14.63-stable review
> > To: <linux-kernel@vger.kernel.org>
> > Cc: <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
> > <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
> > <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
> > <stable@vger.kernel.org>
> >
> >
> > On Tue, Aug 14, 2018 at 07:16:14PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.63 release.
> > > There are 104 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu Aug 16 17:14:49 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.63-rc1.gz
> >
> > -rc2 is now out:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.63-rc2.gz
> 
> Merged to our tree, tested on my test machines with basic functional
> tests, all looks fine.

Wonderful, thanks for testing and letting me know.

greg k-h
