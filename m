Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64508C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153FA26252
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153FA26252
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbeF0MlX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:41:23 -0400
Received: from ozlabs.org ([203.11.71.1]:57831 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbeF0MlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:41:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41G2b01jTVz9s2L;
        Wed, 27 Jun 2018 22:41:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
In-Reply-To: <CAK8P3a2HwOe2D4LXgFsfhFXpeUBpHZiB5PCk0nkAwqX3NKCmFA@mail.gmail.com>
References: <20180619140229.3615110-1-arnd@arndb.de> <87y3f06e9a.fsf@concordia.ellerman.id.au> <CAK8P3a2HwOe2D4LXgFsfhFXpeUBpHZiB5PCk0nkAwqX3NKCmFA@mail.gmail.com>
Date:   Wed, 27 Jun 2018 22:41:13 +1000
Message-ID: <87lgb05rme.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Jun 27, 2018 at 6:32 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> So I think I can take this patch in isolation via the powerpc tree as a
>> fix for 4.18.
>>
>> I'll leave the other two alone.
>
> Yes, that is what I had intended with this series but should have made
> clearer. The two m68k patches are 4.19 material.

OK thanks.

cheers
