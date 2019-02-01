Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88F12148D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfBAXP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:15:28 -0500
Received: from ms.lwn.net ([45.79.88.28]:33532 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAXP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:15:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9DF432BD;
        Fri,  1 Feb 2019 23:05:40 +0000 (UTC)
Date:   Fri, 1 Feb 2019 16:05:39 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Kepplinger Martin <Martin.Kepplinger@ginzinger.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Michael Rodin <michael-git@rodin.online>,
        Minghui Liu <minghui.liu.95@gmail.com>,
        Grigory Shipunov <mail@oxapentane.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Coly Li <colyli@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: Change LXR references to elixir.bootlin.com
Message-ID: <20190201160539.68cd8897@lwn.net>
In-Reply-To: <20190130172528.7552-1-j.neuschaefer@gmx.net>
References: <20190130172528.7552-1-j.neuschaefer@gmx.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 18:25:15 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Recently, Free Electrons was renamed to Bootlin[1]. Less recently, the
> Linux Cross Reference (LXR) at lxr.free-electrons.com was replaced by
> Elixir[2], and lxr.free-electrons.com redirected first to
> elixir.free-electrons.com and now to elixir.bootlin.com.
> 
> [1]: https://bootlin.com/blog/free-electrons-becomes-bootlin/
> [2]: https://github.com/free-electrons/elixir
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - Fix ident search URL, as suggested by Martin Kepplinger
> - Add trailing slash, which I accidentally dropped in v1 in
>   Documentation/translations/it_IT/process/howto.rst

Applied, thanks.

jon
