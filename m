Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BFBC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F52154C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48F52154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJUCkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 22:40:17 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:53166 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbeJUCkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 22:40:17 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9KISjB7006178;
        Sat, 20 Oct 2018 19:28:45 +0100
Date:   Sat, 20 Oct 2018 19:28:45 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [PATCH 6/7] Code of Conduct: Change the contact email address
Message-ID: <20181020192845.48b8b860@alans-desktop>
In-Reply-To: <20181020135118.GG32218@kroah.com>
References: <20181020134908.GA32218@kroah.com>
        <20181020135118.GG32218@kroah.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +to the circumstances. The Code of Conduct Committee is obligated to
> +maintain confidentiality with regard to the reporter of an incident.
> +Further details of specific enforcement policies may be posted
> +separately.

Unfortunately by ignoring the other suggestions on this you've left this
bit broken.

The committee can't keep most stuff confidential so it's misleading and
wrong to imply they can. Data protection law, reporting laws in some
countries and the like mean that anyone expecting an incident to remain
confidential from the person it was reported against is living in
dreamland and are going to get a nasty shock.

At the very least it should say '(except where required by law)'.

There is a separate issue that serious things should always go to law
enforcement - you are setting up a policy akin to the one that got the
catholic church and many others in trouble.

You should also reserving the right to report serious incidents directly
to law enforcement. Unless of course you want to be forced to sit on
multiple reports of physical abuse from different people about
someone - unable to tell them about each others report, unable to prove
anything, and in twenty years time having to explain to the media why
nothing was done.

Alan
