Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB741C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A2A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A2A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932994AbeFLKmf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:42:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932298AbeFLKme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:42:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4BD01435;
        Tue, 12 Jun 2018 03:42:33 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399C63F59D;
        Tue, 12 Jun 2018 03:42:31 -0700 (PDT)
Date:   Tue, 12 Jun 2018 11:42:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <matt.sealey@arm.com>,
        John Horley <john.horley@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 10/20] dts: juno: Update coresight bindings for hw port
Message-ID: <20180612104221.GA26029@e107155-lin>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-11-git-send-email-suzuki.poulose@arm.com>
 <20180608214946.GI30587@xps15>
 <CANLsYkxNakRGCWT6O0JRKz+N1OTU3-XreC_FiB8Fiv+jEoPEbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxNakRGCWT6O0JRKz+N1OTU3-XreC_FiB8Fiv+jEoPEbQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:52:58PM -0600, Mathieu Poirier wrote:
> On 8 June 2018 at 15:49, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> > On Tue, Jun 05, 2018 at 10:43:21PM +0100, Suzuki K Poulose wrote:
> >> Switch to updated coresight bindings for hw ports.
> >>
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Cc: Liviu Dudau <liviu.dudau@arm.com>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >> Changes since V1:
> >>   - Add support Juno for r1 & r2.
> >> ---
> >
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Sudeep please hold on before applying this as there is more work to be
> done on this set.
>
Sure, I plan to apply the DT changes only after the driver changes are
queued by you or whichever tree it's channelled through. I was already
told the same to Suzuki.

--
Regards,
Sudeep
