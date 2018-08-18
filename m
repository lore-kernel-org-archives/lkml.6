Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A03EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8982183D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8982183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeHRPxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:53:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbeHRPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:53:22 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F7uOj9v5eTIC; Sat, 18 Aug 2018 14:45:27 +0200 (CEST)
Received: from nazgul.tnic (95-42-156-121.ip.btc-net.bg [95.42.156.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AE3D1EC028D;
        Sat, 18 Aug 2018 14:45:27 +0200 (CEST)
Date:   Sat, 18 Aug 2018 14:45:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        Edgar Iglesias <edgari@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Message-ID: <20180818124537.GA24733@nazgul.tnic>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-2-git-send-email-manish.narani@xilinx.com>
 <DM6PR02MB5227CBDE0742DB55F26F014CC13C0@DM6PR02MB5227.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR02MB5227CBDE0742DB55F26F014CC13C0@DM6PR02MB5227.namprd02.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 10:11:54AM +0000, Manish Narani wrote:
> Ping.

First of all, one ping is enough. If your patchset contained, say, 30
patches, were you really going to send a ping for each one of them?!?!?!

Secondly, you do know that we have merge window right now, don't you?

And during the merge window, people are busy with merge window testing
and sending stuff which is ready, upstream - not reviewing new code
which has absolutely no chance of going in now?

Jeez.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
