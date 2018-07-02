Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F51DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DCB24FA0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DCB24FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeGBTWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:22:52 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:58402 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeGBTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:22:51 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d45 with ME
        id 5vNl1y00341oiFu03vNlT6; Mon, 02 Jul 2018 21:22:49 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Jul 2018 21:22:49 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Mack <zonque@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: Tree for Jul 2 (sound/soc/pxa/)
References: <20180702145158.10190101@canb.auug.org.au>
        <2276786f-3f50-0740-0500-68a26a49704a@infradead.org>
        <c12cc7c4-03d0-4b0b-d02f-7e72b8a135d4@infradead.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 02 Jul 2018 21:22:45 +0200
In-Reply-To: <c12cc7c4-03d0-4b0b-d02f-7e72b8a135d4@infradead.org> (Randy
        Dunlap's message of "Mon, 2 Jul 2018 09:41:16 -0700")
Message-ID: <87h8lhh27u.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> [add other maintainers]
> on i386 or x86_64:
> 
> builtin:
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x228): undefined reference to `pxa2xx_soc_pcm_new'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x22c): undefined reference to `pxa2xx_pcm_free_dma_buffers'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x250): undefined reference to `pxa2xx_pcm_ops'

Hi Randy,

I think the fix is already queued in Mark's tree, the commit message should be
"ASoC: pxa: select SND_PXA2XX_LIB for drivers that depend on it".

Adding Daniel as he is the original author.

Cheers.

--
Robert
