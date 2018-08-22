Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1151C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62242214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62242214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeHVRAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:00:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47476 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbeHVRAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:00:03 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id enChWvfpM3nP; Wed, 22 Aug 2018 15:34:48 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B6CF81EC0322;
        Wed, 22 Aug 2018 15:34:47 +0200 (CEST)
Date:   Wed, 22 Aug 2018 15:34:57 +0200
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
Subject: Re: [PATCH v4 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Message-ID: <20180822133457.GA6462@nazgul.tnic>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-4-git-send-email-manish.narani@xilinx.com>
 <20180821130946.GD30528@nazgul.tnic>
 <DM6PR02MB522788F1286F18FBC6458E0EC1300@DM6PR02MB5227.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR02MB522788F1286F18FBC6458E0EC1300@DM6PR02MB5227.namprd02.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 01:02:40PM +0000, Manish Narani wrote:
>  I could remove 'synps_enh' from the prefix and keep 'zynq' and
> 'zynqmp' to differentiate. Please suggest.

Makes sense and it is shorter, sure.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
