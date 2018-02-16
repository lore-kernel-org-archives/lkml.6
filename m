Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeBPTOW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:14:22 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41001 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeBPTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:14:11 -0500
X-Google-Smtp-Source: AH8x225T3yZp/qYdgGRptxFbJgg6jfWFbAou4BMlrRizjrfZaApSNkmkcT1N9/0Q3SqbyuX3djuqVg6TuHfA2PslgkI=
MIME-Version: 1.0
In-Reply-To: <A86ACBBE-0825-482F-81BE-24B7CAED92CD@gmail.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
 <20180205235757.246758-3-brendanhiggins@google.com> <CACPK8XdXOaPZ5i=qKns3=V87nhfY62PNr4kwH9xwVYxY0djo0g@mail.gmail.com>
 <CACPK8XeOUrrGinU_fmnmn4atYm3Bs-xSoB2MqT0Yr-LytHt78Q@mail.gmail.com> <A86ACBBE-0825-482F-81BE-24B7CAED92CD@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 16 Feb 2018 11:14:00 -0800
Message-ID: <CAFd5g44KScqzTZyH9Euwnsqjz5oecB2qovohjOmAwVZNtD1X9Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>>Arnd, do we have this documented somewhere for new maintainers to
>>follow?
>
> I would add a few things that we had to go through before for Broadcom SoCs:
>
> - send your pull requests to arm@kernel.org and copy Arnd, Olof and Kevin
>
> - you would want to get your PGP key signed by as many people as people as possible which should not be a problem if you are in an area with lots of kernel people like the Bay Area (which reminds me I should do that)
>
> - if you are going to be reasonably active every cycle consider getting a kernel.org account to host your tree (we are still not doing that...)
>
> - for future pull requests, you might want to break them into e.g: DTS, board/Kconfig, drivers, defconfig, maintainers file, and have as little dependencies between each branch to minimize merge conflicts
>
> - build test and run test your changes against at least one other platform, e.g: QEMU to check for multiplatform issues
>
> In case this is of any value, there is a script here that will automatically generate pull requests emails for you based on branches matching what was mentioned above, it will also take care of CC'ing the people involved in the different patches:
>
> https://github.com/ffainelli/misc-scripts/blob/master/gen-pull.pl
>
> It still requires you to create an appropriate tag for the pull requests, though I might semi-automate that in the future, at least spawn an editor and offer some guidance, based on commit messages as to what should be in the pull request email/tag.
>
> HTH
>
> --
> Florian

Thanks Florian, this was extremely helpful!
