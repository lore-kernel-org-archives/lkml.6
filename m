Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A844C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B112C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B112C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJQHAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:00:41 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:49631 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbeJQHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:00:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A1AE8100E86C5;
        Tue, 16 Oct 2018 23:08:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hole90_28c1654e88d5e
X-Filterd-Recvd-Size: 2277
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Oct 2018 23:07:59 +0000 (UTC)
Message-ID: <d00fec12b481f17ce6e844d86be56b5f12bdb0b1.camel@perches.com>
Subject: Re: [PATCH] staging: iio: ad7280a: Lines should not end with a '('
 - style
From:   Joe Perches <joe@perches.com>
To:     Giuliano Belinassi <giuliano.belinassi@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Oct 2018 16:07:58 -0700
In-Reply-To: <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com>
References: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
         <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
         <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(There is a linux-usp@googlegroups.com mailing list
that bounces when I reply, so I removed it from the
cc list)

On Tue, 2018-10-16 at 19:48 -0300, Giuliano Belinassi wrote:
> Hello,
>     Thank you for your review :-).
>     Sorry, but I am a newbie on this, and now I am confused about my next
> step. Should I make a v2 based on your changes, or do you want to submit
> your changes?

I wrote that to encourage you to do more than
what checkpatch says.

I just moved code around and reduced duplication.

There are many similar opportunities for code
refactoring in staging.

You could test what I wrote, add a good commit
message with a subject like:

[PATCH V2] staging: iio: ad7280a: Refactor <functionname>

with a commit message that describes the changes and
perhaps shows the object size difference using

$ size <old> <new>

Maybe add a Suggested-by: tag if it pleases you, but
what I did is trivial and I think it's unnecessary.

Are you doing this for a class assignment?


