Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D5220866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391075AbfAOWGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:06:53 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:34535 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391028AbfAOWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:06:47 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 087448044E;
        Tue, 15 Jan 2019 23:06:40 +0100 (CET)
Date:   Tue, 15 Jan 2019 23:06:39 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas.Ferre@microchip.com, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v2 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design Associates, Inc.
Message-ID: <20190115220639.GA31652@ravnborg.org>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547458584-29548-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8 a=vZDjeIrmAAAA:8 a=VwQbUJbxAAAA:8
        a=p0DiJyO1iNsY7URx4IEA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
        a=32ZTxAcNI-FMvinRp4eW:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen.

On Mon, Jan 14, 2019 at 09:43:26AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Precision Design Associates, Inc. (PDA) manufactures standard and custom
> capacitive touch screens, LCD's embedded controllers and custom embedded
> software. They specialize in industrial, rugged and outdoor applications.
> Website: http://www.pdaatl.com/
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 3895085..967a670 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -297,6 +297,7 @@ ovti	OmniVision Technologies
>  oxsemi	Oxford Semiconductor, Ltd.
>  panasonic	Panasonic Corporation
>  parade	Parade Technologies Inc.
> +pda	Precision Design Associates, Inc.

The website uses "pdaatl" - which looks a little less generic than just "pda".
But then I do not get any association from pdaatl to Precision Design Associates)
so you can say it is not a good abbrevation either.

	Sam

