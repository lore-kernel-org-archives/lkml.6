Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E7C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC35B2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC35B2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeHTXHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:07:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51244 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTXHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:07:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6853C20794; Mon, 20 Aug 2018 21:50:04 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3D5CE204AE;
        Mon, 20 Aug 2018 21:50:04 +0200 (CEST)
Date:   Mon, 20 Aug 2018 21:50:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, od@zcrc.me,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20180820195002.GW21707@piout.net>
References: <20180820180716.1853-1-paul@crapouillou.net>
 <20180820191247.GU21707@piout.net>
 <1534792697.1744.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534792697.1744.0@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2018 21:18:17+0200, Paul Cercueil wrote:
> Hi,
> 
> Le lun. 20 août 2018 à 21:12, Alexandre Belloni
> <alexandre.belloni@bootlin.com> a écrit :
> > On 20/08/2018 20:07:16+0200, Paul Cercueil wrote:
> > >  Depending on MACH_INGENIC prevent us from creating a generic kernel
> > > that
> > >  works on more than one MIPS board. Instead, we just depend on MIPS
> > > being
> > >  set.
> > 
> > Maybe you could consider dropping the whole dependency as we already
> > know it will build on every architecture.
> 
> Well, I didn't really want the Kconfig option to show on the menu when
> compiling for non-MIPS, since it's only ever useful there.
> 
> Should I drop the dependency then?
> 

No, I don't mind.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
