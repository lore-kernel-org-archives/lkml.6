Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58EAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B48220871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B48220871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeFTLDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:03:04 -0400
Received: from twin.jikos.cz ([91.219.245.39]:34276 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753622AbeFTLDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:03:02 -0400
X-Greylist: delayed 1791 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2018 07:03:01 EDT
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id w5KAW1G6004161
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 20 Jun 2018 12:32:02 +0200
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id w5KAVu2b004150;
        Wed, 20 Jun 2018 12:31:56 +0200
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Wed, 20 Jun 2018 12:31:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
In-Reply-To: <d86fa9cdb4c160350268c70bd8fead138ce5a8e2.camel@kernel.crashing.org>
Message-ID: <alpine.LRH.2.00.1806201230540.1881@gjva.wvxbf.pm>
References: <1281327087.2168.67.camel@pasglop>         <CA+55aFxRyp4G4niZ=aMk+epdSbu5MB1oJg_h4NhLkxsM+f+SLQ@mail.gmail.com> <d86fa9cdb4c160350268c70bd8fead138ce5a8e2.camel@kernel.crashing.org>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Benjamin Herrenschmidt wrote:

> > I love the alleged line removal, but there's nothing in that 'merge'
> > branch. It points to an ancient powerpc commit from 2016.
> > 
> > And please, signed tags. I know you do them, because you used to send me them.
> 
> I didn't send this. It's an ancient (8 years old) email... I have no
> idea how it got resent while I was asleep...

I got a few mails from 2010 this morning as well. From the headers it 
looks like Mauro (CCed) re-bounced them for some reason.

-- 
Jiri Kosina
SUSE Labs
