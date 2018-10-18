Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EEFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE85A2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="Id1BtKqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE85A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJRObS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:31:18 -0400
Received: from cock.li ([185.100.85.212]:59214 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbeJRObS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:31:18 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1539844306; bh=F0pEJ0Nhvoec7kGwrCUbaykg40SorDKEJL5kGqUZmhs=;
        h=Date:From:To:Cc:Subject:From;
        b=Id1BtKqY3kOVXHfPJwBeuNcvO2sTKFyk4xDJgLr2A87R1zLxAzVwA7CiW75JDrXPr
         8LfxaOYtZgGtWw9ZtufFPCzH3/S9SYhExuVx+d/yUmvo10VjPLPG6fAujw4Hdh7F3m
         pTD3Z+oLyM0liFsuvRR8hNHgZX56JZ65yBmHTYPD8HZpBPwp+vgZM8YR8Oq0/61YE6
         Ou/GdFmb7UmVF0EqfPMGg7rSBkgqpgUoMw80qR5JOPe+4hjYdCX2+n/jKYOJdSio7A
         wwMxI8DhHWxFoCzXNMjIv40kQznKUtQLHv/niST/om8FAe56QglZWw2gdqCYmu2/16
         9uy8U+sQtDJsg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Oct 2018 06:31:45 +0000
From:   visionsofalice@redchan.it
To:     rohit@thelawfirm.io, contact@grsecurity.net
Cc:     linux-kernel@vger.kernel.org, legal@lists.fedoraproject.org
Subject: Bruce Perens, inconsistent statements regarding Copyright, GPL, Open
 Source Security.
Message-ID: <f1841eb0d494dc32f09c40a120f55e75@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a prior public statement, Bruce Perens put forth a legal theory where 
users of a certain piece of Software would be liable for contributory 
copyright infringement*[1]. This statement, specifically the 
pronouncement of such damages reachable, is predicated on a pure 
copyright License theory regarding the grant under-which the Linux 
Kernel is distributed and modified.

* 
(https://perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/ 
)

As we all know, under a contract theory, damages are quite limited 
regarding opensource licenses** (See the initial district court 
determination of Jacobsen v. Katzer) and the legal theory published by 
Bruce Perens, if analyzed under a contract theory regarding the GPL 
would become a less-than-likely scenario.

** (For this very reason, the FSF specifically drafted version 2 of the 
GPL to avoid language that would tend to induce a contract reading 
rather than a bare license construction. The FSF has maintained for 
decades that the GPL is a bare license and is not a contract)

It is just that utterance, added by Bruce Perens, regarding contributory 
copyright infringement damages reachable vis a vis the GPL version 2, 
that induced upwards of 70 of Open Source Security's clients to cease 
their business dealings with Open Source Security.

Bruce Perens has recently made known, publicly, that he currently 
believes in a Contract theory regarding the GPL version 2, specifically 
regarding the Linux Kernel. He has stated that he, infact, in the past 
has supplied expert testimony praying to the court for it to find that 
the GPL is, in fact, a contract (and not a bare (copyright) license). He 
has stated that the court has indeed relied on his testimony in various 
pleadings. ***[3]

Here, ( 
https://developers.slashdot.org/comments.pl?sid=12767438&cid=57489528 ) 
Bruce Perens argues that case law has overridden the esteemed Raymond 
Nimmer's opinion that the GPL is not a contract and is, at best, a 
failed contract, and likely a bare license akin to a property license. 
Bruce Perens further clarifies that it was his very own testimony that 
has convinced the court that the GPL is infact not a bare license and is 
instead a contract.

If these pleadings were to have occurred prior to the theory published 
regarding Open Source Security and its Contributor Access Agreement, 
that would put the lie to any suggestion that Bruce Perens in fact 
believed in the theory that he published at the time of publication and 
would instead suggest that rather than proffering his opinion regarding 
a matter - he was instead intentionally publishing a theory he believed 
to be a lie in-order to harm Open Source Security - A goal that has 
indeed been effected (specifically by the "Contributory Copyright 
Infringement" addendum).




*[1]
-------
https://perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/
Posted on June 28, 2017 by Bruce
Warning: Grsecurity: Potential contributory infringement and breach of 
contract risk for customers




***[3]
-------
https://developers.slashdot.org/comments.pl?sid=12767438&cid=57489528
-------

Re:Who gives a FUCK about Nimmer? (Score:2)
by Bruce Perens ( 3872 ) <bruce@perens.com> on Tuesday October 16, 2018 
@09:10PM (#57489528) Homepage Journal

If lawyers were never wrong, we'd have no need for courts. Which means 
they're wrong half the time, or at least the adopt unsupportable 
arguments half of the time.

Case law has overridden him on the GPL question, thanks in part to my 
pro-bono testimony. But courts and lawyers still take him seriously. And 
me, sometimes.

-------

In response to:

> Who gives a FUCK about Nimmer? (Score:0)
> by Anonymous Coward on Tuesday October 16, 2018 @08:30PM (#57489396)
> 
> Who gives a FUCK about Nimmer?
> 
> He said the GPLv2 was "not a contract" - was "at best" "a failed 
> contract" - "has no consideration" - and thus it is a bare license 
> revocable by >the grantor.
> 
> Free Software has REJECTED this CLOWN Nimmer.
> Thus he is wrong.
> 
> http://illinoisjltp.com/journal/wp-content/uploads/2013/10/kumar.pdf
> http://oxwugzccvk3dk6tj.onion/tech/res/987076.html
> ...
