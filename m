Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC7C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD5420873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD5420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeG1HZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:25:17 -0400
Received: from nautica.notk.org ([91.121.71.147]:44925 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeG1HZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:25:17 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DB8C9C009; Sat, 28 Jul 2018 08:00:00 +0200 (CEST)
Date:   Sat, 28 Jul 2018 07:59:45 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        piaojun <piaojun@huawei.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: About the V9fs-developer list (Was: [PATCH] 9p: fix multiple
Message-ID: <20180728055945.GA16684@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL-pointer-dereferences)
Reply-To: 
In-Reply-To: <5B5BBFCE.50002@huawei.com>


(Re-added Eric, ron, Latchesar to the recipients and removed a few
others to make v9fs accept this mail without moderation, sorry Thomas &
others)


TL;DR: should we move the list, and should I send a patch adding myself
to maintainers?


piaojun wrote on Sat, Jul 28, 2018:
> I could not recieve the original patch. Did the patch CC v9fs developer
> maillist?

Yes, but as usual there were too many recipients (I removed some like
you did previously), so the patch is probably queued for moderation
somewhere.

For this specific patch, you can find the original message here from the
lkml archives:
http://lkml.kernel.org/r/20180727110558.5479-1-tomasbortoli@gmail.com


(Or more generally for patches I say I've accepted, my current process
is to push them to my 9p-test branch[1] then once they have been tested
push the same thing to my 9p-next branch[2] that will be taken into
linux-next; this is already in 9p-next now :
https://github.com/martinetd/linux/commit/49fd386d1e67d7876770d46b57359c6891d4cb70

[1] https://github.com/martinetd/linux/commits/9p-test
[2] https://github.com/martinetd/linux/commits/9p-next

I always check that linux-kernel@vger was in copy and insert the Link:
tag as appropriate if you need to reply)




In general though I'd realy like to bring up the subject of this mailing
list as I feel it's been a burden lately.
I'm not even an admin of the list so I feel a little out of place here
but should I go around snooping to ask if we could make a new
v9fs@vger.kernel.org mailing list and abandon the ship here?

A second question that's been on my mind lately is if I'm going to be
gathering 9p patchs from now I should probably start considering sending
a patch to add myself to MAINTAINER.

I've had a quick look at the file though and there aren't many
subsystems with 4+ maintainer (breakdown if I can count: 1301 with 1,
342 with 2, 104 with 3, 31 with 4, 4 with 5, 1 with 6 and 10
maintainers) and more to the point I also think having too many
maintainers is a nuisance, which is why I've been reluctant to add
myself.

I however don't want to forcefully remove anyone either, Eric has been
somewhat active with three messages in may at least, and Latchesar akced
patchs this past year as well (September but still within 12 months) so
he's definitely still reading these emails a bit...
That being said, it's not like retiring from maintainers means one won't
be able to look and comment at patches, just that patches will get less
recipients and might go to through to the list more easily.

To be honest I wouldn't care at all if the list worked well, but in the
state things are in it's easy for me to miss a patch unless someone
redirects it to me like Greg did recently.

There isn't any hurry, but let's discuss this and move forward.


What do you three think about this?
What do others think?

Thanks!
-- 
Dominique Martinet
