Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD876C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795AA20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfBWGm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:42:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:30024 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbfBWGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:42:58 -0500
X-UUID: caafd6f2dc2d4ab183f98aeca258beff-20190223
X-UUID: caafd6f2dc2d4ab183f98aeca258beff-20190223
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1132815251; Sat, 23 Feb 2019 14:42:49 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 23 Feb
 2019 14:42:47 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 23 Feb 2019 14:42:46 +0800
Message-ID: <1550904166.16070.33.camel@mhfsdcap03>
Subject: Re: [PATCH v2] Fix HS setting in mmc_hs400_to_hs200()
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "Avri Altman" <avri.altman@wdc.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Sat, 23 Feb 2019 14:42:46 +0800
In-Reply-To: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

this is just a ping, do you have any comments of this series of
patches ?

Thx!

On Fri, 2019-02-15 at 13:59 +0800, Chaotian Jing wrote:
> Change vs v1:
>   do not retry CMD6 in __mmc_switch()
>   do not move the reduce clock operation after switch HS
> 
> Chaotian Jing (2):
>   mmc: core: do not retry CMD6 in __mmc_switch()
>   mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
> 
>  drivers/mmc/core/mmc.c     | 21 +++++++++++++++++++--
>  drivers/mmc/core/mmc_ops.c |  2 +-
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 


