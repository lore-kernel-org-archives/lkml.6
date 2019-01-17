Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD8820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="xYQJ9MI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAQS7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:59:17 -0500
Received: from cock.li ([185.100.85.212]:56678 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfAQS7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:59:17 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1547751554; bh=qEe90IUm6+Bd6IXL/YWzX3ayRknawBL0c2/ak0eJIcc=;
        h=Date:From:To:Subject:From;
        b=xYQJ9MI/s1BJ0bkklo+50q/5Zp0Pvx5gQLQDzie9m4dGNFaMpZcxIrnTQowduB12c
         PuK3clRbtRcOW4s0HGDGf1g7fxYHZ2ChTae1dFPcoc9BiFGvWZccMO15fNJEyr69y2
         UpIeBZ4WAKDtvpuNTqZYilhPGySt0LjsCy7ehlOBBy/axRZ2iwDvRfwbRCmC9NgKwx
         j9pVOHnw3rK6oFTX6mAN97YuMuRTwL/A0pKREXHuiqfECu5kRzoTSCQgZvUJAQoWoa
         ksPBDnYx9JXkmWqbQl2M5OcTFbQmHaCYfmnyeH2q4EELVzuiHTqKvpXgdrtoSnw9TG
         I6scLb/GOwJZg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 18:59:12 +0000
From:   sicevar@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: GPL revocation (GPC-Slots2): Alex "Skud" Bayley,  Leigh Honeywell
Message-ID: <5829834612f57b1604fd9ee8f5c167c3@redchan.it>
X-Sender: sicevar@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quote:

"
> Then you should have used them.
Not necessary, the language used in the press release identifies them 
easily.

> should
As if I somehow can't just rescind using their names either.

License to use/modify/etc the GPC Slots 2 code is hereby terminated for. 
Alex "Skud" Bayley, and Leigh Honeywell.
(Note: this termination is not to be construed as a lifting of the 
previously issued termination regarding the "Geek Feminism collective", 
this termination is an addendum)

--MikeeUSA-- (electronic signature :D )

>> 1019403
Their response is irrelevant.
"

Discussions with author of program involved:
http://8ch.net/tech/res/1013409.html
http://8ch.net/tech/res/1017824.html
http://8ch.net/tech/res/1018729.html
------------------------

https://slashdot.org/submission/9087542/author-recinds-gpl

------------------------
p46 "As long as the project continues to honor the terms of the licenses 
under which it recieved contributions, the licenses continue in effect. 
There is one important caveat: Even a perpetual license can be revoked. 
See the discussion of bare licenses and contracts in Chapter 4"
--Lawrence Rosen

p56 "A third problem with bare licenses is that they may be revocable by 
the licensor. Specifically, /a license not coupled with an interest may 
be revoked./ The term /interest/ in this context usually means the 
payment of some royalty or license fee, but there are other more 
complicated ways to satisfy the interest requirement. For example, a 
licensee can demonstrate that he or she has paid some consideration-a 
contract law term not found in copyright or patent law-in order to avoid 
revocation. Or a licensee may claim that he or she relied on the 
software licensed under an open source license and now is dependent upon 
that software, but this contract law concept, called promissory 
estoppel, is both difficult to prove and unreliable in court tests. (The 
concepts of /consideration/ and /promissory estoppel/ are explained more 
fully in the next section.) Unless the courts allow us to apply these 
contract law principles to a license, we are faced with a bare license 
that is revocable.
--Lawrence Rosen

p278 "Notice that in a copyright dispute over a bare license, the 
plaintiff will almost certainly be the copyright owner. If a licensee 
were foolish enough to sue to enforce the terms and conditions of the 
license, the licensor can simply revoke the bare license, thus ending 
the dispute. Remeber that a bare license in the absence of an interest 
is revocable."
--Lawrence Rosen

Lawrence Rosen - Open Source Licensing - Sofware Freedom and 
Intellectual property Law



p65 "Of all the licenses descibed in this book, only the GPL makes the 
explicity point that it wants nothing of /acceptance/ of 
/consideration/:
...
The GPL authors intend that it not be treated as a contract. I will say 
much more about this license and these two provisions in Chapter 6. For 
now, I simply point out that the GPL licensors are in essentially the 
same situation as other open source licensors who cannot prove offer, 
acceptance, or consideration. There is no contract."
--Lawrence Rosen

------------------------
> David McGowan, Professor of Law, University of Minnesota Law School:

> "Termination of rights

> [...] The most plausible assumption is that a developer who releases 
> code under the GPL may terminate GPL rights, probably at will.

> [...] My point is not that termination is a great risk, it is that it 
> is not recognized as a risk even though it is probably relevant to 
> commercial end-users, accustomed to having contractual rights they can 
> enforce themselves.

