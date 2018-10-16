Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E921A2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E921A2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJQHuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:50:20 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:33058 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727208AbeJQHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:50:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 45065182CF669;
        Tue, 16 Oct 2018 23:57:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fire41_240796f245d01
X-Filterd-Recvd-Size: 2098
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Oct 2018 23:57:27 +0000 (UTC)
Message-ID: <5121d66be92fc2234c34f189fa86a0d929e46e0b.camel@perches.com>
Subject: Re: [PATCH] staging: iio: ad7280a: Lines should not end with a '('
 - style
From:   Joe Perches <joe@perches.com>
To:     Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Cc:     giuliano.belinassi@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Oct 2018 16:57:26 -0700
In-Reply-To: <CAEFO=4DQ7yN33VwW5evNgdMTDf1c_Sffwue_PFT_RvytJst+Bg@mail.gmail.com>
References: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
         <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
         <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com>
         <d00fec12b481f17ce6e844d86be56b5f12bdb0b1.camel@perches.com>
         <CAEFO=4DQ7yN33VwW5evNgdMTDf1c_Sffwue_PFT_RvytJst+Bg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 20:29 -0300, Giuliano Augusto Faulin Belinassi
wrote:
> > (There is a linux-usp@googlegroups.com mailing list
> > that bounces when I reply, so I removed it from the
> > cc list)
> 
> Sorry. I think this may be because my HTML mode in gmail was enabled.

No, it is because that group address is private
and rejects posts from non-members.

> > Are you doing this for a class assignment?
> Yes, I am. I am into a group that aims to contribute to opensource
> projects and we chose the Linux kernel. Our mentor suggested us to
> contribute to the linux-iio

That's fine but please tell your mentor to try
to vet the proposed patches within your internal
groups before sending them on to lkml.

Perhaps add the kernel-newbies list to the vetting.


