Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933658AbeBULu0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:50:26 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:18914 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933640AbeBULuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:50:20 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180221115018epoutp040228e9498fa0b2a451124a91e610eb29~VVOs5JCvN1332313323epoutp049
X-AuditID: b6c32a39-467ff70000000fc5-05-5a8d5cfa059d
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, tomi.valkeinen@ti.com, thuth@redhat.com
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for
 Graphics support
Date: Wed, 21 Feb 2018 12:50:15 +0100
Message-id: <5067635.OiHnYRPVcg@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <f9ac0bc2-6c36-748a-9d71-44b6481ff261@de.ibm.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdlhTT/dXTG+Uwa/L3Ba7G9+wWUxfsZ3F
        4tmtvUwWJ/o+sFpc3jWHzWLCwmZmi5XHbCzWz7/F5sDhcfDRITaPQ4c7GD0eHNrM4vF+31U2
        j+M3tjN5fN4kF8AWxWWTkpqTWZZapG+XwJVx8NhzpoLF0hVnTvSzNDB+E+li5OSQEDCRmH5n
        BnsXIxeHkMAORomLdyYxgSSEBL4zSvzZEQtTdPLEaSaIot2MEivbTrJAOF8ZJaZ37GQEqWIT
        sJKY2L4KyObgEBEwkmj+WAtSwyxwmFFi48/ZYDXCAhESDd+Ps4DYLAKqEuunXwbbxiugKXFi
        +T9mEFtUwEtiy752sDingJ3ElEmzWCFqBCV+TL4H1sssIC+xb/9UVghbR+LssXWMIMskBM6w
        SfSufsUGcbaLxNt5/6BsYYlXx7ewgxwnISAtcemoLUT9KkaJn1f/QjVvZpT4fP0rK0SDtcTh
        4xehNvBJvPvawwrRzCvR0SYEYXpIvN0tBlHtKNH+ZDU0GIEe3n28mWkCo+wsJHfPQnL3LCR3
        L2BkXsUollpQnJueWmxYYKpXnJhbXJqXrpecn7uJEZw2tCx3MB4753OIUYCDUYmH94FmT5QQ
        a2JZcWXuIUYJDmYlEV6F8N4oId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwBAS5RQgLpiSWp2amp
        BalFMFkmDk6pBsbS3+vM/mxtXrDx1HObwx7WT6w3N92apqB/J998wtEvr+7n/ipVKN7+pj67
        dcqaY9E1kVF9i/Zs5tJaciOo7MtPg6aXf8IPGj9Yljnv67fumN+Vr3Zfne3Ywj051LP6k/Ze
        xsvnmCZyvOaYmCz/0M5spdYSneb4ltdvWq/x8BQ8+j3Z4q3m0WwmJZbijERDLeai4kQAmlrW
        9BcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsVy+t9jAd2fMb1RBu87jS12N75hs5i+YjuL
        xbNbe5ksTvR9YLW4vGsOm8WEhc3MFiuP2Visn3+LzYHD4+CjQ2wehw53MHo8OLSZxeP9vqts
        HsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugSvj4LHnTAWLpSvOnOhnaWD8JtLFyMkhIWAicfLE
        aaYuRi4OIYGdjBK9L6YzQzhfGSVWL+xnBKliE7CSmNi+Csjm4BARMJJo/lgLUsMscJhR4u2O
        ZmaQGmGBCIn/l6ayg9gsAqoS66dfZgKxeQU0JU4s/wdWIyrgJbFlXztYnFPATmLKpFmsEMuA
        Bk1uWwHVICjxY/I9FhCbWUBeYt/+qawQtpbE+p3HmSYw8s9CUjYLSdksJGULGJlXMUqmFhTn
        pucWGxUY5qWW6xUn5haX5qXrJefnbmIEhvq2w1p9OxjvL4k/xCjAwajEw2uh0xMlxJpYVlyZ
        e4hRgoNZSYRXIbw3Sog3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZ
        Jg5OqQZGgcuW3ze8eD137xHji+r9didYuG/366cnTjqxtcR/u9Cc81enFD/Vr5hzesJq9dUK
        d1ekWEyprnQyCnVf+n/7CptFK3d1+87326BSMHWH1tbq+1M26gqwxvuWtZZcfhVWdfZQ4t/b
        GlfLQurfrjvd8ih0qbOC5SN+BeYbkUXPe3dndhTvsIg5psRSnJFoqMVcVJwIAKHHGTJxAgAA
