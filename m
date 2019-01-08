Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75D0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB14206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfAHC2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:28:04 -0500
Received: from ozlabs.org ([203.11.71.1]:60111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfAHC2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:28:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43YblP5zmqz9sD9;
        Tue,  8 Jan 2019 13:28:01 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 7
In-Reply-To: <87sgy4a7vi.fsf@concordia.ellerman.id.au>
References: <20190107150609.0510def3@canb.auug.org.au> <CAMuHMdUCKaADLBrv0KLXSYHe8bR3ws7mhYr+1SkFYW15kDGo9Q@mail.gmail.com> <87va30adsg.fsf@concordia.ellerman.id.au> <87sgy4a7vi.fsf@concordia.ellerman.id.au>
Date:   Tue, 08 Jan 2019 13:28:01 +1100
Message-ID: <87k1jfc28e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>> On Mon, Jan 7, 2019 at 5:08 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>> Status of my local build tests will be at
>>>> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
>>>> advice about cross compilers/configs that work, we are always open to add
>>>> more builds.
>>>
>>>     Proxy Error
>>>     The proxy server received an invalid response from an upstream server.
>>>     The proxy server could not handle the request GET /kisskb/.
>>>
>>>     Reason: Error reading from remote server
>>>
>>>     Apache/2.4.37 (Debian) Server at kisskb.ellerman.id.au Port 80
>>>
>>> Oops...
>>
>> Erk.
>>
>> Seems postgres is unhappy, database is corrupt.
>>
>> I'm restoring from a backup but it seems to be taking a long time, I may
>> not get it finished tonight.
>
> So I finally got the backup to restore.
>
> Then I restarted everything, and as soon as the first set of new results
> came in the DB appears to have wedged again.

Seems 00:56 me was a pit too impatient. It's up now and seems to be
working OK.

Sorry for the outage.

cheers
