Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB21C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8B021708
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="o8IOBBCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8B021708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI1IJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:09:32 -0400
Received: from cock.li ([185.100.85.212]:60042 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeI1IJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:09:32 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538099294; bh=9aXct+ALQBUmBiwRrUvcNJTC2TfIdB2yPivql9ltWSs=;
        h=Date:From:To:Subject:From;
        b=o8IOBBCsHJ30IbW1F4/oDHACkIhDNcEsbhKsuN3KnysYkIQAO8C8Hu2qWbsgpmWl1
         3oHimw9UUjliV2iO+faU71OSdSZZtvaKw7F1Amf3+sIhmWpVucDwrMUsNpSmTuouU8
         vlrCx2IAtMmi1kg8XxGWJ8zkU2UadTw2ogNCnM63pOxqf8Fp0VpvACNu1Xv9+3b/r5
         R0WkfWHWeA6SuMDlEKnbMW88UoUIK/FVHXzlNqYEv/pBWUngzmcK958do9maMKfviT
         V/A0Y8Tzi2KhUf7rYsKdEvE+YOOkYIhHY5XToXgt4jQjLI73EGu21MCWLsCEHuCz19
         8qeOLxcc7Opzg==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 28 Sep 2018 01:48:13 +0000
From:   vweforwd@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: (Response to SFConservancy) Under US copyright, permission regarding
 a GPL version 2 licensed work is revocable by the grantor.
Message-ID: <4c1939793441dd244379db27c25a94dc@redchan.it>
X-Sender: vweforwd@redchan.it
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



_
