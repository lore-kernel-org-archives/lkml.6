Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeBUKT5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:19:57 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:9015 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeBUKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:55 -0500
X-IronPort-AV: E=Sophos;i="5.46,543,1511827200";
   d="scan'208";a="68286368"
Date: Wed, 21 Feb 2018 10:19:48 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <airlied@linux.ie>,
        <daniel.vetter@intel.com>, <seanpaul@chromium.org>,
        <gustavo@padovan.org>, <jgross@suse.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [Xen-devel] [PATCH 1/9] drm/xen-front: Introduce Xen
 para-virtualized frontend driver
Message-ID: <20180221101948.4rkpgu4p2vqe7dut@MacBook-Pro-de-Roger.local>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-2-git-send-email-andr2000@gmail.com>
 <20180221091751.ebczu3kzv6j7zykp@MacBook-Pro-de-Roger.local>
 <8caebdda-47ac-a1d8-73d2-7b889c997a5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8caebdda-47ac-a1d8-73d2-7b889c997a5a@gmail.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:42:23AM +0200, Oleksandr Andrushchenko wrote:
> On 02/21/2018 11:17 AM, Roger Pau Monné wrote:
> > On Wed, Feb 21, 2018 at 10:03:34AM +0200, Oleksandr Andrushchenko wrote:
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> > > @@ -0,0 +1,83 @@
> > > +/*
> > > + *  Xen para-virtual DRM device
> > > + *
> > > + *   This program is free software; you can redistribute it and/or modify
> > > + *   it under the terms of the GNU General Public License as published by
> > > + *   the Free Software Foundation; either version 2 of the License, or
> > > + *   (at your option) any later version.
> > > + *
> > > + *   This program is distributed in the hope that it will be useful,
> > > + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + *   GNU General Public License for more details.
> > Most Xen drivers in Linux use a dual GPL/BSD license, so that they can
> > be imported into other non GPL OSes:
> > 
> > This program is free software; you can redistribute it and/or
> > modify it under the terms of the GNU General Public License version 2
> > as published by the Free Software Foundation; or, when distributed
> > separately from the Linux kernel or incorporated into other
> > software packages, subject to the following license:
> > 
> > Permission is hereby granted, free of charge, to any person obtaining a copy
> > of this source file (the "Software"), to deal in the Software without
> > restriction, including without limitation the rights to use, copy, modify,
> > merge, publish, distribute, sublicense, and/or sell copies of the Software,
> > and to permit persons to whom the Software is furnished to do so, subject to
> > the following conditions:
> > 
> > The above copyright notice and this permission notice shall be included in
> > all copies or substantial portions of the Software.
> > 
> > THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> > AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> > IN THE SOFTWARE.
> > 
> > IMO it would be good to release this driver under the same license, so
> > it can be incorporated into other OSes.
> I am in any way expert in licensing, but the above seems to be
> /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> At least this is what I see at [1] for MIT.
> Could you please tell which license(s) as listed at [1]
> would be appropriate for Xen drivers in terms of how it is
> expected to appear in the kernel code, e.g. expected
> SPDX-License-Identifier?

I would be fine with anything MIT/BSD-*/Apache-* like. In the Xen
community we have generally done dual GPL-2.0 MIT, so your proposed
tag looks fine IMO (I would also personally be fine with
MIT/BSD-*/Apache-* only).

The point is that it would be good to have the code under a more
permissive license so it can be integrated into non GPL OSes in the
future if needed, and that your code could be used as a reference for
that.

Thanks, Roger.
