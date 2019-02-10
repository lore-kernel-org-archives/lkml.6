Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C062C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055592084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfBJNZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 08:25:08 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:56544 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfBJNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 08:25:08 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-87-85-nat.elisa-mobile.fi [85.76.87.85])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 7492F40076;
        Sun, 10 Feb 2019 15:25:05 +0200 (EET)
Date:   Sun, 10 Feb 2019 15:25:05 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Yifeng Li <tomli@tomli.me>
Cc:     linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] mips: loongson64: move EC header to
 include/asm/mach-loongson64
Message-ID: <20190210132505.GA22242@darkstar.musicnaut.iki.fi>
References: <20190210130617.8392-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210130617.8392-1-tomli@tomli.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 10, 2019 at 09:06:16PM +0800, Yifeng Li wrote:
> In order to operate the Embedded Controller from multiple platform
> drivers, it should be possible to include lemote-2f/ec_kb3310b.h
> from everywhere. This commits move it from lemote-2f/ec_kb3310b.h
> to include/asm/mach-loongson64/.
> 
> This simple patch immediately enables the implementation of two
> platform drivers. if there's no objection from the maintainers,
> please consider to prioritize it for mips-next, thanks.
> 
> Yifeng Li (1):
>   mips: loongson64: move EC header to include/asm/mach-loongson64

This probably should be MFD driver under drivers/mfd. It's a longer
road, though...

A.
