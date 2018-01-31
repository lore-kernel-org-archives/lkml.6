Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeAaWxN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:53:13 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40013 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeAaWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:53:11 -0500
X-Google-Smtp-Source: AH8x225+YaATu4rFPGplIzMu0ulYGraWBru4/f63xJMIm4DtqgRST/h3d+3804R3s0kG7kyaqWLjOQ==
Date: Wed, 31 Jan 2018 14:53:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Andi Shyti <andi.shyti@samsung.com>,
        Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>,
        jeesw@melfas.com
Subject: Re: [PATCH 7/8] Input: mms114 - add SPDX identifier
Message-ID: <20180131225307.i5meawlhkwwje4qb@dtor-ws>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
 <CGME20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c@epcas2p1.samsung.com>
 <20180129113323.18961-8-andi.shyti@samsung.com>
 <20180129194659.df7nlhwx4demk6o6@dtor-ws>
 <20180131060726.GB7575@gangnam.samsung>
 <20180131073138.GA1499@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131073138.GA1499@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 08:31:38AM +0100, Marcus Folkesson wrote:
> Hi Andy,
> 
> On Wed, Jan 31, 2018 at 03:07:26PM +0900, Andi Shyti wrote:
> > Hi Dmitry,
> > 
> > > > -/*
> > > > - * Copyright (C) 2012 Samsung Electronics Co.Ltd
> > > > - * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> > > > - *
> > > > - * This program is free software; you can redistribute it and/or modify
> > > > - * it under the terms of the GNU General Public License version 2 as
> > > > - * published by the Free Software Foundation.
> > > > - */
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +// Samsung S6SY761 Touchscreen device driver
> > 
> > I'm very sorry, but my distrcation will kill me one day.
> 
> More coffee or sleep - your choice ;-)
> 
> > 
> > Is it possible to revert this patch or do you want me to send a
> > fix?
> 
> When you are on it;
> 
> Change
> MODULE_LICENSE("GPL");
> 
> to 
> MODULE_LICENSE("GPL v2");
> To match the former license text and SPDX-identifier.
> 
> See include/linux/module.h:
>  *	"GPL"				[GNU Public License v2 or later]
>  *	"GPL v2"			[GNU Public License v2]

OK, I dropped the patch, please resend the correct version.

Thanks.

-- 
Dmitry
