Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00062C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923DA20838
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=8chan.co header.i=@8chan.co header.b="WwbT7suy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923DA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=8chan.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeI0Nms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:42:48 -0400
Received: from cock.li ([185.100.85.212]:44402 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbeI0Nmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:42:47 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8chan.co; s=mail;
        t=1538033153; bh=1pm4y+bwewZkwnTMD11H/MPXWMI+t7VoASrMbW2MTLA=;
        h=Date:From:To:Subject:From;
        b=WwbT7suyKC/4zk5ztmle0UcOIAYHixkmoKl34PtNiLKPx6Q16nJjNv/4dgkh2iFBM
         cbqI4LcQ40AUef+yApYVnvxUEs57PqgbaDdEMgqOoT2KqA1aMHzYSh0boX0F6ariKp
         XRipTRV2Q99sZQc9CmGbBoD5hD1YTQcO5ZbrjmNZmtBhqYmsoNsEtDzIBEskDZz42d
         DG8UzlHH1K4IJ9KmRZ7mIIWTwgnbIyJtXZbD0baZRXaz/npo+wF2QO3TCMznCTuCDA
         0gy+KsYsdBc1JQNvKhCW8Q5pW43bvlUHQNVb7pzbHoOQSpn7/yTD2EyMFJdA57gMKn
         39hqUd9EIPhMg==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 27 Sep 2018 07:25:53 +0000
From:   vwdfrwd@8chan.co
To:     linux-kernel@vger.kernel.org
Subject: The software freedom conservancy has tendered its response
Message-ID: <f19ab95cd87580eabc2e5072b487bc73@8chan.co>
X-Sender: vwdfrwd@8chan.co
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software freedom conservancy has tendered its response:
http://sfconservancy.org/news/2018/sep/26/GPLv2-irrevocability/
http://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4


""
"The GPLv2 have several provisions that, when taken together, can be 
construed as an irrevocable license from each contributor. "
""

It cites:


           " That license granted to downstream is irrevocable, again 
provided that the downstream user complies with the license terms: 
"[P]arties who have received copies, or rights, from you under this 
License will not have their licenses terminated so long as such parties 
remain in full compliance" (GPLv2§4). "

However this is disingenuous

The full text of section 4 is as follows:

""
   4. You may not copy, modify, sublicense, or distribute the Program
except as expressly provided under this License.  Any attempt
otherwise to copy, modify, sublicense or distribute the Program is
void, and will automatically terminate your rights under this License.
However, parties who have received copies, or rights, from you under
this License will not have their licenses terminated so long as such
parties remain in full compliance.
""



The "You" in section 4 is speaking of the licensee regarding 
sub-licensees, it is not speaking to the licensor/copyright-holder.

IE: if the licensee loses his license, through operation of the 
automatic-revocation provisions, the sub-licensees do not also lose 
their licenses.

IE: The language is disclaiming a chain topography for license 
distribution, and instead substituting a hub-and-spoke topography (all 
licenses originating from the copyright holder, not the 
previous-in-line)

GPLv3 added a no-rescission clause for a reason: the reason being to 
attempt to create an estoppel defense for the licensees against the 
licensor. You will notice that Eben Moglen never speaks on these issues. 
(He preumably is aware of the weaknesses vis a vis the US copyright 
regime.)

Section 6 further clarifies the hub-and-spoke model:
""
    6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.
""

The memorandum posted then goes on to a discussion of estoppel, 
detrimental reliance, etc; noting that users may have relied on the 
software and their licenses may be estopped from being revoked from said 
users since doing so might cause them unanticipated loss. This is 
speaking of already published, existent, versions of the program used by 
end users.

The memorandum seems to ignore what happens to "upstream" once said 
project  receives a revocation notice. Thought it may be possible that 
users of a published piece of software may have defenses to license 
revocation, the same is not true regarding the rescinded property 
vis-a-vis future prospective versions of the software nor of future 
prospective licensees of said software.

That is: once the grant to use the code in question is rescinded, future 
versions of the software may not use that code. Current users of the 
software may be-able to raise an estoppel / detrimental reliance defense 
regarding the current published software, however the programmers 
working on the next version of said software cannot continue to use the 
property in future versions of the software (such would be a copyright 
violation once the gratuitous license is rescinded by the grantor).

Additionally, prospective-licensees, once the grant was rescinded and 
such was published, would have no same-such estoppel defense (not being 
user-licensees at the time of revocation).

(Ignoring this eventuality in the published memorandum, is, of-course, 
by design.)
(Now, to note: the free-software movement is focused on the freedom of 
the user, not the progenitors of the software, so one could certainly 
say that ignoring some developer-focused analysis is consistent with 
their prerogative...)

