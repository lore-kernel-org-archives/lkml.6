Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934661AbeEIMc1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:32:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934126AbeEIMcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:32:23 -0400
Date: Wed, 9 May 2018 09:32:18 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 18/18] w1: w1_io.c: fix a kernel-doc warning
Message-ID: <20180509093218.5e566439@vento.lan>
In-Reply-To: <702861525777419@web22j.yandex.ru>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <cover.1525684985.git.mchehab+samsung@kernel.org>
        <cd5b6e6a8d51820ee158127cdd50e44645c44ee7.1525684985.git.mchehab+samsung@kernel.org>
        <702861525777419@web22j.yandex.ru>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w49CWWKJ004320

Em Tue, 08 May 2018 14:03:39 +0300
Evgeniy Polyakov <zbr@ioremap.net> escreveu:

> Hi
> 
> 07.05.2018, 12:36, "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>:
> > Add a blank line to avoid this Sphinx warning:
> >         ./drivers/w1/w1_io.c:197: WARNING: Definition list ends without a blank line; unexpected unindent.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Looks good to me, thank you!
> What tree should this be forwarded to, or folks from linux doc will pick it up?
> 
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

Jon prefers if this could go via the usual maintainer's tree.

So, could you send it via yours?

Thanks,
Mauro
