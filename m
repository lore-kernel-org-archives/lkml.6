Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2561C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D5B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfBSUIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:08:54 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:58009 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:08:54 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 19 Feb
 2019 21:08:32 +0100
Received: from localhost (94.234.42.81) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Feb 2019 21:08:39
 +0100
Date:   Tue, 19 Feb 2019 21:08:37 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <2pi@mok.nu>
Subject: Re: [PATCH] modpost: file2alias: define size of alias
Message-ID: <20190219200837.d34cxg2d7gqxlvhs@mok.nu>
References: <20190207123022.7961-1-2pi@mok.nu>
 <CAK7LNAQZ7PDZ4+uZu-FT4V8yw9oUGz6e++9xSshWJvALj3gN0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQZ7PDZ4+uZu-FT4V8yw9oUGz6e++9xSshWJvALj3gN0Q@mail.gmail.com>
X-Originating-IP: [94.234.42.81]
X-ClientProxiedBy: PROXY05.HMC.local (192.168.46.55) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 2019-02-18, Masahiro Yamada wrote:
> Hi Mattias,
> 
> On Thu, Feb 7, 2019 at 9:31 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> >
> > The size of the variable alias provided to do_entry functions are
> > currently not readily available. Thus hindering do_entry functions to
> > perform bounds checking.
> >
> > Define the macro ALIAS_SIZE containing the size of the variable alias.
> >
> > Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> 
> 
> Sorry for late reply.
> 
> I can apply this to my kbuild tree shortly, but
> it looks like a prerequisite for your
> "platform/x86: wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()"
> 
> 
> If you want all the patches to go through x86 platform-driver tree,
> I am fine with that too.

I don't mind either way, however I've asked the x86 platform-driver
maintainers if they have a preference in this matter. You should have
received that mail otherwise see [1].

[1]: https://lkml.kernel.org/r/082d3d38b7dde6050b6b3e518ada439eade65b2c.1550603967.git.2pi@mok.nu

> 
> Please let me know what you want.
> 
> Thanks.
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

Thanks,
Mattias
