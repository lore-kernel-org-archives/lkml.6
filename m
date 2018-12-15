Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99197C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0DA206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeLOVov convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:44:51 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeLOVov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:44:51 -0500
Received: from oxbsltgw08.schlund.de ([212.227.220.152]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5max-1hVyym2lQ3-017Fkd; Sat, 15 Dec 2018 22:44:27 +0100
Date:   Sat, 15 Dec 2018 22:44:25 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Olof Johansson <olof@lixom.net>,
        Horia Geanta <horia.geanta@nxp.com>
Cc:     arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <1541367377.58314.1544910265605@email.ionos.de>
In-Reply-To: <20181213064803.kd7p7fzsegu6nhnl@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20181213064803.kd7p7fzsegu6nhnl@localhost>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:CXHA/4H+L35AWB0iF35FI+uoDYiE7M6zREdFHgDx/A1YQ1kFPpn
 2xz7ih7E0z0mwKIKXuhnzRvm0sIsYJNVWg4vNHYZv3XG/E8kJoypxmjvx8zc+6zWG0GKTvY
 uE+l2Lga0xQKgxrPuCQHqz66U1PG1gEEozSUZ+iUgef0JfvJYKCpaSBg/5MVXDf+oq4B18n
 obPWQq0dxqqCWA0Zb5yog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RwBoitGoNXk=:FAnutHj56fy5c0oKCE2Nmz
 BFJKTmaVPREr+B64XW7p7RF4xHYQ2lQfhdyuNZLa2/Gdn/rab3+ozqIBmxsbtf2XDh2Z+UFjM
 KTF348GK6DCKRlLRxV16AKCXApvOCDRJ/Fa7e6XCRM9YSrdcWeS9vrA5q9QB1Z+U9rz9S0ibT
 SIZtNKeuPy6Hpql+uCM509GWz0PYUeadqP/ZsRxxWj+18s6UE/N65EWobz3VBszw+OViwbr7A
 H5yvBYFThPh9t6pSApLJPTvpL+miwTKgxMg5djyUZBxW/Ij+7LtbGh8Yau95nor+OgrkDzYRg
 lvNxR4pu3nSCNtyC3wb33xeS7NN844LcEA8NKMaakurSbpEDECYSrwsjETs9o9hOfIS3lYh/x
 UKsyHf9TNsSmS3pzOHcKOVVLBEqcinjmPZzOSAJM//pO1Z5tyvdRPTL9LBPrXNvcbbvTpA8XY
 E3IVYtsLIA/dJu8Fm15cGjtBeZjyfVuLTtj0oCp3yEztqoxD0LiQa/JI7hSVjpIDpnO3E4Arv
 rgX6nuho5vkONGIoWXmoReHVrv19BbOFO/l7UaWl7LxwZIX96p43yqhdp4Wrxx81qbma4SKy+
 WKxgOVTXkDXOdyik7itlr85axg6r73SMx07UQlhp+s9ZRGZqNum012qayHtifHBiiThNE+Hbt
 tl2N3Oe3dGru5ghWpbqlAs1tU0l2fopfNcOWJzwjJdocKAXMJ9KxhvwrL9JHHo6eEUQ/Ut0sS
 GlCRAIIsYcfZ6fG7/4/36nz5eQVpAGzX5Pu+ebY9au4A+CZ8ilJiA37hg7U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Olof Johansson <olof@lixom.net> hat am 13. Dezember 2018 um 07:48 geschrieben:
> 
> 
> On Fri, Nov 09, 2018 at 06:05:24AM +0000, Horia Geanta wrote:
> > On 11/9/2018 3:11 AM, Marc Gonzalez wrote:
> > > Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
> > > enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
> > > which is not set. Enable FSL_MC_BUS, and build FSL_MC_DPIO and
> > > CRYPTO_DEV_FSL_DPAA2_CAAM as modules.
> > > 
> > > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> 
> I had to redo this one, and when I did I noticed that there's also an ethernet
> driver. Should that be enabled as well?
> 

this patch in next-20181214 breaks "make modules_install" for arm64/defconfig on my Ubuntu machine:

DEPMOD  4.20.0-rc6-next-20181214
depmod: ERROR: Found 6 modules in dependency cycles!
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> authenc
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> fsl_mc_dpio
depmod: ERROR: Cycle detected: dpaa2_caam -> caamhash_desc -> dpaa2_caam
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> error
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> caamalg_desc

After reverting of this patch the issue disappeared.

Stefan
