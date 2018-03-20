Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeCTMK5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:10:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbeCTMKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:10:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Mar 2018 17:40:52 +0530
From: sricharan@codeaurora.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: absahu@codeaurora.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux@armlinux.org.uk, marc.zyngier@arm.com, mark.rutland@arm.com,
        robh+dt@kernel.org, robh@kernel.org, sboyd@codeaurora.org,
        will.deacon@arm.com, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v3 13/13] ARM: dts: ipq8074: Enable few peripherals for
 hk01 board
In-Reply-To: <152153134562.254778.8560281830236357589@swboyd.mtv.corp.google.com>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-14-git-send-email-sricharan@codeaurora.org>
 <152153134562.254778.8560281830236357589@swboyd.mtv.corp.google.com>
Message-ID: <cb072bc918d92c8e6e734896fcc2352b@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 13:05, Stephen Boyd wrote:
> Quoting Sricharan R (2018-03-19 20:58:56)
>> +                        };
>> +               };
>> +
>> +               serial@78b1000 {
>> +                        pinctrl-0 = <&hsuart_pins>;
>> +                        pinctrl-names = "default";
>> +                        status = "ok";
>> +               };
>> +
>> +               i2c_0@78b6000 {
> 
> Node should just be called i2c?
> 
  ok, will fix

Regards,
  Sricharan
