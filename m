Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeDPPGn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:06:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36351 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeDPPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:06:41 -0400
X-Google-Smtp-Source: AIpwx4/goVk7qLNcmoenZ7/ln2v71Exh4hXyCFH+F/uYpcFbcJSDpQ1gYgPRlWyMAPFSngmWCTJ7Bg==
Date: Mon, 16 Apr 2018 10:06:39 -0500
From: Rob Herring <robh@kernel.org>
To: Matheus Castello <matheus@castello.eng.br>
Cc: stefan.wahren@i2se.com, eric@anholt.net, linus.walleij@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: pinctrl: bcm2835-gpio: Add generic
 pinctrl support
Message-ID: <20180416150639.wt74teumpzah4x7o@rob-hp-laptop>
References: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br>
 <1523422726-7910-1-git-send-email-matheus@castello.eng.br>
 <1523422726-7910-2-git-send-email-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523422726-7910-2-git-send-email-matheus@castello.eng.br>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 12:58:44AM -0400, Matheus Castello wrote:
> Added generic pin configuration and multiplexing support,
> and should be preferred than brcm legacy one.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
