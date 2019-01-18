Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFDCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1895E20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="PSOlE8V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfARMQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:16:41 -0500
Received: from cock.li ([185.100.85.212]:49774 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfARMQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:16:41 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1547813797; bh=qEe90IUm6+Bd6IXL/YWzX3ayRknawBL0c2/ak0eJIcc=;
        h=Date:From:To:Subject:From;
        b=PSOlE8V4waI4AYI4Au3GkdI9oXN0NGksJX9xUgseHEmpE+YSLgJFmjCnEcjeF7/HI
         fVHs/fu5c9lsk+a3Rl35cnIzBJDop48eWpF1zydA5ka6MNw2LgvmH2+XyhrdLN22ZH
         t4jk4y9P0d2UR9TkquTkss0cB2HvsW6y2TDCZDWnUWzptHzWFB0w0I+JEeAVGPloRq
         kT1jJ8+FivJiybutndxlYqOIm4X08gCPA5F5EjhipZErDQuPRT8cOJm9Q6P+jEf+2R
         r7LgRIKy3xaDZ7SFNWLf910ttAlsKDPCAqcv4NDV9Ckh+AVS+99ZlGqZVwv+NQVJWi
         knk2a9zXoUN+Q==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jan 2019 12:16:36 +0000
From:   sicevar@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: GPL revocation (GPC-Slots 2): Alex "Skud" Bayley,  Leigh Honeywell
Message-ID: <164d2693561fa67f586909d7adb5f19d@redchan.it>
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

