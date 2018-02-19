Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeBSN6r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:58:47 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:43808 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750978AbeBSN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:58:46 -0500
Subject: Linux 4.16: Reported regressions as of Monday, 2018-02-19 (Was: Linux
 4.16-rc2)
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
References: <CA+55aFwDnBq9V6TVbc82DzVYpf-ELF7UcYzHuY0ei1Xjnob+0A@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <8af706ec-e1a8-fe16-e11b-6422ac845239@leemhuis.info>
Date: Mon, 19 Feb 2018 14:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwDnBq9V6TVbc82DzVYpf-ELF7UcYzHuY0ei1Xjnob+0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1519048726;0e9bee34;
X-HE-SMSGID: 1enlxr-0003BA-TT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Find below my first regression report for Linux 4.16. It lists 2
regressions I'm currently aware of.

Are you aware of any other regressions? Then please let me know by mail
(a simple bounce or forward to the email address is enough!).

For details see http://bit.ly/lnxregtrackid And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Sorry, I didn't find spare time to work on regression reporting
and related issues during the 4.15 cycle. I also have a huge todo list
after the regression tracking discussion during maintainer and kernel
summit last fall. I will try to work on that that sooner or later; that
in the end will change nearly all the aspects of regression tracking is
done currently. But that will take some time (which I struggle to find
currently :-/ ) to realize, so for this cycle  I'm continuing to do
regression reports like I used to do them.

== Current regressions ==

Debian kernel package tool make-kpkg stalls indefinitely during kernel
build due to commit "kconfig: remove check_stdin()"
Status: stalled after some discussions
Note: Shouldn't be a problem to back this one out either if it turns out
to cause massive amounts of pain in practice I guess, even if it's the
Debian tools doing something weird.
Reported: 2018-02-12
https://marc.info/?l=linux-kernel&m=151846414807219
Cause: d2a04648a5dbc3d1d043b35257364f0197d4d868
Linux-Regression-ID: 2fd778

DM Regression: read() returns data when it shouldn't
Status: Developers are looking into it
Reported: 2018-02-14
https://marc.info/?l=linux-kernel&m=151861337518109&w=2
Cause: 18a25da84354c6bb655320de6072c00eda6eb602
Linux-Regression-ID: 9e195f
