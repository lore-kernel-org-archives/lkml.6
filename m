Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDPEfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 00:35:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46638 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeDPEfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 00:35:02 -0400
X-Google-Smtp-Source: AIpwx49dunRhH02eKg4MXQtFkm2UApJfaC+S8BkaJt+tD6IFtHnCyzBWiFTbFnws08HFUL1+UDb53g==
MIME-Version: 1.0
In-Reply-To: <20180405064658.rz2grnpm5fq45lhu@flea>
References: <20180327053104.3812-1-jagan@amarulasolutions.com>
 <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com> <20180405064658.rz2grnpm5fq45lhu@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 16 Apr 2018 12:34:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v656MCUYiFd2J6ZE5hze2TKQqkMh7hGAUXhjz58qCj58ug@mail.gmail.com>
Message-ID: <CAGb2v656MCUYiFd2J6ZE5hze2TKQqkMh7hGAUXhjz58qCj58ug@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] regulator: axp20x: add drivevbus support for axp803
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 2:46 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Thu, Apr 05, 2018 at 12:11:39PM +0530, Jagan Teki wrote:
>> On Tue, Mar 27, 2018 at 11:01 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>> > Like axp221, axp223, axp813 the axp803 is also supporting external
>> > regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>> >
>> > Add support for it.
>> >
>> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> > ---
>> > Changes for v5:
>> > - Collect Chen-Yu reviewed-by tag
>> > Changes for v4:
>> > - rebase on master
>> > Changes for v3:
>> > - Update drivevbus in table of regulators
>>
>> Can you pick these, has some dependency with drivevbus on other
>> patches.
>
> I'm not the regulator maintainer, nor the AXP maintainer for that
> matter. Mark Brown and Chen-Yu are, respectively.

I've already reviewed all the patches. Please resend the series and
include Mark Brown, the regulator subsystem maintainer. He clearly
isn't in the current recipient list, so no wonder things didn't move
forward. Once he applies the driver bits, we'll apply any pending
device tree changes.

ChenYu
