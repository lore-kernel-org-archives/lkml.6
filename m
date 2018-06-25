Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC7FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B7C255DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B7C255DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFYI0e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:26:34 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:42967 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbeFYI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:26:32 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id DE1DA34EA5D;
        Mon, 25 Jun 2018 10:26:29 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Joanne Dow <jdow@earthlink.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving unmaintained filesystems to staging)
Date:   Mon, 25 Jun 2018 10:26:29 +0200
Message-ID: <2720127.ChobgFbqpM@merkaba>
In-Reply-To: <2491cfa6-c227-9c91-6630-f56d86cd80e5@gmail.com>
References: <20180425154602.GA8546@bombadil.infradead.org> <1910962.ItDVNtUG5Q@merkaba> <2491cfa6-c227-9c91-6630-f56d86cd80e5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael.

Michael Schmitz - 25.06.18, 09:53:
> OK, I'll prepare a patch and submit it to linux-block for review. I'll
> have to refer to your testing back in 2012 since all I can test is
> whether the patch still allows partition tables on small disks to be
> recognized at this time (unless Adrian has a 2 TB disk and a
> SATA-SCSI bridge to test this properly on).

Thank you very much.

I believe the testing I did is still valid.

Feel free to include any parts of the description of the test I made 
back then into your patch description as you see it as relevant for it.

Also feel free to include my Tested-By: (probably with a hint the test 
was in 2012).

I am not sure I am ready to permanently let go of (some of) the hardware 
I still have collected, but at some time I may. I do have SATA-SCSI 
bridges. That A4000T I have here probably could be a nice Debian m68k 
build host.

Thanks,
Martin

> 
> Cheers,
> 
>     Michael
> 
> Am 24.06.18 um 21:06 schrieb Martin Steigerwald:
> > Hi.
> > 
> > Michael Schmitz - 27.04.18, 04:11:
> >> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
> >> indicate the RDB parser bug is fixed by the patch given there, so
> >> if
> >> Martin now submits the patch, all should be well?
> > 
> > Ok, better be honest than having anyone waiting for it:
> > 
> > I do not care enough about this, in order to motivate myself
> > preparing the a patch from Joanne Dow´s fix.
> > 
> > I am not even using my Amiga boxes anymore, not even the Sam440ep
> > which I still have in my apartment.
> > 
> > So RDB support in Linux it remains broken for disks larger 2 TB,
> > unless someone else does.
> > 
> > Thanks.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Martin


