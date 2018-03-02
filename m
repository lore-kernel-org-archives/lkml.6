Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeCBWJZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:09:25 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34816 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCBWJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:09:24 -0500
X-Google-Smtp-Source: AG47ELuVSklup5pqeZwwXafpnqQx3cN7YFrGaPrS5e/v6+8hC7e030uTxIQAdrogYY9YFm/Avj1QXg==
Date: Fri, 2 Mar 2018 16:08:57 -0600
From: Rob Herring <robh@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linus.walleij@linaro.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 1/3] dt-bindings: gpio: Add Spreadtrum EIC controller
 documentation
Message-ID: <20180302220857.obqi5sju6iyepl7m@rob-hp-laptop>
References: <334505d3a13a73ad347427b408ed581832434289.1519468782.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334505d3a13a73ad347427b408ed581832434289.1519468782.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 06:44:18PM +0800, Baolin Wang wrote:
> This patch adds the device tree bindings for the Spreadtrum EIC
> controller. The EIC can be seen as a special type of GPIO, which
> can only be used as input mode.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - Fix some typos and grammar issues.
>  - Add more explanation to make things clear.
>  - List all device nodes as examples.
> ---
>  .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |   97 ++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt

Reviewed-by: Rob Herring <robh@kernel.org>
