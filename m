Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049CAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB0C21473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB0C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHOWEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:04:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeHOWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:04:14 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65E57BDB;
        Wed, 15 Aug 2018 19:10:48 +0000 (UTC)
Date:   Wed, 15 Aug 2018 21:10:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Joachim <svenjoac@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815191044.GA23260@kroah.com>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <e675976b-c23d-5bee-0583-cf241033d02f@dd-wrt.com>
 <CA+55aFyZz5jahQvHPjZebyfRNsZTP0+_0rm3tUR_2k6D26bzYA@mail.gmail.com>
 <30ded8f9-5949-52db-7ef2-763b0e7a4abf@dd-wrt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ded8f9-5949-52db-7ef2-763b0e7a4abf@dd-wrt.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 08:33:30PM +0200, Sebastian Gottschall wrote:
> 
> Am 15.08.2018 um 20:26 schrieb Linus Torvalds:
> > On Wed, Aug 15, 2018 at 11:22 AM Sebastian Gottschall
> > <s.gottschall@dd-wrt.com> wrote:
> > > btw. i found another compile error with x86 :-)
> > This should already be fixed by commit d0055f351e64 ("x86/smp: fix
> > non-SMP broken build due to redefinition of
> > apic_id_is_primary_thread").
> > 
> >            Linus
> 
> Hello Linus
> 
> unfortunatly there are numerous other non smp compile issues. this patch
> covers just one out of 3 found so far

Do you have patches for the others?  Non smp builds are pretty rare
these days :)

thanks,

greg k-h