X-CMS-MailID: 20180221115017epcas1p40469a151a863403b88864f5784ab03e5
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180221084454epcas3p2a811c2c041e2933afb8288af39b216e2
X-RootMTR: 20180221084454epcas3p2a811c2c041e2933afb8288af39b216e2
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
        <CGME20180221084454epcas3p2a811c2c041e2933afb8288af39b216e2@epcas3p2.samsung.com>
        <f9ac0bc2-6c36-748a-9d71-44b6481ff261@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, February 21, 2018 09:44:43 AM Christian Borntraeger wrote:
> 
> On 02/19/2018 04:47 PM, Farhan Ali wrote:
> > The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> > added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> > "Graphics support" menu for S390. But if we enable VT layer for S390,
> > we would also need to enable the dummy console. So let's remove the
> > HAS_IOMEM dependency.
> > 
> > Move this dependency to sub menu items and console drivers that use
> > io memory.
> > 
> > Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> This patch is part of todays linux-next and so far no fallout was reported.
> Shall I take that patch via the s390kvm tree (then I would like to have
> an ack. Bart?) or is anybody on cc willing to take this?

I would like to see two things changed before acking this patch:

- add missing HAS_IOMEM dependency to VGA_CONSOLE

- extend "if HAS_IOMEM" in drivers/video/Kconfig to cover config items
  previously covered by this dependency (it should start before config
  HAVE_FB_ATMEL and end after config HDMI)

> Christian
> 
> 
> 
> > ---
> >  drivers/video/Kconfig         | 21 +++++++++++----------
> >  drivers/video/console/Kconfig |  4 ++--
> >  2 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 3c20af9..8f10915 100644
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
> > @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
> >  config SH_LCD_MIPI_DSI
> >  	bool
> > 
> > -source "drivers/char/agp/Kconfig"
> > +if HAS_IOMEM
> > +	source "drivers/char/agp/Kconfig"
> > 
> > -source "drivers/gpu/vga/Kconfig"
> > +	source "drivers/gpu/vga/Kconfig"
> > 
> > -source "drivers/gpu/host1x/Kconfig"
> > -source "drivers/gpu/ipu-v3/Kconfig"
> > +	source "drivers/gpu/host1x/Kconfig"
> > +	source "drivers/gpu/ipu-v3/Kconfig"
> > 
> > -source "drivers/gpu/drm/Kconfig"
> > +	source "drivers/gpu/drm/Kconfig"
> > 
> > -menu "Frame buffer Devices"
> > -source "drivers/video/fbdev/Kconfig"
> > -endmenu
> > +	menu "Frame buffer Devices"
> > +	source "drivers/video/fbdev/Kconfig"
> > +	endmenu
> > 
> > -source "drivers/video/backlight/Kconfig"
> > +        source "drivers/video/backlight/Kconfig"
> > +endif
> > 
> >  config VGASTATE
> >         tristate
> > diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> > index 7f1f1fb..0023b16 100644
> > --- a/drivers/video/console/Kconfig
> > +++ b/drivers/video/console/Kconfig
> > @@ -85,7 +85,7 @@ config MDA_CONSOLE
> > 
> >  config SGI_NEWPORT_CONSOLE
> >          tristate "SGI Newport Console support"
> > -        depends on SGI_IP22 
> > +        depends on SGI_IP22 && HAS_IOMEM
> >          select FONT_SUPPORT
> >          help
> >            Say Y here if you want the console on the Newport aka XL graphics
> > @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
> > 
> >  config STI_CONSOLE
> >          bool "STI text console"
> > -        depends on PARISC
> > +        depends on PARISC && HAS_IOMEM
> >          select FONT_SUPPORT
> >          default y
> >          help

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
