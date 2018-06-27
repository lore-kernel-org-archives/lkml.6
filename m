Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25842C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79FA2442A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79FA2442A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeF0PLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:11:53 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:36716 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeF0PLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:11:51 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d42 with ME
        id 3rBp1y00W41oiFu03rBqLU; Wed, 27 Jun 2018 17:11:50 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 27 Jun 2018 17:11:50 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180618104159.24b9fffb@bbrezillon> <87d0wnrhqz.fsf@belgarion.home>
        <20180625130704.GQ9413@sirena.org.uk>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 27 Jun 2018 17:11:49 +0200
In-Reply-To: <20180625130704.GQ9413@sirena.org.uk> (Mark Brown's message of
        "Mon, 25 Jun 2018 14:07:04 +0100")
Message-ID: <87r2ksl0wa.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Jun 18, 2018 at 09:56:20PM +0200, Robert Jarzmik wrote:
>
>> I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
>> checker to be fully covered, and I'd like as well to know which tree the ASoC
>> patch will take, ie. if Mark commits to take it, or rather wants to pull from
>> the imutable branch.
>
> I'll pull the branch in (a signed tag would've been nicer but it's not
> the end of the world).
Yeah, I realised that too ... late.

Anyways, the immutable branch doesn't contain the specific ASoC patch "ASoC:
pxa: remove the dmaengine compat need", and up to my better understanding
neither does your for-next branch.

So until I see it in your branch it will dwelve happily in pxa/for-next. If it
has to be routed through your tree, so that Daniel can work on ASoC pxa, I'd
like to know at -rc4 time so that I drop it from my pxa/for-next branch.

Cheers.

-- 
Robert
