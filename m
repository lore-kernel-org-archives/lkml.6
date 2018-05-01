Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbeEAQb3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:31:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53228 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:31:26 -0400
X-Google-Smtp-Source: AB8JxZozQ1zwjHIaWGejbaLr2XkKkOsraTg+BjXa89SLHA6SAEB+SAp//wF1UrVedhL/P9YWafa5mA==
MIME-Version: 1.0
In-Reply-To: <20180501161723.GA376@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-5-jagan@amarulasolutions.com> <20180501161723.GA376@rob-hp-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 May 2018 00:31:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v66bx2TguLjnMi2R0KFU4=aYC8xveexybnWdWPDd+xwOvg@mail.gmail.com>
Message-ID: <CAGb2v66bx2TguLjnMi2R0KFU4=aYC8xveexybnWdWPDd+xwOvg@mail.gmail.com>
Subject: Re: [PATCH 04/21] bindings: display: Add compatible for A64 DE2 pipeline
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

On Wed, May 2, 2018 at 12:17 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Apr 30, 2018 at 05:10:41PM +0530, Jagan Teki wrote:
>> Allwinner A64 has DE2 pipeline similar to other Allwinner
>> SOC's like A83T, H3/H5.
>
> 'dt-bindings: ' for the subject prefix.
>
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Otherwise,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Would it make sense to put all the display component related compatible
string additions in the same patch? i.e. "Add compatible strings for all
documented display component blocks". MIPI-DSI is missing, but it's not
documented.

ChenYu
