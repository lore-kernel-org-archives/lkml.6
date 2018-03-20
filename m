Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeCTHfv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbeCTHfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:35:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4150A21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Sricharan R <sricharan@codeaurora.org>, absahu@codeaurora.org,
        andy.gross@linaro.org, bjorn.andersson@linaro.org,
        catalin.marinas@arm.com, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux@armlinux.org.uk, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, robh@kernel.org,
        sboyd@codeaurora.org, will.deacon@arm.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521518336-5467-14-git-send-email-sricharan@codeaurora.org>
Cc: sricharan@codeaurora.org
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-14-git-send-email-sricharan@codeaurora.org>
Message-ID: <152153134562.254778.8560281830236357589@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 13/13] ARM: dts: ipq8074: Enable few peripherals for hk01 board
Date: Tue, 20 Mar 2018 00:35:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sricharan R (2018-03-19 20:58:56)
> +                        };
> +               };
> +
> +               serial@78b1000 {
> +                        pinctrl-0 = <&hsuart_pins>;
> +                        pinctrl-names = "default";
> +                        status = "ok";
> +               };
> +
> +               i2c_0@78b6000 {

Node should just be called i2c?

> +                        pinctrl-0 = <&i2c_0_pins>;
> +                        pinctrl-names = "default";
> +                        status = "ok";
> +               };
> +
