Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbeEHMsc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755026AbeEHMs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:48:29 -0400
X-Google-Smtp-Source: AB8JxZp275tWMAOWaxkbClcQGUyreAS6P4krdu6W3TqS7GlCEw5Dql5zyJIaEFcLFlBmcj6EvH3eBR3bNkXxvgQ0uFU=
MIME-Version: 1.0
In-Reply-To: <8ac8a361a7dc69cce1e7498f1473bad8@codeaurora.org>
References: <1525350925-16006-1-git-send-email-anischal@codeaurora.org>
 <152545146453.138124.2471609033510400995@swboyd.mtv.corp.google.com>
 <09ac2bd5eab25cfc70a1c5dc7b0f90ed@codeaurora.org> <20180507171121.GA22656@rob-hp-laptop>
 <8ac8a361a7dc69cce1e7498f1473bad8@codeaurora.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 May 2018 07:48:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL3wz_Y0Qp7Z8-JjkFGegKLFOUscJgGp+XO-Lm52iN2Vg@mail.gmail.com>
Message-ID: <CAL_JsqL3wz_Y0Qp7Z8-JjkFGegKLFOUscJgGp+XO-Lm52iN2Vg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add QCOM video clock controller driver
To: Amit Nischal <anischal@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 11:53 PM, Amit Nischal <anischal@codeaurora.org> wrote:
> On 2018-05-07 22:41, Rob Herring wrote:
>>
>> On Mon, May 07, 2018 at 04:16:53PM +0530, Amit Nischal wrote:
>>>
>>> On 2018-05-04 22:01, Stephen Boyd wrote:
>>> > Quoting Amit Nischal (2018-05-03 05:35:23)
>>> > > Changes in v1:
>>> > >    https://lkml.org/lkml/2018/4/24/545
>>> > > Addressed below review comments given by Rob
>>> > > - Change the compatible property as per '<vendor>,<soc>-<block>'
>>> > > format.
>>> > > - Add header definitions for resets and power-domain cells.
>>> >
>>> > You didn't add any reset definitions though?
>>>
>>> We haven't added the reset definitions for videocc as there is no
>>> video reset client.
>>
>>
>> So? You don't know what resets there are?
>>
>
> We know the resets, but video driver doesn't do any block resets
> prior to accessing the video subsystem so that's the reason we do
> not want to expose the resets in videocc driver.

Bindings don't have to match what drivers currently use but should be
complete as possible.

Rob
