Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C662DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A29B218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="vbaTSr4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBFWzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:55:46 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:7128 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBFWzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:55:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id B0BE141271;
        Wed,  6 Feb 2019 23:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1549493741; x=1551308142; bh=cSQFj/e5yeGepIM3HPm2zA/jH/JLbnQ2e9W
        gDu570x8=; b=vbaTSr4M+5x9m8kSnp9/IJ+XU9LydHKtsZsU1xWK/STgoVXXaPF
        q/ZXEhhKeBYdKxrV7ys5yXZ5O6QBzBA0tIb7/vWOSkEKXNMhjb8wuUqxX/Y0Nsfw
        nN0CTNrtlFXJrO4Ux7btqjAqUnKyb/pQXAKYzxeh3DbqiuRrtfiTTx59JqGN/tux
        rtaqKD5diZqMFndrOWD8SDP7uECQ3ET0p71MvQwVuU1vaptVOarvzjw5Ew9IIfGd
        aXglVKv0xfpQnx2z56ym+JlCeIgM32OIcaMjIot6HYpNu2fF1RnoE9GMQRRrM7Xb
        OZA+KghBqgPe9bN3LNbmMlepT8orYLfwAx82QPv3V0zAw3AihPSq9RW3ydNgveG9
        Llzdz8FPii8L7WDO0SF4hc0QPvMs4aKwrYDxbTa8tQ0EF7Kj4P8VidntfzOGhWkE
        ZOM/JU2Ibpqwx94XnbJKJ7fCCruSPBjvGZV74fWnk0Q+4mQtS9u+JkLjecC0fH1p
        T2Y7skMexfnnlGlOFn8G+VS0uVaqEHTks+DMH48PfhFAtIynL8w4+GVuAm/S7/A6
        YABNM9PPYQeHUvx/Oz7FGat2+8Vfo+Kbl7IcnRSflLRQYV8USjL/nlVnDAFyTj+M
        iX6b+uKYuFyktu+L9LM2ELjqbV7To0Jez/puGlssyeg91ZX9la/8bpcM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n9TDrdILpYHs; Wed,  6 Feb 2019 23:55:41 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id A42ED41254;
        Wed,  6 Feb 2019 23:55:41 +0100 (CET)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 289B3265C;
        Wed,  6 Feb 2019 23:55:41 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 06 Feb 2019 23:55:38 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: add translations in process/
In-Reply-To: <2146324.8BP4ZdZamE@pcbe13614>
References: <20190119221341.3622-1-federico.vaga@vaga.pv.it>
 <20190120185617.44a7f275@lwn.net> <2146324.8BP4ZdZamE@pcbe13614>
Message-ID: <aa09cd3309bc9787b6ff3b1331508bb2@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-21 09:11, Federico Vaga wrote:
> On Monday, January 21, 2019 2:56:17 AM CET Jonathan Corbet wrote:
>> On Sat, 19 Jan 2019 23:13:41 +0100
>> 
>> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
>> > This patch adds the Italian translation for the following documents
>> > in Documentation/process:
>> >
>> > - applying-patches
>> > - submit-checklist
>> > - submitting-drivers
>> > - changes
>> > - stable api nonsense
>> >
>> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>> 
>> In general, this looks good.  One thing jumped at me, though...(OK, 
>> more
>> 
>> than one, but only one to fix):
>> > +Perl
>> > +----
>> > +
>> > +Per compilare il kernel vi servirà perl 5 e i seguenti moduli
>> > ``Getopt::Long``, +``Getopt::Std``, ``File::Basename``, e ``File::Find``.
>> 
>> Didn't Rob Landley go though some considerable pain a while back to
>> eliminate Perl from the basic kernel build?  This, perhaps, should 
>> come out
>> of the original.  (As long as it's still there, it makes sense to be 
>> in the
>> translation, of course).
> 
> I can have a deeper look and try to fix the original document too
> 
>> 
>> > +Modifiche architetturali
>> > +------------------------
>> > +
>> > +DevFS è stato reso obsoleto da udev
>> > +(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
>> > +
>> > +Il supporto per UID a 32-bit è ora disponibile.  Divertitevi!
>> 
>> Speaking of stuff that should come out of the original...this is not
>> exactly news at this point...
> 
> Well, generally speaking this document mix things from the past and the
> "present". Probably it requires a review.

I am having a look at this document and I am wandering if this is an 
useful
document? Clearly I see value in the table with all requirements 
summarised,
but I do not see it for the rest of the document.

So, I propose to actually rename change.rst to requirements.rst and 
remove
everything but the requirements chapter and the links.

(proposal)
Release changes probably need a CHANGELOG file, to describe new and
deprecated things.

And information about tools should be in other document.
(/proposal)

What do you think?

>> Meanwhile, here is the thing that actually needs to be fixed:
>> > +Raiserfsprogs
>> > +-------------
>> > +
>> > +Il pacchetto raiserfsprogs dovrebbe essere usato con raiserfs-3.6.x
>> > (Linux
>> > +kernel 2.4.x).  Questo è un pacchetto combinato che contiene versioni
>> > +funzionanti di ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` e
>> > +``reiserfsck``.  Questi programmi funzionano sulle piattaforme i386 e
>> > alpha.
>> Even in Italian, I believe that 'Reiser" is spelled "Reiser"...
> 
> oops, your are right. I will fix this and send a V2 patch. Then I will 
> have a
> look at the original document and try to update it
> 
>> Thanks,
>> 
>> jon

-- 
Federico Vaga
http://www.federicovaga.it/
