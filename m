Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeCZWbc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:31:32 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34035 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeCZWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:22:58 -0400
X-Google-Smtp-Source: AG47ELsD7bg+RABEYHVrMgtAcHW/O6bxuRche8K8zf1q9Utyeu/T6qHS1NqhMisByJYLqC28miwiCg==
Date: Mon, 26 Mar 2018 17:22:56 -0500
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/7] dt-bindings: add compatible string for the A64 DE2
 CCU
Message-ID: <20180326222256.fhdcodfx7ff4zyij@rob-hp-laptop>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316175354.21437-2-icenowy@aosc.io>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 01:53:48AM +0800, Icenowy Zheng wrote:
> The Allwinner A64 SoC has a DE2 CCU like the one in the DE2 of Allwinner
> H5 SoC.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
