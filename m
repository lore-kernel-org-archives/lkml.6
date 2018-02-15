Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032624AbeBOC3P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:29:15 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42639 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032483AbeBOC3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:29:12 -0500
X-Google-Smtp-Source: AH8x226Pb35zWZPjZBMXH8/n7hAsNpubKzLDLaMBhLDuhCECyNP1pCVROOl3XzE9znBAJGzFx4EaqXsAbu4TZZUsVOs=
MIME-Version: 1.0
In-Reply-To: <CACPK8XdXOaPZ5i=qKns3=V87nhfY62PNr4kwH9xwVYxY0djo0g@mail.gmail.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
 <20180205235757.246758-3-brendanhiggins@google.com> <CACPK8XdXOaPZ5i=qKns3=V87nhfY62PNr4kwH9xwVYxY0djo0g@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 15 Feb 2018 12:58:51 +1030
X-Google-Sender-Auth: UyzrrAqUK85-YDE5GHJHKbRT1W4
Message-ID: <CACPK8XeOUrrGinU_fmnmn4atYm3Bs-xSoB2MqT0Yr-LytHt78Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Brendan Higgins <brendanhiggins@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>, julien.thierry@arm.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 4:52 PM, Joel Stanley <joel@jms.id.au> wrote:
> Hi Brendan,
>
> On Tue, Feb 6, 2018 at 10:27 AM, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>> specific device tree for the NPCM750 (Poleg) evaluation board.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
>> Tested-by: Avi Fishman <avifishman70@gmail.com>
>
> This looks well acked, reviewed and tested. How do you plan to have
> the ARM SoC maintainers merge your patches?

Following up on an IRC conversation with Brendan:

The process is normally to create a git branch based on on -rc1, apply
your patches, and send them to the ARM maintainers. You then push a
signed tag to a repository somewhere, send a pull request (a git
request-pull email, not a Github PR) and Arnd, Olof or one of the
other maintainers will pull your tree some time before the next merge
window opens.

Arnd, do we have this documented somewhere for new maintainers to follow?

Cheers,

Joel
