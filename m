Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF3FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC93223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC93223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeKMCCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:02:22 -0500
Received: from ms.lwn.net ([45.79.88.28]:57078 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbeKMCCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:02:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5D5212E5;
        Mon, 12 Nov 2018 16:08:29 +0000 (UTC)
Date:   Mon, 12 Nov 2018 09:08:28 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181112090828.2573987d@lwn.net>
In-Reply-To: <20181112023630.GA20359@kroah.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <20181110192027.GA29892@kroah.com>
        <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
        <20181112023630.GA20359@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 18:36:30 -0800
Greg KH <gregkh@linuxfoundation.org> wrote:

> We should have a checklist.  That's a great idea.  Now to find someone
> to write it... :)

Do we think the LPC session might have the right people to create such a
thing?  If so, I can try to put together a coherent presentation of the
result.

jon
