Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87212C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EB520685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfAISir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:38:47 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfAISiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:38:46 -0500
Received: from oxbsltgw02.schlund.de ([172.19.249.19]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MplLZ-1h4kKL0zaH-00q8pn; Wed, 09 Jan 2019 19:38:32 +0100
Date:   Wed, 9 Jan 2019 19:38:31 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <1330816632.286127.1547059111664@email.ionos.de>
In-Reply-To: <da219894-4bba-21a3-94dc-da7ff7e63896@gmail.com>
References: <20181127211301.30296-1-eric@anholt.net>
 <da219894-4bba-21a3-94dc-da7ff7e63896@gmail.com>
Subject: Re: [GIT PULL 1/4] bcm2835-defconfig-next-2018-11-27
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:t8L12O4nzJmtIwGh5MeTOnxU6VYpEx+cvMEAexXAqXuT6M3sJBz
 eE1EC3Fn3verVZwT0zsXOqbMq931XXOKKgSnE0EaMGUZvt+9lA132elMnU6Dp1GtcG9Ni8r
 QRPCEUPzFCPn/ciMbd5CjdoIuGlj/QZzb1zklQOkKvy27KuvIIdjFG06Hrsl5Yqps6Gc49e
 GD0Y5mMy5oNuPuU+ReonA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ag583qZbjgo=:AUkVtI8ya9sh4KVi5DdtfQ
 KLAuSO3T53Tzjrc92RhVy9V78syFwemMeIA2iGS2E8/sSBhIgSsCDTtpJSJ7mnvR/3BHtclP1
 E7nspaM2hgO8ENAoA0rJ5b0lkdhVf+KFnEhts8kCzN/qpsgXg3fbe+K8qgnJgCJEL8Gx6Aaga
 1vjnkiNrUpzp6bf4oiBe1ZU/XagOHi44ljJ0K1Xv4S5+2hFMjcKuTxN4bEi5Gpmi9ypUs+SoW
 3SVeFAvf8y3O9Brb+ASw+cTTU83qULKaij/A7O++WMgLaJR41AeSYbLd8X6dy1njyKFUVGVOU
 PM0A+sHJynAqF+3Yedr+4LG/m8D1ByCyA7HcDLvy+V+iVTFADjSfOQtz1dfLUT//+4r5Sihfv
 gVHYd8fRE23AZCIsjHjKwTiA/ppVbLt0ceRdHoGxAWQytunuoyw56qKrXxWqdl7JRl60vSrQJ
 tGxTgbDaN3B3I+DJAcKT8yqvXmHTFW7TPCe13sB01U8i2Rk5zGOGcaENdpR0gbU8wbfBtIpSN
 E3XjcYAMw5o8WqRpdEB625k98Na1+B1NYrm5hopARPymM53M6Q2Q/mDfoSlo9pyM8FdZy2aL1
 QUTWehDysQt3o7L5+UpekDmDzQYO2Ha4ecHxRNA4ZukcdWaxMH3IaOfiWB7hIGE4Uv9eDWKXL
 tDHhfh0Cgl5a5LbAhAWaDJnRy3LS0zsJSmGrWaRI9XK57j2qZEbW/OUvWTxGY3WSQh+lGmzxt
 wpGo7fUUlYrKVBhCx9vWNeS2ULUfsvj9S/nBJ6VA3yTlCpt8MMVtovs3Gcw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> Florian Fainelli <f.fainelli@gmail.com> hat am 28. November 2018 um 22:48 geschrieben:
> 
> 
> 
> 
> On 11/27/18 1:12 PM, Eric Anholt wrote:
> > Hi Florian,
> > 
> > Hopefully I'm not too late this time around.  Stefan's been doing a
> > great job maintaining the bcm2835 branches, and was waiting for me to
> > send the PRs.
> > 
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> > 
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-11-27
> > 
> > for you to fetch changes up to 24632d6b78a1929b14f32cab762a0859db7086f2:
> > 
> >   ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver (2018-11-15 19:07:36 +0100)
> > 
> > ----------------------------------------------------------------
> > This pull request enables the V4L2 camera driver on the Pi1 defconfig.
> > 
> > ----------------------------------------------------------------
> 
> Merged into defconfig/next, thanks Eric.

looks like this patch didn't reached Olof for 4.21/5.0.

Should i resend for the next version?

Stefan
