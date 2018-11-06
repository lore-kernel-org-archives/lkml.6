Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C5C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EE12085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EE12085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbeKFSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:47:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36360 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbeKFSrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:47:10 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gYcSjSxHh4l6; Tue,  6 Nov 2018 10:22:52 +0100 (CET)
Received: from zn.tnic (p200300EC2BD1C800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:c800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 019811EC0979;
        Tue,  6 Nov 2018 10:22:51 +0100 (CET)
Date:   Tue, 6 Nov 2018 10:22:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        manish.narani@xilinx.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
Message-ID: <20181106092251.GB13712@zn.tnic>
References: <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
 <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
 <20181105194721.GB26868@zn.tnic>
 <CAOesGMjsPWeRZEeBH37uLQFBKwAWNMh5yCvuKNYrOUDfRSSYog@mail.gmail.com>
 <20181105204322.GE26868@zn.tnic>
 <38dc38b6-25f4-194c-9ba9-577d35e92700@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38dc38b6-25f4-194c-9ba9-577d35e92700@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 07:46:55AM +0100, Michal Simek wrote:
> I think Boris should take also this one (dt binding doc change) because
> it is aligned with changes in the driver.
> https://lkml.kernel.org/r/1538667328-9465-7-git-send-email-manish.narani@xilinx.com

Ok, done.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
