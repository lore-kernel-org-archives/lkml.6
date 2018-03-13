Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933983AbeCMQXd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:23:33 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35201 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933785AbeCMQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:23:20 -0400
X-Google-Smtp-Source: AG47ELvemPaEOBDhFaow6EZ4+pFayLWYrhlf4ytBu41jEND1ZgPHZQ96+Zn0JZfJI1F5IeYN60QcSCeTJDIhnH3kV58=
MIME-Version: 1.0
In-Reply-To: <CAP6Zq1h+6GGrnUEcjZWtBPBKDGxL+6+OG0itJD_FHD1MAcYmsQ@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de> <CAFd5g45h3wAZtx-4oJb_uLbtDTzSsD6eLM5G0VF=3BBHNmW8YQ@mail.gmail.com>
 <CAP6Zq1jEAg2OrmnHzJdk9UBjPkDctu5oGHYyJ+QLBzN+E31sPw@mail.gmail.com>
 <CAK8P3a2=0ZUqyhmKVa4u_VvOg4rtd6vUWdpRojfsoP3OSvGyeQ@mail.gmail.com>
 <CAP6Zq1iOxFTuUvp02qOtgpmfH7HA-1eZ9KG6AtU0zn6CpPCrzw@mail.gmail.com> <CAP6Zq1h+6GGrnUEcjZWtBPBKDGxL+6+OG0itJD_FHD1MAcYmsQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Mar 2018 17:23:18 +0100
X-Google-Sender-Auth: s9nnEqTBXBzd226Sz8uJ--8_pcs
Message-ID: <CAK8P3a3jfUf9by9SxR8JQQjUuOFydR_uHTfKH=_eYPrsW7AFTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: npcm: add CONFIG_ARCH_MULTI_V7 dependency
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 2:35 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> Hi Arnd,
>
> I sent now Full patch for the NPCM BMC's V12,
>
> Is it O.K.? or do you want me to send the same patch to ARM: npcm:
> drop extraneous 'select' statements as well?

The patch series you just sent contains a new version of the patches
I already applied. What I need instead is a patch series that
does the changes on top, since I don't rebase the my next/* branches.

      Arnd
