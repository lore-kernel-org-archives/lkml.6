Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBHNMB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:12:01 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32587 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeBHNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:11:58 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180208131156epoutp017df20c107c637107e55a9fcf3fd2a34b~RW9Q2PHVn1884718847epoutp01v
X-AuditID: b6c32a38-ac3ff70000001054-2e-5a7c4c9b4e71
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi,
        tomi.valkeinen@ti.com, schwidefsky@de.ibm.com,
        dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for
 Graphics support
Date: Thu, 08 Feb 2018 14:11:53 +0100
Message-id: <1610039.4trOurtpys@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGe3fOzs5W09PUfFMsHQUpahlGJyup8Mcp/DGoQGZgI09TcnPu
        qGRZaJKKH9PyK2f4hYQtUJmSTpflljMxRTetnJWlZF9mhgzNUHIeBf/d7/1cz83Nw4sjIiPX
        C49XJtNqpSxBjAnQp2b/oKCqyHTpofbRMLIrcxYjKxrbUXLU8RsjZ+zPOGSz8TOPnC/I5pKv
        NPNc0tb5ECOL67IQ0j5dhJElhllALgxl88hB/eM1uMaOkdrCUvSUK7W8auNRPVMmjDJoP/Ao
        kzkXUJ9MrSg1md/HobpqFzjUeHUS1VOaj1F979o51IJ+j2S7VHAilk6IT6XVB8MvC+KsGgOm
        mnS7Xv3+LpIBxl3zAB+HRCi0dVhAHhDgIqIDwH7LKOIciIhFAL80qTYhw+TSht8C4GJPGqsd
        AN6fjXJqjAiD93J0a0E47k4chll/bjkzEWIAgb0TA6iTcSOiYInVyfBxlNgP/+W2c5xaSPhD
        68vG9XwP4hxs685Z9/lEOFwZHuexzE64VPJxPQch9sLu52VcVgfCQUsTYHvqeHBqLsXZARIR
        sNGWytpu8EdfG4+1vaG196Sz2hoN4N+xFcA+WgFceOvgsgvHoblvZCPfBc45CrjsshDmZotY
        hIIjy5oN/DSsMRsAexIzgJ1NkmLgo93SWrultXZL61qA6MAuWsUo5DQTogoNZmQKJkUpD76S
        qNCD9T8VQHYA41CkCRA4EO8QPjh6UyriylKZNIUJQBwRuwuNHulSkTBWlnaDVifGqFMSaMYE
        vHFU7CmUSCKkIkIuS6av0bSKVm9OOTjfKwNkKGQv6iovevYrse9Kv9yGuHwVZ/VO0pHzel14
        bGXqNrkuqogsxQ5sc0FHfvq+uS1tKBvU7Zu59LVTEF09wUCX6AtTAUO7K9J/aZ74HevNX5o7
        kzlivRrzWhi8WOj7yFLv862cKjVWNduTVcMzVbrEwMnhs+X87qKg6XqJeqxFjDJxspAARM3I
        /gMOuWd8TwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t9jQd3ZPjVRBjM3ylnsbnzDZjF9xXYW
        iytf37NZPLu1l8li/Z6H7BYfetpYLU70fWC1uLxrDpvFhIXNzBa3HvezWUze+YbR4vO5NnaL
        s5tWAhXPv8VmMat3CosDv8evf5fZPQ4+OsTmsXPWXXaPQ4c7GD0eHNrM4nG/+ziTx+4Fn5k8
        bs4r9Dg4pZvN4/iN7UwenzfJBXBHcdmkpOZklqUW6dslcGVc6tvJVnBfuGLenVbmBsab/F2M
        nBwSAiYSO+//YO5i5OIQEljHKDH98Sx2kISQwFdGidefLEBsNgEriYntqxi7GDk4RASMJJo/
        1oLUMwucZpZYPuc/C0iNsECERNu5LmYQm0VAVeJ3x3YmEJtXQFPi0pEVYHFRAS+JLfvaweKc
        AnYSfy/cZIdYfJhR4uPXl1ANghI/Jt8DG8osIC+xb/9UVghbS2L9zuNMExj5ZyEpm4WkbBaS
        sgWMzKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQIjbNthrb4djPeXxB9iFOBgVOLh
        nWFeHSXEmlhWXJl7iFGCg1lJhHePaE2UEG9KYmVValF+fFFpTmrxIUZpDhYlcd7beccihQTS
        E0tSs1NTC1KLYLJMHJxSDYxbHSt8sy1Zsvk0Lx3u5pxaVpLtdVDQYN73fe++N0o03yw9WaL6
        5V7N6odVaV2fJnVev/k+/5x3+p1vaz1vP4s/ccBoZwyvyY0dZUsCi4/F/2tY/2hlweI5uZnR
        F4MPuaTPjddLvmrssMRsxcetkutmZzC9ujTD8Ny37NOVG1V1/l5bJ3nVb36bEktxRqKhFnNR
        cSIAbYy7OKwCAAA=
X-CMS-MailID: 20180208131155epcas1p350a541b3c662ab5e5b0abc37e4444715
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016
X-RootMTR: 20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
        <CGME20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016@epcas5p3.samsung.com>
        <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

[ dri-devel ML & arch/[score,um] Maintainers added to Cc: ]

On Friday, February 02, 2018 08:59:57 AM Christian Borntraeger wrote:
> On 02/01/2018 07:41 PM, Farhan Ali wrote:
> > The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> > added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> > "Graphics support" menu for S390. But if we enable VT layer for S390,
> > we would also need to enable the dummy console. So let's remove the
> > HAS_IOMEM dependency.
> >
> > Move this dependency to Opencores framebuffer driver which would fail to build
> > with CONFIG_HAS_IOMEM disabled:
> > 
> > ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!

"Graphics support" menu covers other things (i.e. DRM), I assume that
they were also checked to not break due to this change?

Moreover it seems that after this change "Graphics support" menu will
be also enabled (besides s390) for score, tile and um architectures,
I assume that this is okay?

> > Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> > Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> This also enables several PCI based graphic device driver on s390.
> This makes no sense but they all compile fine so I guess this is ok.
> 
> I think patch 2 and 3 are clearly for the s390 tree, patch 1 seems trivial
> Also ccing Bart. Can we maybe get an ack to carry this patch also via the s390
> tree?
> 
> 
> > ---
> >  drivers/video/Kconfig       | 1 -
> >  drivers/video/fbdev/Kconfig | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 3c20af9..41e7ba9 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -3,7 +3,6 @@
> >  #
> > 
> >  menu "Graphics support"
> > -	depends on HAS_IOMEM
> > 
> >  config HAVE_FB_ATMEL
> >  	bool
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index 2f615b7..ec9c9ce 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -966,7 +966,7 @@ config FB_PVR2
> > 
> >  config FB_OPENCORES
> >  	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
> > -	depends on FB && HAS_DMA
> > +	depends on FB && HAS_DMA && HAS_IOMEM
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
