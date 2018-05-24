Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033402AbeEXOhC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970452AbeEXOg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:36:59 -0400
X-Google-Smtp-Source: AB8JxZof28oUcUpru9gB8/8VX4CNhr44OzUP55YXn7AdJh75OPUPYzn/4uKDe0NpFDJuplCEZ2YL8alfJO/0no6earE=
MIME-Version: 1.0
In-Reply-To: <CAPoXtQJYmfk+-4qOpbEetUAdVwTgVPmk=mQaFv7yLF2V2dO=4A@mail.gmail.com>
References: <20180517130628.2770-1-andrea.greco.gapmilano@gmail.com>
 <20180523164931.GA3635@rob-hp-laptop> <CAPoXtQJYmfk+-4qOpbEetUAdVwTgVPmk=mQaFv7yLF2V2dO=4A@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 May 2018 09:36:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL1M3SuH_cJGUhh0+Xg+UYDjAc-=a+USENOKznvWib1Ng@mail.gmail.com>
Message-ID: <CAL_JsqL1M3SuH_cJGUhh0+Xg+UYDjAc-=a+USENOKznvWib1Ng@mail.gmail.com>
Subject: Re: [PATCH 2/4] arcnet: com20020: bindings for smsc com20020
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: "Tobin C. Harding" <tobin@apporbit.com>,
        Andrea Greco <a.greco@4sigma.it>, Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 5:17 PM, Andrea Greco
<andrea.greco.gapmilano@gmail.com> wrote:
> On 05/23/2018 06:49 PM, Rob Herring wrote:
>> One typo, otherwise:
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Yes typo, Fixed over my branch, sorry for that...
> I expect a comment about bps, Bit per Second, used in `bus-speed-bps`
> You will add it by your self in property-units.txt, or required my patch?

If you want to add it, that's fine. But it's really not something that
comes up often. For UARTs, there's already the "current-speed"
property and most other things I can think of use Hz to express
speeds.

Rob
