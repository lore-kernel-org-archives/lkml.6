Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE860C282E6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CF420989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbfAUHyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:54:54 -0500
Received: from ms.lwn.net ([45.79.88.28]:33040 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbfAUHyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:54:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 43FCD9B4;
        Mon, 21 Jan 2019 01:57:20 +0000 (UTC)
Date:   Sun, 20 Jan 2019 18:57:16 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: documentation alignment
Message-ID: <20190120185716.17e61bd5@lwn.net>
In-Reply-To: <20190119221422.3685-1-federico.vaga@vaga.pv.it>
References: <20190119221422.3685-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019 23:14:22 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> It aligns the italian translation with the latest changes:
> 
> ae67ee6c5e1d docs: fix Co-Developed-by docs
> 3fe5dbfef47e Documentation/process/coding-style.rst: don't use "extern" with function prototypes
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied, thanks.

jon
