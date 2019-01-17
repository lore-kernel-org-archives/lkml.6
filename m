Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075A8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD4A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfAQWT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:19:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:40444 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfAQWTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:19:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1F8747DF;
        Thu, 17 Jan 2019 22:19:55 +0000 (UTC)
Date:   Thu, 17 Jan 2019 15:19:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <greg@kroah.com>
Subject: Re: doc: stable-api-nonsense missing link
Message-ID: <20190117151953.2ab38ecc@lwn.net>
In-Reply-To: <3122599.2K0FN2NGh9@harkonnen>
References: <3122599.2K0FN2NGh9@harkonnen>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 23:14:08 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> in this document
> 
> Documentation/process/stable-api-nonsense.rst
> 
> there is this note:
> 
> <insert link to leech comment from Andrew and Linus here>
> 
> Is it possible to get it fixed with the proper link? I searched for it without 
> success. If that comment is impossible to find I will send a patch to remove 
> that note, but first I wanted to ask you if you know where to get it.

That sounds like a question for Greg (copied).  Given that this document
predates the Git era, though, I suspect that whatever reference that was
meant to be is long since lost.

jon
