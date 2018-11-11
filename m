Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87653C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78520881
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F78520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeKLGmw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:42:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54879 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeKLGmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:42:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7688420757; Sun, 11 Nov 2018 21:53:13 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id D5543206A7;
        Sun, 11 Nov 2018 21:53:12 +0100 (CET)
Date:   Sun, 11 Nov 2018 21:53:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mtd: rawnand: Provide helper for polling GPIO
 R/B pin
Message-ID: <20181111215311.5e8551b4@xps13>
In-Reply-To: <20181015194130.21764-1-jmkrzyszt@gmail.com>
References: <20181012204101.26274-1-jmkrzyszt@gmail.com>
        <20181015194130.21764-1-jmkrzyszt@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Mon, 15 Oct 2018
21:41:28 +0200:

> Each controller driver having access to NAND R/B pin over GPIO would
> have to reimplement the polling loop otherwise.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---

Series applied to nand/next.

Thanks,
Miquèl
