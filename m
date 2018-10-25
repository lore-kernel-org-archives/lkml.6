Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3336FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628E92082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="oDsIhHBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628E92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJYQ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:28:05 -0400
Received: from cock.li ([185.100.85.212]:53760 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:28:05 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1540454187; bh=Uzm0dFFOaK8MdxuCZlDqb6YXO51vKeoGZtUE6C9OJo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oDsIhHBSqONSs8Bc1Fej+uk9vOJkxyz08cRUNdQFkwtfVINZWW4iR+VifTNA1+L/R
         bwonDzXmlh3dp9YeHDQjeMajQhCqWyN7+g5tnkgpJ6wbw0eJXiq4kZWDpvrtpHd14f
         1M1ZT0fetOMbLk/0HvixXM+jNeA1FXf49+lmiuXLUHOcOKcc5HopqnfVzrWBXBDdIn
         ztfeda+6i37xxBK/pCObt+BZO7ThOfSDtGU6LvsxO8slU6fIftMXbhd+3m3Y3+U1c1
         ayP9bCX9CGAZltKPy0fu5byCNYwJE/7NsT3tfVjDtL+pr6k0/nN+VqDEx9H4j+sZ4o
         FyA3KODT/m5dA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 07:56:26 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     rms@gnu.org, bruce@perens.com, moglen@columbia.edu,
        bkuhn@sfconservancy.org, editor@lwn.net,
        NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
Subject: The linux devs can rescind their license grant.
In-Reply-To: <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
Message-ID: <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux devs can rescind their license grant. Why don't they if they 
don't like the CoC. They did NOT give their code away. They merely 
licensed it to people for nothing. Licenses can be rescinded. The 
License text itself doesn't even disclaim the possibility of rescission. 
All it says is that those who are down stream of a violator won't have 
their license automatically revoked if the violator's is.

(No this was NOT "debunked", it's a complete lie to say that the owner 
of the copyright cannot rescind his freely licensed (no consideration 
paid) property: yes the free software people ARE LYING - but EVERYONE 
now believes their lie even though their debunking was immediately 
debunked itself. - Since none of you woman worshiping 
anti-marry-little-girls** faggots are lawyers you believe whatever 
you're told by "SFConservancy"*)

*(Who even had to bring in outside council themselves, inorder to 
conflate clause 4, having so little expertise on the subject in-house)

**(YHWH explicitly allows men to have female children as brides (Devarim 
chapter 22, verse 28 (na'ar) (same expressed in the Septuagint (padia)) 
(including in cases of a forceful taking (taphas)) (Yes, white men 
(americans, anglos) are the enemy of YHWH's law, worldwide championing a 
system that condemns all men to slavery at women's feet - the position 
they themselves naturally gravitate to)


