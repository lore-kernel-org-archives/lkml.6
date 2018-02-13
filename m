Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934663AbeBMJTX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:19:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38929 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbeBMJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:19:16 -0500
X-Google-Smtp-Source: AH8x227dM71znLqKn+Yx7JYP8oWVVivffp2DGQnpSPH+AxsQl/Ud51Mkmc1Z7mzHedljh8d580ITcg==
MIME-Version: 1.0
In-Reply-To: <20180213091333.rq4rtvvkwppn5ypu@flea.lan>
References: <cover.1518166039.git.viresh.kumar@linaro.org> <4d489d040ec1fc3821d8e4bf31ffcc2eebfa41e1.1518166039.git.viresh.kumar@linaro.org>
 <20180213091333.rq4rtvvkwppn5ypu@flea.lan>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 13 Feb 2018 17:18:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Rq5UY_=Fspb_j79a36SK_f+dd2Yb2zAqfg7riiaEO7g@mail.gmail.com>
Message-ID: <CAGb2v65Rq5UY_=Fspb_j79a36SK_f+dd2Yb2zAqfg7riiaEO7g@mail.gmail.com>
Subject: Re: [PATCH 04/10] ARM: dts: sun[4-7]i: Remove "cooling-{min|max}-level"
 for CPU nodes
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 5:13 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Fri, Feb 09, 2018 at 02:28:04PM +0530, Viresh Kumar wrote:
>> The "cooling-min-level" and "cooling-max-level" properties are not
>> parsed by any part of the kernel currently and the max cooling state of
>> a CPU cooling device is found by referring to the cpufreq table instead.

That doesn't mean that other systems aren't using it. It's still part of
the device tree binding. Last I checked, while they are optional, they
aren't deprecated.

Any comments from the device tree maintainers?

>>
>> Remove the unused properties from the CPU nodes.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Applied, thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com
