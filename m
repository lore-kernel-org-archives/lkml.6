Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A799C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C772082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C772082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeH3Qvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:51:54 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:37135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728713AbeH3Qvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:51:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9DBF21801ABF2;
        Thu, 30 Aug 2018 12:49:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blade11_3918e9aa5bf2b
X-Filterd-Recvd-Size: 1901
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Aug 2018 12:49:52 +0000 (UTC)
Message-ID: <a735448b2e7b5b24079a4b6cfc6a3612996484f2.camel@perches.com>
Subject: Re: [PATCH] staging:fwserial:Fix parentheses alignment in fwserial.c
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Nicholas Krause <xerofoify@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Date:   Thu, 30 Aug 2018 05:49:51 -0700
In-Reply-To: <20180830082808.ylputgri7oit7jvo@mwanda>
References: <20180829220326.7447-1-xerofoify@gmail.com>
         <20180830082808.ylputgri7oit7jvo@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 11:28 +0300, Dan Carpenter wrote:
> On Wed, Aug 29, 2018 at 06:03:26PM -0400, Nicholas Krause wrote:
> > Fix a checkpatch warning for the file, fwserial.c that warns about
> > alignment between parentheses and the line belows code not being
> > properly aligned with each other.
> > 
> > Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Nick Krause?

I wonder if after 4 years he has improved.

> > diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
[]
> > @@ -1328,7 +1328,7 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
> >  	if (state == -1) {
> >  		set_bit(STOP_TX, &port->flags);
> >  		ret = wait_event_interruptible_timeout(port->wait_tx,
> > -					       !test_bit(IN_TX, &port->flags),
> > +						       !test_bit(IN_TX, &port->flags),
> >  					       10);
> 
> Now it goes over 80 characters and the "10);" isn't aligned properly.
> The original is fine.

Perhaps not.

