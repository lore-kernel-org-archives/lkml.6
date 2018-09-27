Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD30C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B119215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B119215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeI0RRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:17:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:17:02 -0400
Received: from theta ([94.223.172.118]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MDyoW-1fvYOY3Z6y-009uLp for
 <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:59:18 +0200
Received: from theta ([94.223.172.118]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MDyoW-1fvYOY3Z6y-009uLp for
 <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:59:18 +0200
Date:   Thu, 27 Sep 2018 12:59:35 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct, more attacks on Ted Ts'o
Message-Id: <20180927125935.71e8c92285c1122e334d49e7@christoph-conrads.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VU2Eowv9I2FBvkrXKarAxm55mJOqyTJmKQxmU02u/bBJCD/WuA6
 OkJjrqf/IPV183sVbz6ma8Mg1Lc21oXvjM9pLS7b8iixVfaM27viw6kb0CegCorJOcpMu9+
 QDhs0Gc0ZHhL1tmchgOF/Ap8wqBI7zOFDw1jgnvLrpei6b31VvJtB8JncsNX3sVfbc2nGPI
 JyMz2XlLVWK00EYeU5eOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nlDILLSIsxc=:x2C0O7KYms87KCMr8GGyWz
 5gZyBPcliU9viTQNOBmsS2nH5wgABzg40YeR2qpadqIAKbprtuu6g5cJWd9KoCKqAJ2JBfj9a
 sK7VwEXvtjFi2m5qSDU2eH1n7QGlr3uQIF1cTM6YpH0ABG3xqWJ44d3H51LD653hNM8rPKnLC
 4IDPkB9eMR7JRemyODhnoJ8/SfdmrUsRuFuYPXYL90XOtCSCZ7I6nqAFHQ+jfHCOqRoVlTXsR
 XUpNvi4dp3ry8ZPwKMTxuApx4TGh6iBzCkgmwpsw6A+ca5UMi8FV/zzTaRPX6ocQfT8Fxdsop
 +XYtDiMc7IAGwszA1Q1ctPvct9wfYeMPD/+uX5UlMWC7Npb/YMDRoUmf3qVUpkZaDtT424qZy
 1n8hVtSoWyY+eC+ZpmiIdBs+NY200uYMn93TaHOs4rDVMZ0Q8KdkF21USzt+fMCBOmezZLQb5
 y5MzWZEgCobH6crThqjRcH8HfUpQR+Qc4y5vk9UD0p8oC1imk1gtClnKqBuvNFQ4pO4+Fsa+3
 zaoXyreNEGFETs33lqEr63mKT+8dKca1ChYMUJ1tsAWrj6OmaR9XCFBpy/XZ0l05b63v+v0Gz
 ZwVW2rRlzemduc9WGrHzULoCUt6t598V79EJVKcXKzhqO18v175u0Nih4zKhXzaktXyEjXP5X
 Ph8oGS084dQ4UtSfD5ZApjmsZVWjJxbGm4cl6YocTH7Z+99nz3D24h076ehwFCmroMMrZvw7q
 XzkrNZz+cujfca0C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But I'd like to bring to your attention
> the following Twitter items, which I haven't seen mentioned in the
> messages.

> [Context
> 
> https://mobile.twitter.com/_sagesharp_/status/1042959402712657921
> Sage Sharp @_sagesharp_ · Sep 20
> My statement was "I don't want Ted Tso reviewing Code of Conduct cases
> involving sexual assault or sexism." I did not make a statement asking
> for him to be removed from the board.
> ]

Sage Sharp was formerly known as "Sarah Sharp". She is used to be the
maintainer of USB 3.0 and had an argument with Linus Torvalds
about his conduct beginning in 2013. [1]

> [Valerie Aurora "co-founder of the Ada Initiative", outright states
> Ted Ts'o should be fired and more.]

Since 2012 she states that Ted Ts'o should be fired [2] based on
e-mails from him [3]. Matthew Garret archived the whole thread in
question [4]. Currently, Valerie Aurora is looking for former Linux
Foundation employees [5]:

> Torvalds also fostered a cult of personality whose central tenet is
> that Linux will fail if Torvalds is not its leader. In this system,
> Torvalds has little incentive to stop doing anything he enjoys,
> including verbally abusing other Linux developers.
>
> [snip]
>
> Here’s what I suggest: Linux Foundation sponsors should demand that
> the Linux Foundation release all former employees from their
> non-disparagement agreements, then interview them one-on-one, without
> anyone currently working at the foundation present. At a minimum, the
> sponsors should insist on seeing a complete list of ex-employee NDAs
> and all funds paid to them during and after their tenure. If current
> Linux Foundation management balks at doing even that, well, won’t that
> be interesting? 

She later tweeted [6]:

> So where are all the disgruntled ex-Linux Foundation employees?
> Working with the walking PR disaster that is Linus Torvalds should
> have people lining up to complain to reporters, and at least 4 senior
> people left in 2016

This text was retweeted by Matthew Garrett. He also called Ted Ts'o
a rape apologist [7].

The Ada Initiative was able to raise more than 80,000$ of donations in
2011 [8] and in 2012 [9] allowing the members to work full time for the
Ada Initiative. The list of donors includes Adobe, Google, Red Hat, and
Microsoft, all of them members of the Linux Initiative [10]. (Microsoft
is a LF platinum member.)


For at least six years, these people have had an axe to grind with Linux.


Sincerely
Christoph Conrads

[1]
https://www.infoworld.com/article/2989588/linux/linux-is-sarah-sharp-a-social-justice-warrior.html
[2]
https://adainitiative.org/2012/10/25/open-source-software-open-to-all
[3] http://geekfeminism.wikia.com/wiki/Rape_apology_on_LCA_mailing_list
[4] http://www.codon.org.uk/~mjg59/ted_mail/ [5]
https://web.archive.org/web/20180921164106/https://blog.valerieaurora.org/2018/09/20/something-is-rotten-in-the-linux-foundation/
[6]  
https://web.archive.org/web/20180927103830/https:/twitter.com/vaurorapub/status/1042597545313153024
[7] https://mjg59.dreamwidth.org/18505.html [8]
https://lwn.net/Articles/449315/ [9]
https://adainitiative.org/2012/10/29/10000-matching-donation-challenge-from-sumana-harihareswara-and-leonard-richardson/
[10] https://www.linuxfoundation.org/membership/members/
