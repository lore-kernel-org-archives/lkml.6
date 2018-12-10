Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC75520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC75520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbeLJQ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:27:22 -0500
Received: from ms.lwn.net ([45.79.88.28]:59438 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJQ1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:27:21 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 203C52D4;
        Mon, 10 Dec 2018 16:27:16 +0000 (UTC)
Date:   Mon, 10 Dec 2018 09:27:06 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181210092706.1aa54432@lwn.net>
In-Reply-To: <b3d765e1-69a0-d4f0-b04a-40c19df8111c@infradead.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <20181110192027.GA29892@kroah.com>
        <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
        <20181112023630.GA20359@kroah.com>
        <20181112090828.2573987d@lwn.net>
        <b3d765e1-69a0-d4f0-b04a-40c19df8111c@infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 20:38:56 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/12/18 8:08 AM, Jonathan Corbet wrote:
> > On Sun, 11 Nov 2018 18:36:30 -0800
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> >> We should have a checklist.  That's a great idea.  Now to find someone
> >> to write it... :)  
> > 
> > Do we think the LPC session might have the right people to create such a
> > thing?  If so, I can try to put together a coherent presentation of the
> > result.  
> 
> Hi,
> Did anything ever happen with this syscall checklist suggestion?

No, we really didn't have the right people around to do that,
unfortunately.  

jon
