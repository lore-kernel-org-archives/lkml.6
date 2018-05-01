Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756219AbeEAQTl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:19:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37906 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755316AbeEAQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:19:36 -0400
X-Google-Smtp-Source: AB8JxZo8NuEPnf4tJklPp3DKOLKqtaq7noIB2m4/UavMdnootgzKRzJTlFCYO1wSjgGRRLAuUF77sg==
MIME-Version: 1.0
In-Reply-To: <20180501161618.GA32350@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-2-jagan@amarulasolutions.com> <20180501161618.GA32350@rob-hp-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 May 2018 00:19:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ZTQ0jAaSpDXtV58c-EE2FMMbVASLLjxjGkWM3iJTMHg@mail.gmail.com>
Message-ID: <CAGb2v64ZTQ0jAaSpDXtV58c-EE2FMMbVASLLjxjGkWM3iJTMHg@mail.gmail.com>
Subject: Re: [PATCH 01/21] dt-bindings: clock: Add compatible for A64 DE2 CCU
To: Rob Herring <robh@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 12:16 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Apr 30, 2018 at 05:10:38PM +0530, Jagan Teki wrote:
>> Allwinner A64 has DE2 CCU which is similar to H3/H5 SoC.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Rob,

Do we need to add this if it's just a soc-specific compatible
we add in the device tree to future proof things in case we
discover quirks later on?

AFAIK we haven't been doing this, and this is likely to create
some confusion, because they aren't actually mentioned anywhere
in the driver.

ChenYu
