Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeBGVTX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:19:23 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45911 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeBGVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:19:20 -0500
X-Google-Smtp-Source: AH8x224dFpVJaVTgigg+tnCkeZF6BGC2W3u1PFiLPNslh9eiHYqLNUWDqO2DZoP135l3+ZVM9fJZNQ==
Date: Wed, 7 Feb 2018 15:19:18 -0600
From: Rob Herring <robh@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linus.walleij@linaro.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: Add Spreadtrum GPIO controller
 documentation
Message-ID: <20180207211918.whcxq2not7elokae@rob-hp-laptop>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 09:55:10AM +0800, Baolin Wang wrote:
> This patch adds the device tree bindings for the Spreadtrum
> GPIO controller. The gpios will be supported by the GPIO
> generic library.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - No updates.
> ---
>  .../devicetree/bindings/gpio/gpio-sprd.txt         |   28 ++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt

Please add acks/reviews when posting new versions.

Rob
