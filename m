Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeEDM5r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:57:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43759 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:57:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180504125743euoutp013bbf4570fe953c98cde64116679300e9~rcmHaCfyA1984219842euoutp01b
X-AuditID: cbfec7f4-713ff700000043e4-86-5aec58c6bb3a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Anders Roxell <anders.roxell@linaro.org>, tomi.valkeinen@ti.com,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: omap2: Kconfig: make FB_OMAP2_DSS_INIT depend
 on OF
Date: Fri, 04 May 2018 14:57:41 +0200
Message-id: <7595627.YEWfNVcOa0@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180504094526.03484b2d@vento.lan>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzned1jEW+iDL6/kre4NeU3k8WVr+/Z
        LE70fWC1uLxrDpvF7CX9LBbvP3UyWby9M53FYv38W2wOHB6bV2h5bFrVyeZx59oeNo/73ceZ
        PI7f2M7k8XmTXABbFJdNSmpOZllqkb5dAlfGxe/f2ArmKlQ0bPjK3MC4WrKLkZNDQsBE4snd
        t2xdjFwcQgIrGCUWXXvIDuF8ZpTo73rM1MXIAVZ1rZ0XIr6MUWJu318mCOc3o8TSjTdZQUax
        CVhJTGxfxQhiiwiYSZw8dxRsLLPAc0aJfWsvsoEkhAWCJSZsWccCYrMIqErsfzANrJlXQFPi
        9qxGMFtUwEtiy752JhCbU8BA4tXJLSwQNYISPybfA7OZBbQlnry7wApha0q8+DKJBWSZhMAJ
        Nom7S3+xQDznItF69SgzhC0s8er4FnYIW0ais+MgE0RDM6PEtx17oIomMErsWS8EYVtLHD5+
        EWoDn8SkbdOZIWHBK9HRBlXiIXHr4VdGCNtR4vPJR4yQYLnKKDG57QrLBEbZWUgOn4Xk8FlI
        Dl/AyLyKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMHmc/nf8yw7GXX+SDjEKcDAq8fAK
        OLyOEmJNLCuuzD3EKMHBrCTCO+sQUIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvnEZdlJBAemJJ
        anZqakFqEUyWiYNTqoFx6/y250KrjrkGs9wQVq+VVBOeXd5T5ryA1ymA6dDb1IX7F4Zk3nxz
        4x3jksjlca5Xnn+debb19wtR5xNH3283rAn6LMO6jvOexJnPXBOPRnGUHL4/p2ePqC3jg9Vy
        cm1aR/JzdyktXRxeWLrb+JP7L+222Vw7i/orM9es5Ona+HHvn/Ibli6flFiKMxINtZiLihMB
        qMcI1BoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t/xq7pHI95EGSzotra4NeU3k8WVr+/Z
        LE70fWC1uLxrDpvF7CX9LBbvP3UyWby9M53FYv38W2wOHB6bV2h5bFrVyeZx59oeNo/73ceZ
        PI7f2M7k8XmTXABbFJdNSmpOZllqkb5dAlfGxe/f2ArmKlQ0bPjK3MC4WrKLkYNDQsBE4lo7
        bxcjF4eQwBJGibm3TrBBOH8ZJY5vvgfkcHKwCVhJTGxfxQhiiwiYSZw8dxSsiFngOaPE4T2X
        WEESwgLBEpd+PQYrYhFQldj/YBpYnFdAU+L2rEYwW1TAS2LLvnYmEJtTwEDi1cktLBDbGhkl
        Hn19yQzRICjxY/I9FhCbWUBb4sm7C6wgpzILqEtMmZI7gZF/FpKqWUiqZiFULWBkXsUoklpa
        nJueW2yoV5yYW1yal66XnJ+7iREY3NuO/dy8g/HSxuBDjAIcjEo8vDtsX0cJsSaWFVfmHmKU
        4GBWEuGddQgoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6YklqdmpqQWoRTJaJg1Oq
        gTFj6aTKIPNPm45mBWX57TjeJbWs4H5YtDzTtv2StXONm7pmsciFGx+KuqOx5/dcnvg13ScK
        O03WfDjzLaV3CfN8f6YbEiZdByQmrW0pP8vSErbk33yXQyxLJK+sNT+l5DBP7mDZ7jcaCw6w
        yP0uPbU1oSZg3YFvweyyGgcmaXhzV0SLM7/efVeJpTgj0VCLuag4EQAACG0ragIAAA==
