Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612D8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AA42098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AA42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJDRWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:22:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60787 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeJDRWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:22:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5D577209D6; Thu,  4 Oct 2018 12:29:40 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32D8B207F3;
        Thu,  4 Oct 2018 12:29:30 +0200 (CEST)
Date:   Thu, 4 Oct 2018 12:29:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rtc: cmos: Fix non-ACPI (non-x86) platform support
Message-ID: <20181004102930.GQ4088@piout.net>
References: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 02:08:37+0100, Maciej W. Rozycki wrote:
> Hi,
> 
>  This mini patch series fixes issues introduced recently for non-ACPI 
> platforms using `rtc-cmos'.  Please see individual change descriptions for 
> details.
> 
>  These have been run-time verified with the DECstation (arch/mips/dec).  
> Please apply.
> 

Both applied, thanks!

>   Maciej

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
