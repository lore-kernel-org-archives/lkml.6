Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C2FC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD5F2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD5F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJGVtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 17:49:39 -0400
Received: from ms.lwn.net ([45.79.88.28]:34592 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbeJGVti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 17:49:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7FC458AF;
        Sun,  7 Oct 2018 14:42:11 +0000 (UTC)
Date:   Sun, 7 Oct 2018 08:42:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc:it_IT: add some process/* translations
Message-ID: <20181007084210.0cec373a@lwn.net>
In-Reply-To: <20181005185157.27819-1-federico.vaga@vaga.pv.it>
References: <20181005185157.27819-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 20:51:57 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> This patch does not translate entirely the subfolder "process/"
> but only part of it (to begin with).
> 
> In order to avoid broken links, I included empty documents
> for those which are not yet translated.
> 
> In order to be able to refer to all documents in "process/",
> I added a sphinx label to those which had not one.
> 
> Translated documents:
> - howto
> - 1.Intro
> - clang-format
> - coding-style
> - kernel-driver-statement
> - magic-number
> - volatile-considered-harmful
> - development-process
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>

Just FYI, I'll hold this until after the start of the merge window.

This is starting to be quite a bit of translated material!  Are you sure
you're up to maintaining it all as the documents evolve?

Thanks,

jon
