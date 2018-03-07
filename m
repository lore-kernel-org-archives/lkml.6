Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeCGO2J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:28:09 -0500
Received: from forward103p.mail.yandex.net ([77.88.28.106]:35777 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754279AbeCGO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:28:02 -0500
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1520432391.3731.8.camel@flygoat.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        James Hogan <jhogan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Date: Wed, 07 Mar 2018 22:19:51 +0800
In-Reply-To: <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
         <20170927151527.25570-4-prasannatsmkumar@gmail.com>
         <20180306000832.GL4197@saruman>
         <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-03-07三的 19:14 +0530，PrasannaKumar Muralidharan写道：
> 
> I used to get my code tested from Domink but I could not reach him
> for
> quite some time. Before buying the development board myself I would
> like to see if anyone can help me in testing. Do you have any contact
> with Ingenic who can help in testing this?
> 

Hi PrasannaKumar

I'm resently working on Ingenic chips too. Ingentic guys have sent me a
X1000 development broad and it will arrive in about two weeks. I have a
ejtag debugger also (but not very suit with X1000 because X1000 have
different ejtag interface with standard MIPS cores, maybe we need some
modification on openocd). So maybe I can help in testing this after I
get my broad. Just ask if you need any help.
Thanks
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>
