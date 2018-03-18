Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeCRMtY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:49:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40233 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754038AbeCRMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:48:44 -0400
X-Google-Smtp-Source: AG47ELuDz4ySa28CY9AiQDInsCeCHjZXkk3O3i+GWySZ/FgNhDoQExEx4ZbtSajDum5GsTS8/oA4AQ==
Date: Sun, 18 Mar 2018 07:48:41 -0500
From: Rob Herring <robh@kernel.org>
To: Weiyi Lu <weiyi.lu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add clocks for MT2712
Message-ID: <20180318124841.ap6benlquyomteuq@rob-hp-laptop>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
 <20180312070342.4335-5-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312070342.4335-5-weiyi.lu@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:03:40PM +0800, Weiyi Lu wrote:
> add new clocks according to ECO design change
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  include/dt-bindings/clock/mt2712-clk.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
