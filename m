Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935671AbeEYG4T convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:56:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55307 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934393AbeEYG4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:56:17 -0400
Date: Fri, 25 May 2018 08:56:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 05/13] mtd: rawnand: marvell: remove the dmaengine
 compat need
Message-ID: <20180525085614.6cdfb484@xps13>
In-Reply-To: <87603dx700.fsf@belgarion.home>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
        <20180524070703.11901-6-robert.jarzmik@free.fr>
        <20180524113006.3d5f393e@xps13>
        <87603dx700.fsf@belgarion.home>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Thu, 24 May 2018 20:07:11 +0200, Robert Jarzmik
<robert.jarzmik@free.fr> wrote:

> Miquel Raynal <miquel.raynal@bootlin.com> writes:
> 
> > Hi Robert,  
> 
> Actually, a last time error slipped in this patch here (I'm really doing poorly
> on the copy paste side):
> +	nfc->dma_chan =	dma_request_slave_channel(&nfc->dev, "data");
> 
> This should rather be :
> +	nfc->dma_chan =	dma_request_slave_channel(nfc->dev, "data");
> 
> Would you grant your ack for the next iteration with this change folded in ?

Didn't spot it. But, sure, I'm okay with the changes :)

Thanks,
Miquèl
