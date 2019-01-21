Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34FFC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC84A2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfAUHyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:54:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:33038 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfAUHyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:54:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC4E835A;
        Mon, 21 Jan 2019 01:56:22 +0000 (UTC)
Date:   Sun, 20 Jan 2019 18:56:17 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: add translations in process/
Message-ID: <20190120185617.44a7f275@lwn.net>
In-Reply-To: <20190119221341.3622-1-federico.vaga@vaga.pv.it>
References: <20190119221341.3622-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019 23:13:41 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> This patch adds the Italian translation for the following documents
> in Documentation/process:
> 
> - applying-patches
> - submit-checklist
> - submitting-drivers
> - changes
> - stable api nonsense
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

In general, this looks good.  One thing jumped at me, though...(OK, more
than one, but only one to fix):

> +Perl
> +----
> +
> +Per compilare il kernel vi servirà perl 5 e i seguenti moduli ``Getopt::Long``,
> +``Getopt::Std``, ``File::Basename``, e ``File::Find``.

Didn't Rob Landley go though some considerable pain a while back to
eliminate Perl from the basic kernel build?  This, perhaps, should come out
of the original.  (As long as it's still there, it makes sense to be in the
translation, of course).

> +Modifiche architetturali
> +------------------------
> +
> +DevFS è stato reso obsoleto da udev
> +(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
> +
> +Il supporto per UID a 32-bit è ora disponibile.  Divertitevi!

Speaking of stuff that should come out of the original...this is not
exactly news at this point...

Meanwhile, here is the thing that actually needs to be fixed:

> +Raiserfsprogs
> +-------------
> +
> +Il pacchetto raiserfsprogs dovrebbe essere usato con raiserfs-3.6.x (Linux
> +kernel 2.4.x).  Questo è un pacchetto combinato che contiene versioni
> +funzionanti di ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` e
> +``reiserfsck``.  Questi programmi funzionano sulle piattaforme i386 e alpha.

Even in Italian, I believe that 'Reiser" is spelled "Reiser"...

Thanks,

jon
