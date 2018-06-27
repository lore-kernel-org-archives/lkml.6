Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D28C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEBD25B8E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEBD25B8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755015AbeF0VDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:03:20 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:51522 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754820AbeF0VDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:03:19 -0400
Received: from [192.168.178.170] (pD95EF523.dip0.t-ipconnect.de [217.94.245.35])
        by mail.bugwerft.de (Postfix) with ESMTPSA id BC3DF28BDC0;
        Wed, 27 Jun 2018 21:00:04 +0000 (UTC)
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        alsa-devel@alsa-project.org
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180618104159.24b9fffb@bbrezillon> <87d0wnrhqz.fsf@belgarion.home>
 <20180625130704.GQ9413@sirena.org.uk> <87r2ksl0wa.fsf@belgarion.home>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <45a4e773-aaa3-6d43-f02d-5056a2a265d4@zonque.org>
Date:   Wed, 27 Jun 2018 23:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87r2ksl0wa.fsf@belgarion.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 27, 2018 05:11 PM, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:
> 
>> On Mon, Jun 18, 2018 at 09:56:20PM +0200, Robert Jarzmik wrote:
>>
>>> I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
>>> checker to be fully covered, and I'd like as well to know which tree the ASoC
>>> patch will take, ie. if Mark commits to take it, or rather wants to pull from
>>> the imutable branch.
>>
>> I'll pull the branch in (a signed tag would've been nicer but it's not
>> the end of the world).
> Yeah, I realised that too ... late.
> 
> Anyways, the immutable branch doesn't contain the specific ASoC patch "ASoC:
> pxa: remove the dmaengine compat need", and up to my better understanding
> neither does your for-next branch.
> 
> So until I see it in your branch it will dwelve happily in pxa/for-next. If it
> has to be routed through your tree, so that Daniel can work on ASoC pxa, I'd
> like to know at -rc4 time so that I drop it from my pxa/for-next branch.

Ah, yes. The series I just posted depends on that.


