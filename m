Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755505AbeDTOuJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:50:09 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44716 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755172AbeDTOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:50:07 -0400
Date: Fri, 20 Apr 2018 10:50:04 -0400 (EDT)
Message-Id: <20180420.105004.1091571122033406428.davem@davemloft.net>
To: hayashi.kunihiko@socionext.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, yamada.masahiro@socionext.com,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org
Subject: Re: [PATCH net-next v2 0/3] ave: fix the activation issues for
 some UniPhier SoCs
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Thu, 19 Apr 2018 16:24:52 +0900

> This add the following stuffs to fix the activation issues and satisfy
> requirements for AVE ethernet driver implemented on some UniPhier SoCs.
> 
> - Add support for additional necessary clocks and resets, because the kernel
>   is stalled on Pro4 due to lack of them.
> 
> - Check whether the SoC supports the specified phy-mode
> 
> - Add DT property support indicating system controller that has the feature
>   for configurating phy-mode including built-in phy on LD11.
> 
> v1: https://www.spinics.net/lists/netdev/msg494904.html
> 
> Changes since v1:
> - Add 'Reviewed-by' lines

Series applied to net-next, thank you.
