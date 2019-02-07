Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E93C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DFA21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfBGKs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:48:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50038 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:48:56 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CAB9927E636;
        Thu,  7 Feb 2019 10:48:54 +0000 (GMT)
Date:   Thu, 7 Feb 2019 11:48:50 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <frieder.schrempf@kontron.de>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Message-ID: <20190207114843.01c431dd@kernel.org>
In-Reply-To: <5bdbd64f-bacd-8192-b7eb-6ec4c06baec0@microchip.com>
References: <20190123075538.12681-1-frieder.schrempf@kontron.de>
        <f0b2c97b-419a-1e3e-4624-52c60fe32065@microchip.com>
        <52338dfe-aca1-503d-6871-c4be09f1f3ac@kontron.de>
        <5bdbd64f-bacd-8192-b7eb-6ec4c06baec0@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 10:16:05 +0000
<Tudor.Ambarus@microchip.com> wrote:

> Hi, Frieder,
> 
> On 02/07/2019 12:06 PM, Schrempf Frieder wrote:
> > Hi Tudor,
> > 
> > On 03.02.19 14:33, Tudor.Ambarus@microchip.com wrote:  
> >> Hi, Frieder,
> >>
> >> On 01/23/2019 09:56 AM, Schrempf Frieder wrote:  
> >>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>>
> >>> This adds support for the EON EN25Q80A, a 8Mb SPI NOR chip.  
> >> I would suggest to specify who is using this flash and how did you test it. This
> >> way we will not end up with support for flashes that are not actually used.  
> > Ok. The flash is used by a board that I plan to upstream. Maybe I should 
> > just resubmit this together with the actual board support patches?

No need to wait for the board patches, they'll be applied independently
anyway. Just mention the board you tested it on in the commit message
(even if it's not upstream yet) and we should be good.

Thanks,

Boris
