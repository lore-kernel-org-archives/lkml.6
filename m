Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937B7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3823120843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3823120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeIZRaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:30:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZRaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:30:22 -0400
Received: from theta ([88.75.240.18]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MCs9W-1fwI8W0ysS-008qZ8; Wed, 26
 Sep 2018 13:17:44 +0200
Date:   Wed, 26 Sep 2018 13:17:59 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Pavel Machek <pavel@ucw.cz>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-Id: <20180926131759.0559e68feed5d2a982990a08@christoph-conrads.name>
In-Reply-To: <20180925151406.GB2933@thunk.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
        <20180919081812.020f19e3@lwn.net>
        <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
        <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
        <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
        <20180925112832.GA10951@amd>
        <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
        <20180925151406.GB2933@thunk.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t0nxFC+mHr5ORWTHimw+eZZhJsECC0qtic6YsNZE+E34dvFhZZN
 qW3gvCUKJyKATIIVvNXEfYyYqPA26T2d0s5ar320TPCY0CeqTU6IVbBm8ylPSQKwZZION7q
 vjxITXZczGclV4+Q59Pqt9lWUUUeWRGSVaiKfW5FdclGLg4tfCsi6lGRPJDp1N1oqCiD3p1
 YnEHCrsZ53wjaflDg5X2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f4L5MzVzndg=:mvPM5TAnQ0ujDQUo1qy8+9
 fVVTZddxdBQ1WGoWsbRzZMa0glpjrJ8hg0faxrxXt1cULxQ+RhzJGeouow2sc4LP4SUH1CHPR
 1rnC83z990akzlTb5esTLQxwXcyUknBB6iL2ttZz5d+tZgxcBrBv/XrKD6EuSqM4Q5x+0+b1F
 77twYFcZOWkHjWNNgsrFJ86M6v2wHG0QOHMF/aZiqSW74bJ9opOp6gxxT+saWvzU65T/nFegy
 0t9p+Q+rQBQy1o+vGJ0TgiumJRpdMUd5QAf6MZkvrDShNHpHl3FGMdOncjrxWPctdcgz7f+h0
 nwGDtZRQYDDEp1S6OID8fZgOpcPDJBmXZ2Ja3qtvhHa38H0K3kToYdT5k/xjmt2TBS/7rrr8z
 LfiA7wy8otvuIkdevfkk7w0SlSUwefV8+OoB83PdksXO9xFvlRjl231DoKxHDdz2Do0OqsWH4
 zBNOayBNVCfHKBOzRbuA8Elq+212VDqBwxhrn28tUBHjzqWJty+id/yTn6nMubWZ+sE9TLlks
 8Kn+MGY1J66yFsL8wuNRz8AI4A0c+4Cv4NQ/6oIU4HbnWuxByKei7UM+hY/wEGD4BteFbxmxg
 KhPNDG67NWrf94JZVOGSqZ4YH2RMThNaznIS3sYDocPSM03kkdJCs2SU2JbMhFyNoQDxoI+5a
 ATsCWBvEecQy5khKQvW6bg1yBanY+4hS62TV1JsJZklo0V4infVmmL4CTYNcsXNam3gzKEV4M
 /AOMgvY7WN/33Pd8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > The CoC is a political document:
> > https://web.archive.org/web/20180924234027/https://twitter.com/coralineada/status/1041465346656530432
>      ...
> > Here is the author's post-meritocracy manifesto:
> > https://postmeritocracy.org/
> 
> There have been those who have characterized the GPL as being more
> than just a license, but also a political statement.  And yet, many
> projects, include Linus, use the GPL without necessarily subscribing
> to all of Richard Stallman's positions, political or otherwise.

for clarification: My statement above that the CoC is a political
document is not my opinion but a succinct summary of the content of the
tweet linked below it. Here is the full tweet:
> Some people are saying that the Contributor Covenant is a political
> document, and they’re right.

Subsuming both the GNU GPL including the views of the Free Software
Foundation (FSF) and the Contributor Covenant CoC is grossly negligent:
The GPL is a set of rights and obligations with respect to software but
it is indifferent to the behavior of the developers whereas the CoC is a
set of rights and obligations for developers but it is indifferent to
the goods developed by them.

The GNU General Public Licenses are agreements on rights and obligations
when executing or depending on certain software. The only way to be
influenced by the GPL is by using GPL code or by licensing one's own
code under the GPL. If you strongly disagree with the contents of the
GPL, you can avoid it by developing your own software and by not using
GPL software.

Most importantly, the FSF and the people supporting and promoting the
GPL do so in part by creating high-quality software themselves, see the
list in reference [1]. Some of the most important packages on a
_GNU/Linux_ system were developed by or given to the FSF. I looked at
the list mentioned above and stopped counting after I had found 19
pieces of software that I am actively using on a regular basis
including Bash, binutils, gcc, libc, and gtk+. Did you write your
e-mail with GPL-licensed Mutt, Ted?


With the Contributor Covenant CoC, you have all of this turned upside
down:
* It is irrelevant what is created by a group of people.
* It applies to everyone almost always; if you never contributed to
  Linux kernel development, you can still denounce active contributors
  to the TAB for behavior that *might* be considered inappropriate.
* There is no project whose quality, productivity, or success grew after
  introduction of this CoC.

Reading the CoC, it is plain obvious that the good created by a
community is of no relevance to the CoC.

At the same time, the period of validity of the CoC is almost unlimited:
It applies whenever a person interacts with other developers, and
whenever she represents the project, and whenever her conduct might be
deemed inappropriate.

The CoC is also almost unlimited in its scope of application: It applies
when insults are uttered, when language is not welcoming enough, and
when statements might be deemed inappropriate.

To enforce the CoC, an organization has to introduce its own
prosecution: There is an investigative board, the TAB, which is obliged
to handle reports of CoC violations confidentially and the findings are
presented to the maintainers which punish community members based on
these findings.

The CoC has never improved any piece of software and it drives away
core contributors:
* The fifth most active LLVM contributor Rafael Avila de Espindola left
  over a CoC that is more tame the Contributor Covenant CoC [2].
* Node.js developer Rodd Vagg was almost removed from Node.js based on
  undisclosed allegations [3]. Node.js Technical Steering Committee
  members were not at liberty to discuss the allegations with the
  accused [4]. Later, a third of the TSC members quit simultaneously
  [5].
* Long-time Drupal developer Larry Garfield was removed as developer
  because of his personal preference for BDSM [6]. His views were "in
  opposition to the values of the Drupal project" [7]. The Drupal CoC is
  in spirit similar to the Contributor Covenant CoC [8].


> The use of GPLv2 does not magically brainwash all of users of that
> document to blindly follow its author.  The same is true of the CoC.

The Ruby developers refused to introduce the Contributor Covenant CoC
[9] and this led to a thinly veiled Twitter attack of the CoC author on
Ruby chief designer matz [10]. You will not be brainwashed by the CoC
but a Twitter goon squad will be waiting for you.

In summary, your comparison of Richard Stallman's lobbying to the tweets
of the CoC author are inappropriate. Your comparison of the GNU General
Public License with the Contributor Covenant CoC is an insult to the
FSF.

Sincerely
Christoph Conrads


[1] https://www.gnu.org/manual/blurbs.html 
[2] https://lists.llvm.org/pipermail/llvm-dev/2018-May/122922.html
[3] https://github.com/nodejs/TSC/issues/310
[4] https://github.com/nodejs/CTC/issues/165#issuecomment-324798494
[5]
https://www.zdnet.com/article/after-governance-breakdown-node-js-leaders-fight-for-its-survival/
[6] https://www.garfieldtech.com/blog/tmi-outing [7]
https://dri.es/living-our-values [8] https://www.drupal.org/dcoc
[9] https://bugs.ruby-lang.org/issues/12004
[10]
https://web.archive.org/web/20180917225801/https://twitter.com/CoralineAda/status/690334282607378432
