Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeA3Kv6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:51:58 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38291 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeA3Kvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:51:55 -0500
X-Google-Smtp-Source: AH8x226OoYJ1zgAL7PF4peDcPmDkl1MjS8auR0beLPulCIChXa+v9GoDiCaqRP/hyU2yTPR5FPwdFBBYVcR4tY5fIEk=
MIME-Version: 1.0
In-Reply-To: <20180129231518.mocdpegeagbs4z5n@rob-hp-laptop>
References: <20180122153547.23470-1-philippe.cornu@st.com> <20180129231518.mocdpegeagbs4z5n@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 30 Jan 2018 11:51:54 +0100
Message-ID: <CA+M3ks78kufDB4QSd38Ah15zidbuHnY3kHMHXB_0iQFFg1VVkA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: stm32: correct clock-names in dsi
 panel example
To: Rob Herring <robh@kernel.org>
Cc: Philippe Cornu <philippe.cornu@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mickael Reulier <mickael.reulier@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-30 0:15 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Mon, Jan 22, 2018 at 04:35:47PM +0100, Philippe Cornu wrote:
>> In the dsi panel example, clock names in the "clock-names"
>> field have been swapped:
>> * "pclk" (peripheral clock) is <&rcc 1 CLK_F469_DSI> on stm32f4
>> * "ref" (dsi phy pll ref clock) is <&clk_hse> on stm32f4
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
Applied on drm-misc-next.

Regards,
Benjamin
