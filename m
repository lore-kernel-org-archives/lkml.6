Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeDPPHb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:07:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45481 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeDPPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:07:28 -0400
X-Google-Smtp-Source: AIpwx4+Av0tG1JEEHsWpEzJ2/BJfLSZcFScMNBqd+R9GRvlL5mAL1j4u5suFeEslc0NL2QVvvG1Bqw==
Date: Mon, 16 Apr 2018 10:07:26 -0500
From: Rob Herring <robh@kernel.org>
To: Matheus Castello <matheus@castello.eng.br>
Cc: mark.rutland@arm.com, wens@csie.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: sunxi: Fix reference to driver
Message-ID: <20180416150726.fitlgrgusr2iazhv@rob-hp-laptop>
References: <1523423823-9115-1-git-send-email-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523423823-9115-1-git-send-email-matheus@castello.eng.br>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 01:17:03AM -0400, Matheus Castello wrote:
> Bindings describe hardware, not drivers.
> Use reference to hardware Allwinner A1X Pin Controller instead driver.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt         | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Rob
