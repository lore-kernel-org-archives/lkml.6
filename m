Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeDMK10 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:27:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:19440 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754013AbeDMK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:27:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180413102722epoutp03e6f42ba39c4f06a846465884ef064db6~k9-2hJsML1772517725epoutp03L
X-AuditID: b6c32a39-579ff70000000ff4-e0-5ad0860ac60e
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 12:27:17 +0200
Message-id: <3605298.EUomHGJ8vH@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180413100801.GA21913@localhost.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCmri5X24Uog57dshbzr1xjtbi8aw6b
        xefeI4wWlw5dZLJ48rCPzeJR31t2BzaPnbPusnss3vOSyePEjN8sHp83yQWwRHHZpKTmZJal
        FunbJXBlnJu0ha1gBX/F3O4m9gbGY9xdjJwcEgImEk2vPjN1MXJxCAnsYJS4umQDK4TznVGi
        bdlzNpiqzys2soPYQgK7GSWutEVA2F8ZJbb2hILYbAJWEhPbVzGC2CICWhInLm0Hm8oscIpR
        YuLyaWDNwgIOEg0brrGA2CwCqhJLv30HWsDBwSugKbGrmQckLCrgJbFlXzsTiM0pYC3xeeIF
        VhCbV0BQ4sfke2CtzALaEk/eQcSZgVpffJnEAnHnDjaJjkn5ICMlBFwken45QoSFJV4d38IO
        EZaWuHTUFuQyCYFmRolvO/YwQ9RMYJTYs14IwraWOHz8ItR4Pol3X3tYIXp5JTraoEo8JK7O
        v8oKYTtKtL6bBg2drYwST/84TmCUnYXk6FlIjp6F5OgFjMyrGMVSC4pz01OLDQtM9YoTc4tL
        89L1kvNzNzGCE4GW5Q7GY+d8DjEKcDAq8fAqVJ6PEmJNLCuuzD3EKMHBrCTCe7PgQpQQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3qc+Z6KEBNITS1KzU1MLUotgskwcnFINjG5bN+Ztr3E0FZfr
        LwtduuzPxEeb/wX3S39yrjE7U7u1IpQ/5/Ihiei6H81u+/d4t5XU2HN8dtLeqrmtU/6QVtFz
        46SXvcnfzBas7P7Es//jvt/iDHH1FRyiay9tajzAcv8G8wXvl3If/O1DPB6xRSa79c6wNCqv
        dTr8I/agl9WOxPk9jxiWK7EUZyQaajEXFScCAGTM+EEAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAV3OtgtRBs+WmljMv3KN1eLyrjls
        Fp97jzBaXDp0kcniycM+NotHfW/ZHdg8ds66y+6xeM9LJo8TM36zeHzeJBfAEsVlk5Kak1mW
        WqRvl8CVcW7SFraCFfwVc7ub2BsYj3F3MXJySAiYSHxesZG9i5GLQ0hgJ6PE5zfLWCGcr4wS
        HXO2s4FUsQlYSUxsX8UIYosIaEmcuLSdCaSIWeAMo8SetY/YQRLCAg4SDRuusYDYLAKqEku/
        fQdq5uDgFdCU2NXMAxIWFfCS2LKvnQnE5hSwlvg88QLUsq2MErN2LwVbwCsgKPFj8j2wOcwC
        2hJP3oEUcQDZ6hJTpuROYOSfhaRqFpKqWQhVCxiZVzFKphYU56bnFhsVGOallusVJ+YWl+al
        6yXn525iBAbwtsNafTsY7y+JP8QowMGoxMOrUHk+Sog1say4MvcQowQHs5II782CC1FCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1MO7Q/XfdXm0na7bo
        lObtcQ6v78yUeuj8uqgxKz9GhV3sa8sNr+5TvJvCpjA5cNppcb4unJ5Usnq3yuyLe6xLWW5/
        v/y9UaHF4BKH34a7EswbVqs4LBAPm5nIu67t19vqOM6ty1KPb0nKOW6te0NZgG0D4162Hw/P
        1Kx4GbzGVdx+378vT3y+eSixFGckGmoxFxUnAgDiwCo7XAIAAA==
X-CMS-MailID: 20180413102721epcas1p2bc78964da3886e2cb2a593df2234753c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180413100808epcas3p4b943a763c77624c88f73492ff11e1b0d
X-RootMTR: 20180413100808epcas3p4b943a763c77624c88f73492ff11e1b0d
References: <1523436077.16235.5.camel@intel.com>
        <CGME20180413100808epcas3p4b943a763c77624c88f73492ff11e1b0d@epcas3p4.samsung.com>
        <20180413100801.GA21913@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3DARWZB022983

On Friday, April 13, 2018 03:08:03 AM Eduardo Valentin wrote:
> On Fri, Apr 13, 2018 at 01:39:05PM +0800, Zhang Rui wrote:
> > Hi, Eduardo,
> > 
> > On 四, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> > > Hello,
> > > 
> > > On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > > > 
> > > > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>
> > > > wrote:
> > > > > 
> > > > > 
> > > > > could you please illustrate me what the kconfig & warning is?
> > > > Just "make allmodconfig" and the warning is about a uninitialized
> > > > variable.
> > > > 
> > > > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> > > > history
> > > > is to be believed.
> > > > 
> > > >                 Linus
> > > Yeah, this has also passed my local compilation error. Somehow my
> > > gcc4.9
> > > is not catching it. Using an older gcc (gcc4.6) does catch it.
> > > 
> > > Anyways, given that the conversion functions are written to cover
> > > for unexpected cal_type, the right way of fixing this is to rewrite
> > > the conversion functions to allow for returning error codes and
> > > adjusting the callers as expected.
> > > 
> > > Rui, bzolnier, please consider the following fix:
> > > 
> > as it is late in this merge window, I'd prefer to
> > 1. drop all the thermal-soc material in the first pull request which I
> > will send out soon.
> > 2. you can prepare another pull request containing the thermal-soc
> > materials except the exynos fixes
> > 3. exynos fixes with the problem solved can be queued for -rc2 or
> > later.
> > 
> 
> Agreed

What should I do now to help resolve the issue?

[ There has been no action from you on Arnd's fix for over two weeks and
  also you have not commented on it now.. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
