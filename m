Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeEDLFZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:05:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38902 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEDLFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:05:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180504110520euoutp017c13200534b3f2a618bd49fbb1364a53~rbD-4wFNi3044830448euoutp017
X-AuditID: cbfec7f4-6f9ff700000043e4-67-5aec3e6f3d30
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Anders Roxell <anders.roxell@linaro.org>, tomi.valkeinen@ti.com,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: omap2: Kconfig: make FB_OMAP2_DSS_INIT depend
 on OF
Date: Fri, 04 May 2018 13:05:17 +0200
Message-id: <1544113.qp318iEQvZ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180504075906.02ecf32e@vento.lan>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzned18uzdRBlO/KVvcmvKbyeLK1/ds
        Fif6PrBaXN41h81i9pJ+Fov3nzqZLN7emc5isX7+LTYHDo/NK7Q8Nq3qZPO4c20Pm8f97uNM
        HsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugSvj25LpzAUHZCqOPXjC2sA4SbyLkZNDQsBEovnn
        fqYuRi4OIYEVjBIbvp5lg3A+M0rcXnqPFaaq89dSFojEMkaJeUuPMUI4vxkleiafB6tiE7CS
        mNi+ihHEFhEwkzh57ijYKGaB54wS+9ZeZANJCAsES0zYso4FxGYRUJXYte0jM4jNK6Ap8ev5
        E7C4qICXxJZ97UwgNqeAgcSS+7tYIGoEJX5MvgdmMwtoSzx5d4EVwtaUePFlEth5EgIn2CTO
        PJzPDnG3i8SKm/8YIWxhiVfHt0DFZSQ6Ow4yQTQ0M0p827GHGSIxgVFiz3ohCNta4vDxi1Ab
        +CQmbZsOVMMBFOeV6GgTgjA9JA69SoeodpTY8/kXNIiuMUpsnzKdeQKj7Cwkd89CcvcsJHcv
        YGRexSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZg8Tv87/mUH464/SYcYBTgYlXh4BRxe
        RwmxJpYVV+YeYpTgYFYS4Z11CCjEm5JYWZValB9fVJqTWnyIUZqDRUmcN06jLkpIID2xJDU7
        NbUgtQgmy8TBKdXAWHtp40kdgRuXXx7SYplj/q1GoahTX5vLzkSlt+zEB5l9E1UdmtU5Dj56
        tnIN/waxefPsbh9YP++95K/KT1c6NybVXZ340uif2e1NqtWfflzsiPTanpyU+8au7/1Mtj9B
        5x4o2O2qTBIxi7nHxL+QlyM6QEjKTWv6s8VMq9nzl5X09HErFVnrKLEUZyQaajEXFScCACh3
        hlUaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsVy+t/xa7q5dm+iDPZ1KVvcmvKbyeLK1/ds
        Fif6PrBaXN41h81i9pJ+Fov3nzqZLN7emc5isX7+LTYHDo/NK7Q8Nq3qZPO4c20Pm8f97uNM
        HsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugSvj25LpzAUHZCqOPXjC2sA4SbyLkZNDQsBEovPX
        UpYuRi4OIYEljBKdjauYIZy/jBJ/24+zgFSxCVhJTGxfxQhiiwiYSZw8d5QNpIhZ4DmjxOE9
        l1hBEsICwRKXfj0GK2IRUJXYte0jM4jNK6Ap8ev5E7BBogJeElv2tTOB2JwCBhJL7u+CWt3E
        KNF38RYbRIOgxI/J98AamAW0JZ68uwC0gAPIVpeYMiV3AiP/LCRVs5BUzUKoWsDIvIpRJLW0
        ODc9t9hQrzgxt7g0L10vOT93EyMwvLcd+7l5B+OljcGHGAU4GJV4eHfYvo4SYk0sK67MPcQo
        wcGsJMI76xBQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dU
        A2P/JLdZKgc0Lrclt4d+T7C/8/1AVvwP7zrv4rspdmVnz8w6euWb/urey1qPLh5s+nEx/JlX
        R/2sqcsK1jx4Et4+h9tGSebz0zpJb563ln9KxAJmi6XcOqC+4AdLxwQmwzXxXpMqbix/dNNU
        a5r2KlbtXRk75yZusuV6JLGdz2Aanz3j0VNaZ9qUWIozEg21mIuKEwEMrLBNawIAAA==
X-CMS-MailID: 20180504110518eucas1p1f79dec0a8def38083f82885c9c47bd5d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504110518eucas1p1f79dec0a8def38083f82885c9c47bd5d
X-RootMTR: 20180504110518eucas1p1f79dec0a8def38083f82885c9c47bd5d
References: <20180420112551.27027-1-anders.roxell@linaro.org>
        <44871995.YYHkG5ofpC@amdc3058> <20180504075906.02ecf32e@vento.lan>
        <CGME20180504110518eucas1p1f79dec0a8def38083f82885c9c47bd5d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44B5V2F023245

On Friday, May 04, 2018 07:59:06 AM Mauro Carvalho Chehab wrote:
> Em Fri, 04 May 2018 12:48:46 +0200
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> escreveu:
> 
> > On Thursday, May 03, 2018 08:48:56 AM Randy Dunlap wrote:
> > > On 04/20/2018 04:25 AM, Anders Roxell wrote:  
> > > > Commit 7378f1149884 ("media: omap2: omapfb: allow building it with
> > > > COMPILE_TEST") broke compilation without CONFIG_OF selected.
> > > >   CC      drivers/video/fbdev/core/fbmem.o
> > > > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c: In function ‘omapdss_update_prop’:
> > > > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:68:2: error: implicit declaration of function ‘of_update_property’; did you mean ‘of_get_property’? [-Werror=implicit-function-declaration]
> > > >   of_update_property(node, prop);
> > > >   ^~~~~~~~~~~~~~~~~~
> > > >   of_get_property
> > > > cc1: some warnings being treated as errors
> > > > scripts/Makefile.build:312: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o' failed
> > > > make[7]: *** [drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o] Error 1
> > > > scripts/Makefile.build:559: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss' failed
> > > > make[6]: *** [drivers/video/fbdev/omap2/omapfb/dss] Error 2
> > > > make[6]: *** Waiting for unfinished jobs....
> > > > 
> > > > Add OF dependency in order to make all configurations work again.
> > > > 
> > > > of_update_property() has no inline stub, and that that could be added as
> > > > an alternative.
> > > > 
> > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > ---
> > > >  drivers/video/fbdev/omap2/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
> > > > index 82008699d253..4de381f2452e 100644
> > > > --- a/drivers/video/fbdev/omap2/Kconfig
> > > > +++ b/drivers/video/fbdev/omap2/Kconfig
> > > > @@ -1,4 +1,4 @@
> > > > -if ARCH_OMAP2PLUS || COMPILE_TEST
> > > > +if OF && (ARCH_OMAP2PLUS || COMPILE_TEST)
> > > >  
> > > >  source "drivers/video/fbdev/omap2/omapfb/Kconfig"
> > > >  
> > > >   
> > > 
> > > Hi,
> > > 
> > > This patch certainly fixes the build errors that I have been seeing in
> > > linux-next for several days now, so:
> > > 
> > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > Tested-by: Randy Dunlap <rdunlap@infradead.org>  
> > 
> > Thanks.
> > 
> > Since there has been no follow up from Mauro on this ([1]) I guess
> > that the best thing I can do is simply merging both patches to fbdev
> > tree..
> > 
> > [1] https://www.spinics.net/lists/linux-media/msg132583.html
> 
> Sorry, it seems I missed it. If you didn't merge them yet, I'll
> merge it on my tree today, if you think it would be best to have
> it together with the patch that enabled FB_OMAP builds with
> COMPILE_TEST.

This would be best indeed, you can add my ACK:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> If you prefer, instead, feel free to merge via your tree, as this is
> FB stuff anyway.
> 
> If you need/want:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

BTW Could you please also comment on / ACK my patch in this thread:

https://www.spinics.net/lists/linux-media/msg132733.html

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
