Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FC1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416CD214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416CD214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeHVQMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:12:46 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28723 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeHVQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:12:46 -0400
X-IronPort-AV: E=Sophos;i="5.53,274,1531810800"; 
   d="scan'208";a="16397722"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Aug 2018 05:47:59 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Wed, 22 Aug 2018
 05:47:58 -0700
Subject: at91 git tree in linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <ksummit-discuss@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <551A9FAC.2010203@atmel.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <f15a82c8-5960-34ea-e7fc-dffdfdd369c6@microchip.com>
Date:   Wed, 22 Aug 2018 14:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <551A9FAC.2010203@atmel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Alexandre Ludovic and myself are the group of maintainers for Microchip 
ARM SoCs. The current tree that we have in linux-next is mine [1] and we 
are moving to a common group kernel.org tree.

So, can you please add our new tree to linux-next:
at91 git 
git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-next

instead of:
git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git#at91-next

In addition to that, we also have now a "fixes" branch. Can you please 
add it to your "fixes" tree?

at91 git 
git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-fixes

Thanks for your help, best regards,
   Nicolas


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Next/Trees#n84


Reference of previous request below... back in the days...

On 31/03/2015 at 15:22, Nicolas Ferre wrote:
> Hi Stephen,
> 
> I am the maintainer for the Atmel ARM SoCs (aka at91) and I would like to
> know if it's possible for you to include my git tree in linux-next. It is
> usually pulled in by the ARM-soc guys (in copy).
> 
> Here it is, with the branch that you would pull: "at91-next".
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git  at91-next
> 
> I usually merge branches in this particular one when I send a pull-request to
> Arnd, Olof and Kevin so the material is usually pretty "stable".
> 
> Thanks, bye,
> 


-- 
Nicolas Ferre
