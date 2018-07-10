Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2004EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC3D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeGJF7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:59:30 -0400
Received: from nbd.name ([46.4.11.11]:49538 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbeGJF72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:59:28 -0400
Subject: Re: [PATCH 2/2] dt-bindings: arm: mediatek: cleanup MT7623N reference
 boards
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
 <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <194425ed-4ba8-094e-5b54-17ca74847b5f@phrozen.org>
Date:   Tue, 10 Jul 2018 07:59:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/18 07:09, Ryder Lee wrote:
> Cleanup binding document to get rid of unsupported reference boards
> for MT7623N.
>
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
> ---
>   Documentation/devicetree/bindings/arm/mediatek.txt | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index 7d21ab3..c07ddf4 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -59,9 +59,6 @@ Supported boards:
>   - Reference board for MT7623n with eMMC:
>       Required root node properties:
>         - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
> -- Reference  board for MT7623n with NAND:
> -    Required root node properties:
> -      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
>   - Bananapi BPI-R2 board:
>         - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
>   - MTK mt8127 tablet moose EVB:

