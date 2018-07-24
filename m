Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7321C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F732064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F732064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbeGXPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:51:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36290 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388495AbeGXPvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:51:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3D434207AD; Tue, 24 Jul 2018 16:44:18 +0200 (CEST)
Received: from windsurf (176.199.29.109.rev.sfr.net [109.29.199.176])
        by mail.bootlin.com (Postfix) with ESMTPSA id C8062206A6;
        Tue, 24 Jul 2018 16:44:07 +0200 (CEST)
Date:   Tue, 24 Jul 2018 16:44:07 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>
Subject: Re: [PATCH 1/2] sparc: move MSI related definitions to where they
 are used
Message-ID: <20180724164407.4fa57d1f@windsurf>
In-Reply-To: <20180724143736.GA22088@ravnborg.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
        <20180724143736.GA22088@ravnborg.org>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the review.

On Tue, 24 Jul 2018 16:37:36 +0200, Sam Ravnborg wrote:

> One nitpick below.
> But other than that this is a nice cleanup:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > +/*
> > + * Locations of MSI Registers.
> > + */  
> 
> The SPARC way to format comments follows netdev style.
> So put it all in one line and everyone are happy:

Well, the code is being moved from arch/sparc to arch/sparc, so
apparently, it was already non-compliant to this specific coding style
rule. Should the comments be made compliant as part of the same commit,
or a separate one ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
