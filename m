Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966679AbeBNDNC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:13:02 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33479 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966573AbeBNDNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:13:00 -0500
X-Google-Smtp-Source: AH8x224o17jIJAu7HQOgzbWWqTNgCdroXHxxJc3eNkqQ4C48VpAbuDn3KoMyGnEvNT2mPlh0O3PDSQ==
Date: Wed, 14 Feb 2018 08:42:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] ARM: dts: sun[4-7]i: Remove
 "cooling-{min|max}-level" for CPU nodes
Message-ID: <20180214031252.GW28462@vireshk-i7>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <4d489d040ec1fc3821d8e4bf31ffcc2eebfa41e1.1518166039.git.viresh.kumar@linaro.org>
 <20180213091333.rq4rtvvkwppn5ypu@flea.lan>
 <CAGb2v65Rq5UY_=Fspb_j79a36SK_f+dd2Yb2zAqfg7riiaEO7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v65Rq5UY_=Fspb_j79a36SK_f+dd2Yb2zAqfg7riiaEO7g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-18, 17:18, Chen-Yu Tsai wrote:
> On Tue, Feb 13, 2018 at 5:13 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Fri, Feb 09, 2018 at 02:28:04PM +0530, Viresh Kumar wrote:
> >> The "cooling-min-level" and "cooling-max-level" properties are not
> >> parsed by any part of the kernel currently and the max cooling state of
> >> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> That doesn't mean that other systems aren't using it.

Are you aware of any systems which are using them ?

> It's still part of
> the device tree binding. Last I checked, while they are optional, they
> aren't deprecated.

Yeah, it isn't deprecated yet. Though the last patches of this series
tries to do something similar.

> Any comments from the device tree maintainers?

None yet.

-- 
viresh
