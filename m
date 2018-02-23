Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeBWHwX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:52:23 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:43547 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:52:21 -0500
X-Google-Smtp-Source: AG47ELtA20hJlPyPXEbF2XhKdwZp68XWn+9z4tlq+VDBbsOHRGJkuxQXDrY1zpED/UbRsTOMD1Yj5iNydFZvyoKxy3A=
MIME-Version: 1.0
In-Reply-To: <20180221094009.2zql6gbzkcklbakk@ninjato>
References: <20180116160618.27859-1-peda@axentia.se> <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop> <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
 <20180221091130.4sdfnalrng4sd77i@ninjato> <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
 <20180221094009.2zql6gbzkcklbakk@ninjato>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2018 08:52:20 +0100
Message-ID: <CAMRc=MdE_LX276mjXCHaNgAthKyzaKPW-eWBfEuCcG187X7wvQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-21 10:40 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> Will do. What about this (http://patchwork.ozlabs.org/patch/867169/)
>> one? It's part of a bigger series, do you want me to apply it to my
>> tree and provide you with an immutable branch?
>
> Well, I would accept it for 4.16 using the "plain new id" rule. So, if
> you add it on top of Peter's sorting patch, totally fine by me.
>
> If you want it in v4.17, ok, too. I'd think an immutable branch is not
> needed. There is a fallback property in the DTS. So at worst, there will
> be a DTS warning during the merge window which will be fixed at rc1 time.
>
> Unless I overlooked something.
>

Ok, I'll have some time during the weekend, so I'll send a PR for rc3.

Bart
