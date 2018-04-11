Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeDKO72 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:59:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54498 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752947AbeDKO71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:59:27 -0400
Date: Wed, 11 Apr 2018 16:59:25 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Josh Wu <rainyfeeling@outlook.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180411165925.2be0d45b@bbrezillon>
In-Reply-To: <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
        <20180329153322.5e2fc1e7@bbrezillon>
        <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
        <20180329154416.5c1a0013@bbrezillon>
        <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
        <20180402142249.7e076a64@bbrezillon>
        <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
        <20180402212843.164d5d21@bbrezillon>
        <20180402222020.1d344c14@bbrezillon>
        <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
        <20180403091813.5fb5c18c@bbrezillon>
        <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 16:44:10 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi Nicolas,
> 
> Boris asked for your input on this (the datasheet difference appears to
> have no bearing on the issue) elsewhere in the tree of messages. It's
> now been a week or so and I'm starting to wonder if you missed this
> altogether or if you are simply out of office or something?

I was wondering if you had given up on this problem, it seems you did
not. Did you try forcing the HLCDC to use the 2nd interface (ahb_id=1)
instead of the first one?
