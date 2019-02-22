Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5962C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A070020700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBVPfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:35:52 -0500
Received: from ms.lwn.net ([45.79.88.28]:52494 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVPfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:35:52 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ACC28750;
        Fri, 22 Feb 2019 15:35:51 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:35:50 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@zh-kernel.org
Subject: Re: [PATCH v2 1/2] doc: translations: sync translations 'remove
 info about -git patches'
Message-ID: <20190222083550.2cf9c88f@lwn.net>
In-Reply-To: <20190221203000.10194-1-federico.vaga@vaga.pv.it>
References: <20190221203000.10194-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 21:29:59 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Synchonise translations: CN, IT, JP, KR
> 
> commit 2c71d305caf9 ("docs: process: Remove outdated info about -git patches")
> 
> I can guarantee for the Italian translations, but since we are removing
> an entire chapter I think I did it right also for the other languages.
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Both patches applied, thanks.

jon
