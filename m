Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8047C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D53D2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D53D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeIADCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:02:34 -0400
Received: from ms.lwn.net ([45.79.88.28]:34050 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeIADCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:02:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7BD3F9B4;
        Fri, 31 Aug 2018 22:52:48 +0000 (UTC)
Date:   Fri, 31 Aug 2018 16:52:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        cocci@systeme.lip6.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: dev-tools: coccinelle: Update documentation
Message-ID: <20180831165235.1c12e0b8@lwn.net>
In-Reply-To: <20180813104638.7935-1-himanshujha199640@gmail.com>
References: <20180813104638.7935-1-himanshujha199640@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 16:16:38 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> * Fix install instruction by adding `./autogen` command
>   before `./configure`.
> * Add link to a more detailed installation instruction.
> * Add link to SmPL grammar documentation.
> * Add single space after ',' to slightly improve readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Applied, thanks,

jon
