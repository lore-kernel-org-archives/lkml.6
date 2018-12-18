Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0958CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F521873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeLRULD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:11:03 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:33263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeLRULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:11:03 -0500
Received: from oxbsltgw05.schlund.de ([212.227.220.149]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mn1mb-1hItNY2ChT-00kAKe; Tue, 18 Dec 2018 21:10:31 +0100
Date:   Tue, 18 Dec 2018 21:10:30 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, arm-soc <arm@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Olof Johansson <olof@lixom.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Message-ID: <2071995319.127120.1545163830046@email.ionos.de>
In-Reply-To: <VI1PR0402MB3485A452549CF37694720A7B98BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20181213064803.kd7p7fzsegu6nhnl@localhost>
 <1541367377.58314.1544910265605@email.ionos.de>
 <VI1PR0402MB3485A452549CF37694720A7B98BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:zKs6KogVMtyI6s8EVuQmT1/aAzgCc1dWI/BgHXOOOq2hHU+ixaQ
 AZy9BJaevHHJaeNiylfcHg2j3aTaqQWmLia+5A7N1oqeXJ7fTPMRySOW9ql9JFwmpYqawOW
 jGMY3Yc5JIvmTyY8Ol2qS6I3nI1jMnXb/xbK7UY1e61Tvy/IOd4Omq6x6w/CwwsQlWNiDWj
 z1l9iXxi6nJVrkqdMDsrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ACpmdDnor00=:OT33SqLoMFLLzgfGbgmEy+
 LLJ+0bpp3g1zvir6EWXWDALxIaL7W5d+6PFB1u5tvY76AzFIR5Y1VzsQ/EKuVI+zkE/cm2POD
 GQfbLl5LjgmD0ob4H92UmfYKd4jbQBPS13nttPzTmVr/q4SAomRkZUjK88qGF/Ig2BR7tdjsa
 rCiq0nB/luEnNU9KA6iWHuURfNTdHzzVYutwjL35ECHH3xPsUIDoP2rE/FEvAbC2yXW70ZWk+
 fxfux/rzXB155Kygs4WHvuLQHz45l2GA6Rr0cA488bjkMzBAKNtbJKOEHyyBlij7uqA67oYfR
 VRo6OohFpLbxKEFWgermrdyMhNNWKpNwgJc8foWHSK38Pnst20MR8X2lUQ8yaaGKvtxI6UmrD
 jAYauY2PRj6ssxAGmVgVfDdLgNeln0Iu+tX9yoJCL+gmoTxdzcOl9Z6sEMlhrFlj60IQJC6FK
 sySpxUM5F86vXopK1Hf7p+ehjO7soWYmFcFds7pUwgnyMLSdR6anSrEGlTmWB+rGYguddUc3v
 MlnN0FaZieQ/tS3vpXw8KpeBVrA7lWX2ER73nqYRBjFyK/zt1xg8jiZvptHIdMi46TFdw8/2q
 TGn35DWaDgGu9OesFEeNNrxchEq/PGIu5zhbwhj/HNeqnXdy1jViNhXxv2lzANuuH1qY1PYdV
 NabF0L8uNC9eczI+V/u2L0UiPgK4QO+ryaYB4LaV/1cDYetIZVAZdYEj/fFQbI20CIgjHvAz/
 /d9NFYlU7lhHxMyvjjisK/Xqp6vGgd7SEhWSFAau6yhkkEMjEAEmYWhWOqPpBd8jD0idPU7xd
 PMmIFE4Idun6x+c2+f87yHKxoqjp/Ck0u7hiGtr5QvESpWXSGR983eHApo3KFTmGHwwoR1q+A
 0oydXexOO8ZbKpW2Pbvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horia,

> Horia Geanta <horia.geanta@nxp.com> hat am 17. Dezember 2018 um 16:33 geschrieben:
> 
> 
> On 12/15/2018 11:44 PM, Stefan Wahren wrote:
> > Hi,
> > 
> >> Olof Johansson <olof@lixom.net> hat am 13. Dezember 2018 um 07:48 geschrieben:
> >>
> >>
> >> On Fri, Nov 09, 2018 at 06:05:24AM +0000, Horia Geanta wrote:
> >>> On 11/9/2018 3:11 AM, Marc Gonzalez wrote:
> >>>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
> >>>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
> >>>> which is not set. Enable FSL_MC_BUS, and build FSL_MC_DPIO and
> >>>> CRYPTO_DEV_FSL_DPAA2_CAAM as modules.
> >>>>
> >>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >>> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> >>
> >> I had to redo this one, and when I did I noticed that there's also an ethernet
> >> driver. Should that be enabled as well?
> >>
> > 
> > this patch in next-20181214 breaks "make modules_install" for arm64/defconfig on my Ubuntu machine:
> > 
> > DEPMOD  4.20.0-rc6-next-20181214
> > depmod: ERROR: Found 6 modules in dependency cycles!
> > depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> authenc
> > depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> fsl_mc_dpio
> > depmod: ERROR: Cycle detected: dpaa2_caam -> caamhash_desc -> dpaa2_caam
> > depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> error
> > depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> caamalg_desc
> > 
> > After reverting of this patch the issue disappeared.
> > 
> Seems there's a dependency cycle b/w dpaa2_caam and caam{alg,hash}_desc, as follows:
> 
> A->B
> ---
> dpaa2_caam needs cnstr_* exported by caam{alg,hash}_desc
> 
> B->A
> ---
> caam{alg,hash}_desc need caam_imx, caam_little_end:
> caam{hash,alg}_desc.c
> 	--> desc_constr.h (included for descriptors generation functions)
> 		--> regs.h (included for endianness helpers)
> 			--> extern bool caam_imx, caam_little_end
> caam_imx, caam_little_end are exported by dpaa2_caam - caamalg_qi2.c (when
> CONFIG_CRYPTO_DEV_FSL_CAAM=n)
> 
> Could we drop this patch, until CAAM driver gets a proper fix (which is not
> straightforward)?

this issue still persists in 4.20.0-rc7-next-20181218. Could you please send a patch to revert this change?

Thanks Stefan

> 
> Thanks,
> Horia
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
