Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579BA208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579BA208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeIQFsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:48:33 -0400
Received: from smtpq1.mnd.mail.iss.as9143.net ([212.54.34.164]:53658 "EHLO
        smtpq1.mnd.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbeIQFsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:48:32 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 01:48:31 EDT
Received: from [212.54.34.117] (helo=smtp9.mnd.mail.iss.as9143.net)
        by smtpq1.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <rene.herman@gmail.com>)
        id 1g1hKK-0005i2-D1; Mon, 17 Sep 2018 02:23:44 +0200
Received: from 52499ff3.cm-4-2c.dynamic.ziggo.nl ([82.73.159.243] helo=localhost.localdomain)
        by smtp9.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <rene.herman@gmail.com>)
        id 1g1hKK-0005vS-Ah; Mon, 17 Sep 2018 02:23:44 +0200
From:   Rene Herman <rene.herman@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
Date:   Mon, 17 Sep 2018 02:23:42 +0200
Message-Id: <20180917002342.15342-1-rene.herman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
X-SourceIP: 82.73.159.243
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=TeciSiYh c=1 sm=1 tr=0 a=1WNebpHDdbXTIQ7tA6On8w==:17 a=x7bEGLp0ZPQA:10 a=dgzHxJTjTkEA:10 a=JBFolyDoGHsA:10 a=D19gQVrFAAAA:8 a=tqvuGgrUkmh1B3wMKO8A:9 a=W4TVW4IDbPiebHqcZpNg:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

I was "around linux-kernel" some 10 years ago and still to this date
sometimes check e.g. lkml.org where I happened upon this; felt it hard
to resist commenting on one specific bit...

Whereas you concentrate on net-positive effect on code quality of an at
times "crass" communication style, I believe there is or used to be an
actually larger net-positive on community: the very fact that you as
project leader feel/felt free to sometimes tell people off is and is I
believe widely taken to be a sign that the Linux project leader still
considers himself part of the community; is anti-hierarchical in that
sense, and as such a large positive for a community a significant
majority of which would not have (had) it any other way.

Now, Linux has of course long outgrown its hacker-beginnings; I would
expect that by now an overwhelming majority of developers is part of
a corporate hierarchy anyway and therefore not themselves free to respond
to you "on equal terms" even if they were personally inclined to do so.
The above may hence be somewhat obsolete in reality -- and I'm also
sure that this is for you more personal than for someone like me reading
it on LKML(.org), but hearing you describe your style up to now as
_wrong_ still feels quite, well, wrong.

At the very least historically it wasn't, and it if is more now it
at the very least still reflects quite positively on honesty and
openness.

Rene.
