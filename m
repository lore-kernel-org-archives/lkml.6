Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeCEOFq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbeCEOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:05:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C622176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELuMyPI8hQM7hak/btZZGojwF7i016GuJ08C+FZnFjFkjeQGynN7AlGtNJTSTpy1Tq65u4QuTWTbPNAdpgUUiYg=
MIME-Version: 1.0
In-Reply-To: <7f62130c-723a-c9ab-533b-48e8addf3dba@huawei.com>
References: <1520003182-26277-1-git-send-email-john.garry@huawei.com>
 <1520003182-26277-2-git-send-email-john.garry@huawei.com> <CAL_JsqJNxxyBDk_u=Wf2vGbgwa7act2NNc+zmxP7Ne80bFGqRA@mail.gmail.com>
 <7f62130c-723a-c9ab-533b-48e8addf3dba@huawei.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 5 Mar 2018 08:05:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJc53uDBeXAa=Sa=2E6x=r6uYy9GBjH0qwvO0+MVmSCg@mail.gmail.com>
Message-ID: <CAL_JsqLJc53uDBeXAa=Sa=2E6x=r6uYy9GBjH0qwvO0+MVmSCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: scsi: hisi_sas: add an property of
 signal attenuation
To: John Garry <john.garry@huawei.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:10 AM, John Garry <john.garry@huawei.com> wrote:
> On 02/03/2018 15:57, Rob Herring wrote:
>>
>> On Fri, Mar 2, 2018 at 9:06 AM, John Garry <john.garry@huawei.com> wrote:
>>>
>>> > From: Xiaofei Tan <tanxiaofei@huawei.com>
>>> >
>>> > For some new boards with hip07 chipset we are required to
>>> > set PHY config registers differently. The hw property which
>>> > determines how to set these registers is in the PHY signal
>>> > attenuation readings.
>>> >
>>> > This patch add an devicetree property, hisi-signal-attenuation,
>>> > which is used to describe the signal attenuation of an board.
>>> >
>>> > Cc: Rob Herring <robh+dt@kernel.org>
>>> > Cc: Mark Rutland <mark.rutland@arm.com>
>>> > Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>>> > Signed-off-by: John Garry <john.garry@huawei.com>
>>> > ---
>>> >  Documentation/devicetree/bindings/scsi/hisilicon-sas.txt | 7 +++++++
>>> >  1 file changed, 7 insertions(+)
>>> >
>>> > diff --git a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>>> > b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>>> > index df3bef7..6f6876a 100644
>>> > --- a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>>> > +++ b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>>> > @@ -53,6 +53,13 @@ Main node required properties:
>>> >  Optional main node properties:
>>> >   - hip06-sas-v2-quirk-amt : when set, indicates that the v2 controller
>>> > has the
>>> >                             "am-max-transmissions" limitation.
>>> > + - hisi-signal-attenuation : array of 3 32-bit values, containing
>>> > de-emphasis,
>>
>> The format for vendor prefixes is: <vendor prefix>,property-name
>>
>> And should only be ones defined in vendor-prefixes.txt
>
>
> Hi Rob,
>
> To save a v4, that would be "hisilicon,signal-attenuation", right?

Right.

Rob
