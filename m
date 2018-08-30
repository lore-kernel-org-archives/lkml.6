Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A99C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EE12082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE12082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeH3PxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:53:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeH3PxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:53:02 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvLTh-0002IW-AA; Thu, 30 Aug 2018 13:51:09 +0200
Date:   Thu, 30 Aug 2018 13:51:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, lee.jones@linaro.org,
        patches@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v10 2/2] irqchip: Add driver for Cirrus Logic Madera
 codecs
In-Reply-To: <4aa5941b-547d-7218-1b8f-4cd2a01a4fa5@opensource.cirrus.com>
Message-ID: <alpine.DEB.2.21.1808301349380.1210@nanos.tec.linutronix.de>
References: <20180828130934.18135-1-rf@opensource.cirrus.com> <20180828130934.18135-2-rf@opensource.cirrus.com> <alpine.DEB.2.21.1808301154040.1210@nanos.tec.linutronix.de> <4aa5941b-547d-7218-1b8f-4cd2a01a4fa5@opensource.cirrus.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Richard Fitzgerald wrote:
> On 30/08/18 11:31, Thomas Gleixner wrote:
> > On Tue, 28 Aug 2018, Richard Fitzgerald wrote:
> > > @@ -0,0 +1,244 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Interrupt support for Cirrus Logic Madera codecs
> > > + *
> > > + * Copyright (C) 2015-2018 Cirrus Logic
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > the
> > > + * Free Software Foundation; version 2.
> > 
> > You have the SPDX identifier above, which makes this boilerplate
> > superfluous.
> > 
> 
> Our legal people want it left here.
> They are ok with the SPDX reference, but they want to keep an
> explicit statement of the license that was intended.

The SPDX identifier is an explicit statement. Sigh...

Thanks,

	tglx



