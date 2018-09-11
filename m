Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17950C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E7B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E7B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIKUXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:23:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45428 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeIKUXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:23:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AD9818A;
        Tue, 11 Sep 2018 08:23:45 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637E13F614;
        Tue, 11 Sep 2018 08:23:43 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:23:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org, Robert Walker <robert.walker@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] dts: juno: Enable coresight tmc scatter gather in ETR
Message-ID: <20180911152314.GA12052@e107155-lin>
References: <1536655641-26192-1-git-send-email-suzuki.poulose@arm.com>
 <20180911103509.GA770@e107155-lin>
 <CANLsYkzaHsi=V+GZaJ+hdzDODT-BRHU42fPJ1Vu-aX726E=grA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzaHsi=V+GZaJ+hdzDODT-BRHU42fPJ1Vu-aX726E=grA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:47:27AM -0600, Mathieu Poirier wrote:
> On Tue, 11 Sep 2018 at 04:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On 11/09/18 09:47, Suzuki K Poulose wrote:
> > > We do not enable scatter-gather mode in the TMC-ETR by default
> > > to prevent malfunctioning of systems where the ETR may not be
> > > properly connected to the memory subsystem to allow for simultaneous
> > > READ/WRITE transactions when used in SG mode. Instead we whitelist
> > > the platforms where we know that it is safe to use the mode.
> > >
> > > All revisions of Juno have a proper ETR connection and hence
> > > white list them.
> > >
> >
> > Applied conditionally, this conflicts with the patch Mathieu has in his
> > branch. He needs to drop that so that I can take both of them via ARM SoC.
> 
> As I communicated yesterday, I've already dropped that patch from my tree.

Thanks Mathieu, I have applied both the patches already.

--
Regards,
Sudeep
