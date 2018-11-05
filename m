Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E504C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5B20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD5B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeKEXCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:02:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53516 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbeKEXCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:02:14 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C1U5OyZHI3z8; Mon,  5 Nov 2018 14:42:24 +0100 (CET)
Received: from zn.tnic (p200300EC2BC6CF00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:cf00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 470BB1EC04A6;
        Mon,  5 Nov 2018 14:42:24 +0100 (CET)
Date:   Mon, 5 Nov 2018 14:42:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Manish Narani <manish.narani@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, amit.kucheria@linaro.org,
        sudeep.holla@arm.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
Message-ID: <20181105134218.GD7937@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:32:55PM +0100, Michal Simek wrote:
> you don't have that HW anyway.

Grrr, I'm not talking about me - I'm talking about people testing
linux-next. And perhaps in this particular case it won't matter because
this hw is not shipping yet or whatever but the question is about the
principle of the whole thing.

> I looked at v10 and I can't see your ack there. Can you please give me
> a link?

I'm talking about *other* patches for another driver.

Please note that I'm replying to this thread as an example - the
procedural question I have is not only related to the synopsys changes
but the synopsys changes are a good example for the problem of EDAC
changes being sent to me along with DT additions.

As such, the question was aimed more at arm-soc people - that's why they
were in To: - not at you.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
