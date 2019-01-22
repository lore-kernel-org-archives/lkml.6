Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69288C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445D821019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfAVOA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:00:59 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52611 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728456AbfAVOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:00:59 -0500
X-UUID: e9e7cb0fec0040e39a01568ffad66853-20190122
X-UUID: e9e7cb0fec0040e39a01568ffad66853-20190122
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1434461444; Tue, 22 Jan 2019 22:00:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 22:00:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 22:00:48 +0800
Message-ID: <1548165648.2429.13.camel@mtkswgap22>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sean Wang <sean.wang@kernel.org>,
        Weijie Gao =?UTF-8?Q?=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?= 
        <Weijie.Gao@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>
Date:   Tue, 22 Jan 2019 22:00:48 +0800
In-Reply-To: <CACRpkdZMgnj2S8xPPFm3PnDGrqTerOwWcS-+Uruy1uLH24HRLg@mail.gmail.com>
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
         <CACRpkdZMgnj2S8xPPFm3PnDGrqTerOwWcS-+Uruy1uLH24HRLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: stable@vger.kernel.org

On Fri, 2018-12-21 at 18:17 +0800, Linus Walleij wrote:
> On Thu, Dec 13, 2018 at 3:28 AM Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> > Remove prompts to make all pinctrl cores to non-visible symbols and
> > make sure the target SoCs would be coupled with the corresponding
> > cores.
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Patch applied with ACK and Tested-by.
> 
> Yours,
> Linus Walleij

I forgot to add stable-kernel into CC list.
This patch should be applied to stable-rc linux-4.20.y.

Sorry for the inconvenience. 
Ryder




