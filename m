Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50398C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C6820840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C6820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeGJGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:38:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31639 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751274AbeGJGin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:38:43 -0400
X-UUID: bfbc3b1b75824046a70ae4e6cc1fd12e-20180710
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 734434531; Tue, 10 Jul 2018 14:38:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 10 Jul 2018 14:38:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 10 Jul 2018 14:38:31 +0800
Message-ID: <1531204711.26214.1.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] dt-bindings: arm: mediatek: cleanup MT7623N
 reference boards
From:   Sean Wang <sean.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        John Crispin <john@phrozen.org>
Date:   Tue, 10 Jul 2018 14:38:31 +0800
In-Reply-To: <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
         <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 13:09 +0800, Ryder Lee wrote:
> Cleanup binding document to get rid of unsupported reference boards
> for MT7623N.
> 
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index 7d21ab3..c07ddf4 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -59,9 +59,6 @@ Supported boards:
>  - Reference board for MT7623n with eMMC:
>      Required root node properties:
>        - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
> -- Reference  board for MT7623n with NAND:
> -    Required root node properties:
> -      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";

Acked-by: Sean Wang <sean.wang@mediatek.com>

>  - Bananapi BPI-R2 board:
>        - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
>  - MTK mt8127 tablet moose EVB:


