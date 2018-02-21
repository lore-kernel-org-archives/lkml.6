Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeBUJXv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:23:51 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39591 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeBUJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:23:48 -0500
X-Google-Smtp-Source: AG47ELuqxE+hn/I7mW2XRQy7icD9zBAw1ozqYUBI0XyW/Ra5ucQH+IMF1r/CmTNU2s6QwzuNmAtIoCvdtCxVOJDIUNo=
MIME-Version: 1.0
In-Reply-To: <20180221091130.4sdfnalrng4sd77i@ninjato>
References: <20180116160618.27859-1-peda@axentia.se> <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop> <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
 <20180221091130.4sdfnalrng4sd77i@ninjato>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Feb 2018 10:23:47 +0100
Message-ID: <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
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

2018-02-21 10:11 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> On Mon, Jan 29, 2018 at 05:56:52PM +0100, Bartosz Golaszewski wrote:
>> 2018-01-29 17:17 GMT+01:00 Rob Herring <robh@kernel.org>:
>> > On Tue, Jan 16, 2018 at 05:06:15PM +0100, Peter Rosin wrote:
>> >> Makes them easier to find.
>> >>
>> >> Signed-off-by: Peter Rosin <peda@axentia.se>
>> >> ---
>> >>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > This one should go into 4.16. I can apply after rc1 or apply to tree
>> > with at24.txt changes queued.
>> >
>> > Acked-by: Rob Herring <robh@kernel.org>
>> >
>> > Rob
>>
>> Wolfram,
>>
>> can you take this via the i2c tree for 4.16?
>
> I missed this mail because I leave at24 patches to you now.
> Please send pull requests for patches I shall take. Least room for
> confusion (I hope).
>

Will do. What about this (http://patchwork.ozlabs.org/patch/867169/)
one? It's part of a bigger series, do you want me to apply it to my
tree and provide you with an immutable branch?

Bart
