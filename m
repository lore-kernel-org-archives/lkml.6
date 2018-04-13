Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbeDMR1W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:27:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42327 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeDMR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:27:20 -0400
X-Google-Smtp-Source: AIpwx497watylzwTqGQy2ejRLtB9+VxL/j149NhQmA2U39c9yhUTuNwqyqv+B8d/lvTtAP8/4RwuNQ==
Date: Fri, 13 Apr 2018 12:27:18 -0500
From: Rob Herring <robh@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: ave: add syscon-phy-mode
 property to configure phy-mode setting
Message-ID: <20180413172718.j2kmpjtdpuldqsj4@rob-hp-laptop>
References: <1523255925-6469-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1523255925-6469-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523255925-6469-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 03:38:44PM +0900, Kunihiko Hayashi wrote:
> Add "socionext,syscon-phy-mode" property to specify system controller that
> configures the settings about phy-mode.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
