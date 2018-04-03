Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbeDCHep convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:34:45 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52740 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbeDCHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:34:43 -0400
X-Google-Smtp-Source: AIpwx49AH2KRLbR+W61S1CKWrTOMVjVD2G4zGlmo7qDXCCJfTligLs5OBnTjAw9m2rDBumX1HYFurQ==
MIME-Version: 1.0
In-Reply-To: <20180403092724.607e8e37@dell-desktop.home>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-2-mylene.josserand@bootlin.com> <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
 <20180403092724.607e8e37@dell-desktop.home>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 3 Apr 2018 15:34:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67RduaktYimLAuFwYB=Q8qD8f3AbZmoX5QssAGDtWwS6Q@mail.gmail.com>
Message-ID: <CAGb2v67RduaktYimLAuFwYB=Q8qD8f3AbZmoX5QssAGDtWwS6Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] ARM: move cputype definitions into another file
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 3:27 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> Hi Chen-Yu,
>
> Thank you for your review!
>
> On Tue, 3 Apr 2018 14:52:45 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
>> On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
>> <mylene.josserand@bootlin.com> wrote:
>> > To add the support for SMP on sun8i-a83t, we will use some
>> > definitions in an assembly file so move definitions into
>> > another file to separate C functions and macro defintions.
>>
>> Instead of moving the definitions, you could guard all the C
>> stuff in "#ifndef __ASSEMBLY__". AFAIK a few header files do that.
>
> Oh, right. It is better with this check so I will use that in the next
> iteration of my series.

I'm not sure about the policy, but I kind of assume any header under
"asm" would be usable in assembly files, so the guard would be better.

ChenYu
