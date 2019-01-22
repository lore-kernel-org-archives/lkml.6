Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94995C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6597F20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q77uPlI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfAVUph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:45:37 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54928 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:45:37 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9FC6575;
        Tue, 22 Jan 2019 21:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548189935;
        bh=FXVTO5A8MgPlhL6lnnBlh1J8Rn87tgP7UF0pI8YSFhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q77uPlI/uNqJuY9A2/9PT+ZpoFEm1EVS4tXWWnn82L8x0zs3D2azuThonmvqFpc7W
         3gicIr8gz+Fz+0c4Oj2zeYEAD1/Ke7Q7QiJqYu8FhAyakBcKJtav7Vdvpw9YtCEqEX
         fDu4gV+BCRRWjRxgh3a54am7lz++bttO0TAjwlD8=
Date:   Tue, 22 Jan 2019 22:45:34 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: display: bridge: lvds-transmitter:
 cleanup example
Message-ID: <20190122204534.GE3264@pendragon.ideasonboard.com>
References: <20181229070649.21308-1-peda@axentia.se>
 <20181229070649.21308-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229070649.21308-3-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Sat, Dec 29, 2018 at 07:07:25AM +0000, Peter Rosin wrote:
> Drop #address-cells and #size-cells from the root node in the
> example, they are unused.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index fd39ad34c383..36ce07c8d8e6 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -38,8 +38,6 @@ Example
>  
>  lvds-encoder {
>  	compatible = "lvds-encoder";
> -	#address-cells = <1>;
> -	#size-cells = <0>;
>  
>  	ports {
>  		#address-cells = <1>;

-- 
Regards,

Laurent Pinchart
