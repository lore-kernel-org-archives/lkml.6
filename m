Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08359C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02500206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbeLNPSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:18:30 -0500
Received: from muru.com ([72.249.23.125]:58400 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbeLNPS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:18:29 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EF90B80B6;
        Fri, 14 Dec 2018 15:18:31 +0000 (UTC)
Date:   Fri, 14 Dec 2018 07:18:25 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Felix Brack <fb@ltec.ch>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am33xx: Remove unnecessary properties
Message-ID: <20181214151825.GU6707@atomide.com>
References: <20181210132448.7865-1-fb@ltec.ch>
 <20181211163618.GU6707@atomide.com>
 <20181211164336.GV6707@atomide.com>
 <89710fa1-38a9-1628-0651-003332780483@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89710fa1-38a9-1628-0651-003332780483@ltec.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Felix Brack <fb@ltec.ch> [181214 15:12]:
> Hi Tony,
> 
> On 11.12.2018 17:43, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [181211 16:36]:
> >> * Felix Brack <fb@ltec.ch> [181210 05:25]:
> >>> Remove the unnecessary properties #address-cells and #size-cells
> >>> of node pinmux as there are no child-nodes with property reg.
> >>
> >> Applying into omap-for-v4.21/dt thanks.
> > 
> > Actually this currently conflicts with the pending
> > am33xx l4 ti-sysc changes, so let's wait on this
> > one to avoid causing merge conflicts between
> > branches.
> >
> Okay, I see. The changes introduced by my patch would then affect the
> new file am33xx-l4.dtsi instead of am33xx.dtsi

Yup, and I wanted to keep the am33xx-l4.dtsi in a separate
branch from the rest of the dts changes.

> > So dropping for now.
> >
> Will you "apply" my patch once the am33xx l4 ti-sysc changes are applied
> or do you expect me to send V2 patch (to be applied to the new
> am33xx-l4.dtsi) ?

I'd prefer you to send an updated version against
Linux next as the am33xx-l4.dtsi changes have been
in next for a while now. It is unlikely at this point
that they would not get merged, but I'd rather wait
a bit before applying to avoid mixing the two otherwise
independent branches :)

Regards,

Tony
