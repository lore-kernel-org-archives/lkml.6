Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58B5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FA6208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FA6208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeJAPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:46:55 -0400
Received: from foss.arm.com ([217.140.101.70]:45288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbeJAPqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:46:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 761167A9;
        Mon,  1 Oct 2018 02:10:09 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8F03F5B3;
        Mon,  1 Oct 2018 02:10:08 -0700 (PDT)
Date:   Mon, 1 Oct 2018 10:09:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20181001090958.GA30406@e107155-lin>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-17-robh@kernel.org>
 <CAL_JsqJfWuL5NwXU_Ar76=MHgBeMPJqgDu9F8V+A=mC3Dor=9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJfWuL5NwXU_Ar76=MHgBeMPJqgDu9F8V+A=mC3Dor=9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:47:41PM -0500, Rob Herring wrote:
> On Mon, Aug 27, 2018 at 8:53 PM Rob Herring <robh@kernel.org> wrote:
> >
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/firmware/scpi_pm_domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Sudeep, looks like I missed Cc'ing you (or anyone) on this. Can you
> please ack or apply this.
>
I prefer you to take it via your tree as that may be easier.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

