Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F37C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C020C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C020C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeFTRIA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:08:00 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:29237 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTRH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:07:58 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d64 with ME
        id 157u1y00241oiFu0357ueT; Wed, 20 Jun 2018 19:07:57 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 20 Jun 2018 19:07:57 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180618104159.24b9fffb@bbrezillon> <87d0wnrhqz.fsf@belgarion.home>
        <20180618220455.1810f2a5@bbrezillon>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 20 Jun 2018 19:07:53 +0200
In-Reply-To: <20180618220455.1810f2a5@bbrezillon> (Boris Brezillon's message
        of "Mon, 18 Jun 2018 22:04:55 +0200")
Message-ID: <87tvpxpes6.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> Don't worry, we're not planning to merge it unless it happens to be
> required (Stephen Rothwell reporting a merge conflict in next), and we
> don't have conflicting changes in the pipeline so far.
Ok, great.

We're good to go, no screaming from 0-day, my internal testbench is happy,
everything looks fine, the tag is unmutable until v4.19.

Cheers.

-- 
Robert
