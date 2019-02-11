Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07FDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB73121B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389953AbfBKPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:30:47 -0500
Received: from ms.lwn.net ([45.79.88.28]:46162 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbfBKPao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:30:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F42272F3;
        Mon, 11 Feb 2019 15:30:42 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:30:41 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Michael Rodin <michael-git@rodin.online>,
        Minghui Liu <minghui.liu.95@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: Remove outdated info about -git patches
Message-ID: <20190211083041.3ca6a6b1@lwn.net>
In-Reply-To: <20190210171300.29613-1-j.neuschaefer@gmx.net>
References: <20190210171300.29613-1-j.neuschaefer@gmx.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 18:12:59 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> As can be seen by clicking around the timeline on web.archive.org[1],
> there were no -git patches/tarballs on kernel.org since release 3.1.
> 
> [1]: https://web.archive.org/web/20111103073843/http://www.kernel.org/
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

There's a lot more stuff in that file needing fixing (including all of
the 4.x references) but one has to start somewhere...applied, thanks.

jon
