Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4895C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A72073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701A72073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIECUc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:20:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54470 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbeIECUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:20:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3CA94208A4; Tue,  4 Sep 2018 23:53:29 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id B6D8320730;
        Tue,  4 Sep 2018 23:53:18 +0200 (CEST)
Date:   Tue, 4 Sep 2018 23:53:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Cc:     boris.brezillon@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mtd: nand: toshiba: Add support for Toshiba Memory
 BENAND (Built-in ECC NAND)
Message-ID: <20180904235317.0c98e0f1@xps13>
In-Reply-To: <1533360352-2882-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
References: <1533360352-2882-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshitake,

KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp> wrote on Sat,
4 Aug 2018 14:25:52 +0900:

> This patch is a patch to support TOSHIBA MEMORY CORPORATION BENAND
> memory devices.  Check the status of the built-in ECC with the Read
> Status command without using the vendor specific command.  The Read
> Status command only knows whether there was bitflips above the
> threshold and can not get accurate bitflips.  For now, I set
> max_bitflips mtd->bitflip_threshold.
> 
> Signed-off-by: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
> ---

Applied to nand/next.

Thanks,
Miquèl
