Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeC0Roz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:44:55 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:42561 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeC0Rov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:44:51 -0400
X-Google-Smtp-Source: AIpwx4/f1a2hvwqgh+uxfErdal4rxHgjrlvwGEW7Dw54h3vPXQS0MRJeyStcJbq073DkCtivg1MYcw==
Date: Tue, 27 Mar 2018 10:45:01 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 11/13] ARM: dts: ipq8074: Add peripheral nodes
Message-ID: <20180327174501.GN1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-12-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-12-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +		serial_blsp0: serial@78af000 {

Please try to have a single scheme for how you name your labels; this is
serial0 or blsp1_uart1.

[..]
> +		i2c_0: i2c@78b6000 {

As in the previous patches, this is the 2nd i2c master in the SoC,
please label it accordingly.

Regards,
Bjorn