X-CMS-MailID: 20180504125742eucas1p2adf710f1c7d6ef20c207d9bb45961d6a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504125742eucas1p2adf710f1c7d6ef20c207d9bb45961d6a
X-RootMTR: 20180504125742eucas1p2adf710f1c7d6ef20c207d9bb45961d6a
References: <20180420112551.27027-1-anders.roxell@linaro.org>
        <1544113.qp318iEQvZ@amdc3058> <20180504094526.03484b2d@vento.lan>
        <CGME20180504125742eucas1p2adf710f1c7d6ef20c207d9bb45961d6a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44CvsFs030481

On Friday, May 04, 2018 09:45:26 AM Mauro Carvalho Chehab wrote:
> Em Fri, 04 May 2018 13:05:17 +0200
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> escreveu:
> 
> > On Friday, May 04, 2018 07:59:06 AM Mauro Carvalho Chehab wrote:
> > > Em Fri, 04 May 2018 12:48:46 +0200
> > > Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> escreveu:
> > >   
> > > > On Thursday, May 03, 2018 08:48:56 AM Randy Dunlap wrote:  
> > > > > On 04/20/2018 04:25 AM, Anders Roxell wrote:    
> > > > > > Commit 7378f1149884 ("media: omap2: omapfb: allow building it with
> > > > > > COMPILE_TEST") broke compilation without CONFIG_OF selected.
> > > > > >   CC      drivers/video/fbdev/core/fbmem.o
> > > > > > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c: In function ‘omapdss_update_prop’:
> > > > > > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:68:2: error: implicit declaration of function ‘of_update_property’; did you mean ‘of_get_property’? [-Werror=implicit-function-declaration]
> > > > > >   of_update_property(node, prop);
> > > > > >   ^~~~~~~~~~~~~~~~~~
> > > > > >   of_get_property
> > > > > > cc1: some warnings being treated as errors
> > > > > > scripts/Makefile.build:312: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o' failed
> > > > > > make[7]: *** [drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o] Error 1
> > > > > > scripts/Makefile.build:559: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss' failed
> > > > > > make[6]: *** [drivers/video/fbdev/omap2/omapfb/dss] Error 2
> > > > > > make[6]: *** Waiting for unfinished jobs....
> > > > > > 
> > > > > > Add OF dependency in order to make all configurations work again.
> > > > > > 
> > > > > > of_update_property() has no inline stub, and that that could be added as
> > > > > > an alternative.
> > > > > > 
> > > > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > > > ---
> > > > > >  drivers/video/fbdev/omap2/Kconfig | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
> > > > > > index 82008699d253..4de381f2452e 100644
> > > > > > --- a/drivers/video/fbdev/omap2/Kconfig
> > > > > > +++ b/drivers/video/fbdev/omap2/Kconfig
> > > > > > @@ -1,4 +1,4 @@
> > > > > > -if ARCH_OMAP2PLUS || COMPILE_TEST
> > > > > > +if OF && (ARCH_OMAP2PLUS || COMPILE_TEST)
> > > > > >  
> > > > > >  source "drivers/video/fbdev/omap2/omapfb/Kconfig"
> > > > > >  
> > > > > >     
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > This patch certainly fixes the build errors that I have been seeing in
> > > > > linux-next for several days now, so:
> > > > > 
> > > > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > > > Tested-by: Randy Dunlap <rdunlap@infradead.org>    
> > > > 
> > > > Thanks.
> > > > 
> > > > Since there has been no follow up from Mauro on this ([1]) I guess
> > > > that the best thing I can do is simply merging both patches to fbdev
> > > > tree..
> 
> When you're saying about "both" patches, you're referring to the
> original one plus this fix, right?

Right.

> > > > 
> > > > [1] https://www.spinics.net/lists/linux-media/msg132583.html  
> > > 
> > > Sorry, it seems I missed it. If you didn't merge them yet, I'll
> > > merge it on my tree today, if you think it would be best to have
> > > it together with the patch that enabled FB_OMAP builds with
> > > COMPILE_TEST.  
> 
> I know why I missed... I was not c/c at the original patch. Well,
> I received it at my LKML inbox, but nobody reads all LKML emails
> those days.
> 
> > 
> > This would be best indeed, you can add my ACK:
> > 
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Committed.

Thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
