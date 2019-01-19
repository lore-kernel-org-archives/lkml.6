Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A15EC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8152086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfASWLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:11:42 -0500
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:57840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729056AbfASWLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:11:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4CC4F182CED34;
        Sat, 19 Jan 2019 22:11:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blood27_830b726b8f114
X-Filterd-Recvd-Size: 1550
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Jan 2019 22:11:40 +0000 (UTC)
Message-ID: <229635c22b0b7e11999df96a9d25f599cd391ded.camel@perches.com>
Subject: Re: [PATCH] tty: moxa: Fix coding style issues
From:   Joe Perches <joe@perches.com>
To:     Antoine Robertson <antoinerbrtsn@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 19 Jan 2019 14:11:39 -0800
In-Reply-To: <20190119220558.28927-1-antoinerbrtsn@gmail.com>
References: <20190119220558.28927-1-antoinerbrtsn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-01-19 at 17:05 -0500, Antoine Robertson wrote:
> Fix coding style issues
[]
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
[]
> @@ -74,8 +74,7 @@ enum {
>  	MOXA_BOARD_CP204J,
>  };
>  
> -static char *moxa_brdname[] =
> -{
> +static char *moxa_brdname[] = {

If you're going to fix this, might as well make it static const char *

>  	"C218 Turbo PCI series",
>  	"C218 Turbo ISA series",
>  	"C320 Turbo PCI series",
[]
> @@ -1357,8 +1355,7 @@ static void moxa_new_dcdstate(struct moxa_port *p, u8 dcd)
>          	spin_unlock_irqrestore(&p->port.lock, flags);
>  		if (!dcd)
>  			tty_port_tty_hangup(&p->port, true);
> -	}
> -	else
> +	} else

and use } else {

>  		spin_unlock_irqrestore(&p->port.lock, flags);
>  }


