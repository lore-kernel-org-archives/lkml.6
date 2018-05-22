Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeEVUCO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:02:14 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37524 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeEVUCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:02:12 -0400
X-Google-Smtp-Source: AB8JxZotxVuN8Unj2PX/FPspT7J/WyXHaAevm+gObldMIySjUzatFALv2GCKwmC9Tj270jgeWxx5pg==
Date: Tue, 22 May 2018 15:02:10 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: mark.rutland@arm.com, linus.walleij@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] dt-bindings: pinctrl: add external interrupt
 support to MT7622 pinctrl
Message-ID: <20180522200209.GA7801@rob-hp-laptop>
References: <cover.1526835466.git.sean.wang@mediatek.com>
 <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 01:01:47AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Extend the capability of MT7622 pinctrl with adding EINT so that each
> GPIO can be used to notify CPU when a signal state is changing on the
> line as an external interrupt.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
