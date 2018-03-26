Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCZWXj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:23:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43925 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeCZWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:23:35 -0400
X-Google-Smtp-Source: AG47ELsJoWDay1SRz0IgGtn7mXPoesZZn9vvmSAVxc/kNekWRGJdt+J2j8kJrNh2w9uVqMln4te4kA==
Date: Mon, 26 Mar 2018 17:23:33 -0500
From: Rob Herring <robh@kernel.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180326222333.mety3fcwcgcfcaqv@rob-hp-laptop>
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-3-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320032331.29865-3-thierry.escande@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 04:23:30AM +0100, Thierry Escande wrote:
> Add binding document for serial bluetooth chips using Qualcomm protocol.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
> 
> v5:
> - Rename 'bt-disable-n' gpio as 'enable'
> 
> v4:
> - Move bt-disable-n-gpios to required properties section
> - Add clocks and pinctrl-0 as required properties
> 
> v3: no change
> v2: no change
> 
>  .../devicetree/bindings/net/qualcomm-bluetooth.txt | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

Reviewed-by: Rob Herring <robh@kernel.org>
