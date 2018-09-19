Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0EDECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302282150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302282150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeISQxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:53:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeISQxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:53:31 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2zbwqiJwfM9w; Wed, 19 Sep 2018 13:16:04 +0200 (CEST)
Received: from nazgul.tnic (unknown [193.179.3.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB1131EC0322;
        Wed, 19 Sep 2018 13:16:03 +0200 (CEST)
Date:   Wed, 19 Sep 2018 13:15:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Message-ID: <20180919111553.GA9140@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 05:14:51AM +0000, Manish Narani wrote:
> > So I'm going to stop reviewing this patchset until you go through the old review
> > round again and make sure you've incorporated *all* review feedback and
> > haven't forgotten some, like the one above.
> > 
> Okay, I will double check again for the comments from previous review
> and rectify the same in v8. Can you please review the remaining
> patches so that I can accommodate any changes for them in v8?

Read again what I said: "I'm going to stop reviewing this patchset until
you go through the old review..." You can go through the old review and
check your v7. If you haven't missed anything, lemme know and I'll look
at the rest.

If you have, I'll wait for v8.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
