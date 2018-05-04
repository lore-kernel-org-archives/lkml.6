Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEDHhE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:37:04 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:34953 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeEDHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:37:02 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN9EVM="
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 4/7] gpio: pca953x: define masks for addressing common and extended registers
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <FA9DBCAF-2EA5-4317-BBA3-E2D6A9EAC5D4@goldelico.com>
Date: Fri, 4 May 2018 09:33:57 +0200
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>, kernel@pyra-handheld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <71415CEC-6763-4658-A0C4-7AD4E3C1746D@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <3df974ea890116d759844e56362dc0786388869a.1524933096.git.hns@goldelico.com> <CAHp75Ve37aARbNZ8qu5W9C-fFG5Kf9GRE_VR4aRLFpX61zviyg@mail.gmail.com> <FA9DBCAF-2EA5-4317-BBA3-E2D6A9EAC5D4@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w447bCqU008667

Hi Linus,

> Am 02.05.2018 um 14:36 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> 
>> Am 02.05.2018 um 14:29 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
>> 
>> On Sat, Apr 28, 2018 at 7:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> These mask bits are to be used to map the extended register
>>> addreseses (which are defined for an unsupported 8-bit pcal chip)
>>> to 16 and 24 bit chips (pcal6524).
>>> 

>>> 
>>> +#define PCAL_GPIO_MASK         GENMASK(4, 0)
>>> +#define PCAL_PINCTRL_MASK      (~PCAL_GPIO_MASK)
>> 
>> I'm not sure which would be better here
>> 
>> 1) to follow existing style
>> 0x1F
>> 0xE0
>> 
>> 2) to use GENMASK() in both definitions
>> 
>> 3) as it in this patch.
>> 
>> 
>> Whatever Linus prefers.
> 
> Ok, waiting for his suggestion.

Any advice if we should change or keep this?

(Please do not merge before I submit a v6 because there are
some more suggested-by and reviewed-by).

BR and thanks,
Nikolaus
