Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16898C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A5720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfARMeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:34:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:44819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfARMeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:34:19 -0500
Received: from [80.146.191.219] ([80.146.191.219]) by web-mail.gmx.net
 (3c-app-gmx-bs12.server.lan [172.19.170.63]) (via HTTP); Fri, 18 Jan 2019
 13:33:59 +0100
MIME-Version: 1.0
Message-ID: <trinity-059802f2-322f-46a5-9031-02582b115000-1547814839147@3c-app-gmx-bs12>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Matthias Brugger" <matthias.bgg@gmail.com>
Cc:     "CK Hu" <ck.hu@mediatek.com>, "Daniel Vetter" <daniel@ffwll.ch>,
        srv_heupstream@mediatek.com, "David Airlie" <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?=22Noralf_Tr=EF=BF=BDnnes=22?= <noralf@tronnes.org>,
        linux-mediatek@lists.infradead.org,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Jan 2019 13:33:59 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
 <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
 <1547775975.4221.11.camel@mtksdaap41>
 <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Ho0Nv35aMqdJbJLGfMvcYVZdpc75ihyUSJQcE7OxvXJhyqblbkquhoBQfIMG6QaVbTJbD
 r/wu6GE335p6JMjnuRVg1v5EC/K0rMBhkySoXu8PjtOGg19oVuS00nFcG7rT3Srbq4faG70N4Bl6
 pjrSGBQcOtpzpqSFS/CNRzvX3hJFwFmOK31fr/qMS3AQB6L9HuJtFKA44hOjGEXQNY1CUdHPdGg9
 O+u6I8OcJAP9c2HGMP2hGXVqtNJ/gBepVqeDP/0VztqgAZ7pJtrsofMv1DRXjEcnBjIE3ftlyK+D
 9U=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZfkoYo3dUEQ=:sNZbnRTcTGYV4iCZ4xl//W
 OUoboN1o/q0XM/A2rNB8lfeVUBIHgzVoyoniK6I8qhN7GPtZ5IZDBNafWg8JcafTu2lcos6iF
 lOXUDPu0UZF6DVu7t4bmxR5VTx/Zj0xuWTZ3aTiC2HpZKRNYlV2ZTCPO101dC8iA1infvQgmT
 0zYmjJukHOLRw916g0ZNwazwCiA/M0PdqVos2xSLK6Lv9YaCXLHMFtDkSHiS1SEML4Ln2Mt/u
 TWjiZDqOWjNki46Yd1L0+41Ewe6g/ML1NnplJ9HPzfMhjDI6MZDhVTBbFk/DUVbcdn/+07npp
 lW2gllm/bwgEWl7MOvXxqOaeLIephYThXdB4zA1E9hRK96gUz4RjcQxIyrsdm8S9SB+umKAww
 2cVKbcXjK2jsruT6MzwZw3M0Q/iTkTmxTBTAo0GoxnEHkZ32+SAZn2InCXDnJGZx4GFR5QKBg
 PIy2fZyI9zE4GQs4CVVq9hysKtOQNGdVr/sqQJw5ShFAhseRShMPpCf0oyIuSEJSAdB6y+cvr
 JI80rhbkEUClaJ3YtXtmu8JB+6fCF5s3EmSL908lxeguaFJS76rg3HLae4Y5nJg6i1vepBi5l
 P0GcJcyKgxw24=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested same codebase where my FBDev-Patch works (4.20-hdmiv5), only without it and CK Hu's 2 Patches

does generic fbdev depend on the mmsys-Patch?

regards Frank


> Gesendet: Freitag, 18. Januar 2019 um 09:39 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> may it be the not yet fixed mmsys compatible problem?
> Frank, did you test with my last series [1]?
> 
> Regards,
> Matthias
> 
> [1] https://patchwork.kernel.org/cover/10686345/
