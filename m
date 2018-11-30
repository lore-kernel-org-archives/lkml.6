Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F379C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A3A20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A3A20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLAJNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:13:18 -0500
Received: from twin.jikos.cz ([91.219.245.39]:38918 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAJNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:13:18 -0500
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id wAULxvKl008776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 30 Nov 2018 22:59:58 +0100
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id wAULxqGT008771;
        Fri, 30 Nov 2018 22:59:52 +0100
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Fri, 30 Nov 2018 22:59:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org, Sam Creasey <sammy@sammy.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH RFC 04/15] m68k: replace **** with a hug
In-Reply-To: <20181130205912.GB22338@linux.intel.com>
Message-ID: <alpine.LRH.2.00.1811302257400.18805@gjva.wvxbf.pm>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-5-jarkko.sakkinen@linux.intel.com> <e1571a6d-b71a-3324-1d73-fa9e74a7d687@physik.fu-berlin.de> <20181130205912.GB22338@linux.intel.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Jarkko Sakkinen wrote:

> > Never in my dreams would I have expected that the dystopia predicted
> > in "Demolition Man" would ever come true and that so early.
> > 
> > I'm waiting for the automatic punishment machines which spit out tickets
> > whenever someone in their proximity utters a swearword.
> 
> Sorry I had 10h flight, internet connection not properly working and too
> much time :-) 

To be totally honest, to me that feels like a little bit too weak excuse 
for wasting time and energy of gazillion other people with your patches.

> I thought that with the new CoC I could not grep the f-word from the 
> kernel tree but there it was...

Sorry, but you were wrong. It's not retro-active.

-- 
Jiri Kosina
