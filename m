Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeEDKsy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:48:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33840 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:48:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180504104849euoutp0189dd82baf76ecd4220f4064e1a402fe2~ra1kgzuu02245722457euoutp01I
X-AuditID: cbfec7f4-713ff700000043e4-2d-5aec3a8f9d90
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, tomi.valkeinen@ti.com,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: omap2: Kconfig: make FB_OMAP2_DSS_INIT depend
 on OF
Date: Fri, 04 May 2018 12:48:46 +0200
Message-id: <44871995.YYHkG5ofpC@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <16e74acc-1265-faec-0c36-49681a7760e4@infradead.org>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzned1+qzdRBguOGVvcmvKbyeLK1/ds
        Fif6PrBaXN41h81i9pJ+Fov7Swot3t6ZzmKxfv4tNgcOj80rtDzuXNvD5nG/+ziTx6ZPd1k9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV0bPrga2gh6Rij0f3rM0ML4X6GLk5JAQMJG42POU
        uYuRi0NIYAWjxNKDPWwQzmdGiY7Pe5lhqn40LQWzhQSWMUq8WBQGYf9mlFi2PRbEZhOwkpjY
        vooRxBYRiJHoaD3NBDKIWWA/o8S2/WvBmoUFgiUmbFnHAmKzCKhK/Dy0DyzOK6AlcfxZG5gt
        KuAlsWVfOxOIzSngKHHh5l12iBpBiR+T74H1MgtoSzx5d4EVwtaUePFlEgvIMgmBE2wSay+e
        ZoW42kXi6v25UB8IS7w6voUdwpaRuDy5G6qhmVHi2449UEUTGCX2rBeCsK0lDh+/CLWBT2LS
        tulANRxAcV6JjjaoEg+JD23P2SHCjhKXr8lAQu4Eo8Tehu3MExhlZyG5exaSu2chuXsBI/Mq
        RvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwLRx+t/xLzsYd/1JOsQowMGoxMMr4PA6Sog1
        say4MvcQowQHs5II76xDQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWp
        RTBZJg5OqQZGKXauhKUzGpiYkv68Cf+920uy4a3+mar2Nx5u/0Imn70l7NB1dDvjnGkGc2VM
        HjFK1m2aanSSd2vFWWX3GHHNTR8lZx9z2XUgVncr+4W4RS/uSez2vmi+ztZpcor9p5Prrq1v
        KtksZ6s5Ifjn2zNKjnKafvpJ/87WHn8Wu2rdm+kiF2d9N/QzUGIpzkg01GIuKk4EACOZFcIX
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xa7r9Vm+iDPY2c1jcmvKbyeLK1/ds
        Fif6PrBaXN41h81i9pJ+Fov7Swot3t6ZzmKxfv4tNgcOj80rtDzuXNvD5nG/+ziTx6ZPd1k9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV0bPrga2gh6Rij0f3rM0ML4X6GLk5JAQMJH40bSU
        uYuRi0NIYAmjxJwvm1khnL+MEkd657KCVLEJWElMbF/F2MXIwSEiECMx9ZQESA2zwH5GiVOL
        TzOD1AgLBEtc+vWYEcRmEVCV+HloH1icV0BL4vizNjBbVMBLYsu+diYQm1PAUeLCzbvsEMtO
        MEoc/HKcDaJBUOLH5HssIDazgLbEk3cXWEEWMwuoS0yZkjuBkX8WkqpZSKpmIVQtYGRexSiS
        Wlqcm55bbKRXnJhbXJqXrpecn7uJERja24793LKDsetd8CFGAQ5GJR5eAYfXUUKsiWXFlbmH
        GCU4mJVEeGcdAgrxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5YkpqdmlqQWgSTZeLg
        lGpgvLxul4Zr7PkNU6rnHDU8kPTqQemX0P+fM1cePTpNoUY5hN9KtZM1IWpimPKSru5tsq4P
        X9xsZb9/ZIfYsr83+5g360/YVqhQm/hiFyP39kz1H5EOiXWbdruWb6s+fDwq8MTRCS+1Pgqo
        suloRrxt4zvCcSPuYPaquNcP59a7ea6rcrI34L+drMRSnJFoqMVcVJwIAO2wlnJpAgAA
X-CMS-MailID: 20180504104847eucas1p2ebc65985bcce1b2b0a8e16fff494fa55
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180503154901epcas2p417fd08a4daaf1520ec4d8ed1312728c8
X-RootMTR: 20180503154901epcas2p417fd08a4daaf1520ec4d8ed1312728c8
References: <20180420112551.27027-1-anders.roxell@linaro.org>
        <CGME20180503154901epcas2p417fd08a4daaf1520ec4d8ed1312728c8@epcas2p4.samsung.com>
        <16e74acc-1265-faec-0c36-49681a7760e4@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44An1lM023183

On Thursday, May 03, 2018 08:48:56 AM Randy Dunlap wrote:
> On 04/20/2018 04:25 AM, Anders Roxell wrote:
> > Commit 7378f1149884 ("media: omap2: omapfb: allow building it with
> > COMPILE_TEST") broke compilation without CONFIG_OF selected.
> >   CC      drivers/video/fbdev/core/fbmem.o
> > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c: In function ‘omapdss_update_prop’:
> > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:68:2: error: implicit declaration of function ‘of_update_property’; did you mean ‘of_get_property’? [-Werror=implicit-function-declaration]
> >   of_update_property(node, prop);
> >   ^~~~~~~~~~~~~~~~~~
> >   of_get_property
> > cc1: some warnings being treated as errors
> > scripts/Makefile.build:312: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o' failed
> > make[7]: *** [drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o] Error 1
> > scripts/Makefile.build:559: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss' failed
> > make[6]: *** [drivers/video/fbdev/omap2/omapfb/dss] Error 2
> > make[6]: *** Waiting for unfinished jobs....
> > 
> > Add OF dependency in order to make all configurations work again.
> > 
> > of_update_property() has no inline stub, and that that could be added as
> > an alternative.
> > 
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  drivers/video/fbdev/omap2/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
> > index 82008699d253..4de381f2452e 100644
> > --- a/drivers/video/fbdev/omap2/Kconfig
> > +++ b/drivers/video/fbdev/omap2/Kconfig
> > @@ -1,4 +1,4 @@
> > -if ARCH_OMAP2PLUS || COMPILE_TEST
> > +if OF && (ARCH_OMAP2PLUS || COMPILE_TEST)
> >  
> >  source "drivers/video/fbdev/omap2/omapfb/Kconfig"
> >  
> > 
> 
> Hi,
> 
> This patch certainly fixes the build errors that I have been seeing in
> linux-next for several days now, so:
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

Since there has been no follow up from Mauro on this ([1]) I guess
that the best thing I can do is simply merging both patches to fbdev
tree..

[1] https://www.spinics.net/lists/linux-media/msg132583.html

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
