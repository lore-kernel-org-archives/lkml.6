Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeCMRZr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:25:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35980 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeCMRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:25:40 -0400
X-Google-Smtp-Source: AG47ELsld1q+JaIYbtAzle9denatB7/8JyZfC2C7GmNNDTcOmLt2/eycSbtCoQBeuEhLWi0SCQbrXg==
Date: Tue, 13 Mar 2018 10:25:36 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180313172536.GT18510@minitux>
References: <20180313164444.19881-1-thierry.escande@linaro.org>
 <20180313164444.19881-3-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313164444.19881-3-thierry.escande@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13 Mar 09:44 PDT 2018, Thierry Escande wrote:

> Add binding document for serial bluetooth chips using Qualcomm protocol.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Looks good, just two minor things.

[..]
> +Required properties:
> +
> + - compatible: should contain one of the following:
> +   * "qcom,qca6174-bt"
> +

You're missing the "susclk" clock.

> +Optional properties:
> +
> + - bt-disable-n-gpios: GPIO specifier, used to enable chip during probe

Is this really optional?

Regards,
Bjorn
