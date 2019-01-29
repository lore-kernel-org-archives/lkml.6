Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB05C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416DC214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="zW//EIhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfA2Jia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:38:30 -0500
Received: from cock.li ([185.100.85.212]:47344 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfA2Ji3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:38:29 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548754704; bh=u8BBeBkvAhGOvEEsF13WXdHow9crP1XhfDVD0rOAlL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zW//EIhzM/kp4Q8T5lTOQU3/4L8NFKxjJfOkXK84KdSSPm5mn4XEzr3rtTU/9pjcV
         gXHgccD5uaGWe3kUAjzQpd0bHc7KwbR/mgdsAJZDs2Eeazgelynh769WW5LqOvalap
         sqVmZYGUlusuVKyXoqKppSShCVPtR4vV00iqbHLmj6Q/RTIRau3Lb3VW06jTAPy7lt
         GqK0kD7MmkmchcKBMrG5rbiHUQocypYC9xANXw1yQRxktagyBOYtwtmKhRliQuWd79
         iH2dh7JCdVi+yNLmZ1HgAfSLIrL9w/VirgxkvaUl+5eElQZbvv31Y7Txgskty4d0op
         wlHbWg6acwEww==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Jan 2019 09:38:24 +0000
From:   linuxgpletc@redchan.it
To:     editor@lulz.com, editor@lwn.net, news@theregister.co.uk
Cc:     misc@openbsd.org, freebsd-chat@freebsd.org,
        linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org
Subject: Re: Author of GPC-Slots2 promises to sue "John Doe" who violated GPL
 recission. (update 3)
In-Reply-To: <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
References: <fe8a4e103943d671ff0ce2c4f09609f9@redchan.it>
 <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
Message-ID: <d0af58324910b1c75d7d4e5185ab03ee@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some updates (3):

http://8ch.net/tech/res/1018729.html



Anonymous  01/29/19 (Tue) 09:23:25 No.1024608

>> 1024606

https://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4

Sorry lad.

Anonymous  01/29/19 (Tue) 09:25:16 No.1024609

>> 1024604

> Cites previously anonomyous paralegal woman from online rag

> Ignores published lawyers who are men

(Paralegal woman stopped talking after she would outed)

Anonymous  01/29/19 (Tue) 09:27:15 No.1024610

>> 1024608

Sorry, they published that "clarification" after I raised the issue, and 
their "clarification" is bullshit.

Guess what: The FSF doesn't make the law.

Quick rundown:

Section 4 of the GPLv2 states "parties who have received..."

The "you" here is the licensee, it is not the grantor (See Section 0 of 
the GPLv2 "Each licensee is addressed as "you". "). It is not applicable 
against the grantor of the license: it is a rule the licensee has to 
abide by, set by the grantor, in-order to have permission to modify or 
create derivative works at all.

About the printer driver case: The contract in that case is the 
preliminary writing, the offer to do business ("pay us, or alternatively 
follow the GPL"). The acceptance of that contract by following the terms 
of that preliminary writing (choosing the GPL instead of paying). That 
is why both contract and damages under copyright are available. Damages 
for the contract portion ("pay us"), or damages for violating the GPL 
license.

The parties later settled out of court. The key is that the businesses 
offer created two alternative means of acceptance of it's offer to do 
business: pay for the commercial license, or follow the GPL. So the 
court allowed the biz to recover the lost profit.

Anonymous  01/29/19 (Tue) 09:29:15 No.1024612

>> 1024608

Sorry, read a book *, not a publication by interested parties that was 
debunked 5 hours after it was published. 
https://lkml.org/lkml/2018/10/26/420

* 
https://www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876

Anonymous  01/29/19 (Tue) 09:34:06 No.1024614

>> 1024604

>> 1024608

Cites idiot self-sure* paralegal woman who doesn't know her ass from her 
elbow, and who went silent after she was outed, plus a publication from 
an interested party that was immediately debunked.

  (*is there any other type?)

Vs: Cites published lawyers well versed in their field.

Explains why interested party's publication is bullshit immediately once 
aware of the fraudulent advice.

Anonymous  01/29/19 (Tue) 09:36:24 No.1024615

Notice no response to >>1024602

Just a change of tactics.
