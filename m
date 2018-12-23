Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F702C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B6F222A0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="al8IvKV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeLWQBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:01:39 -0500
Received: from cock.li ([185.100.85.212]:51532 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbeLWQBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:01:38 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1545580894; bh=t8Dba8FSnTQOsyVL0PSNlneqXJzWm0kvjqzVrwsXduc=;
        h=Date:From:To:Subject:From;
        b=al8IvKV/TrrxD/viLg+kSCpgkh3HZlijYFFy3RcforiG/wmiaIBmqUDKbRPvx1Tba
         NcyfI643dxxPxWkyXL/p8yOqEszJFOOJb80OkjKrAza0S2dhWHjthXlaQ2hAszSAVp
         YyEN4Lf/nkOX3HeFxAAe3ZcYji2H9TZgBi7hlutzLOWjw9tXHBe21kriFeBm+46bXB
         fyVH3m9zE+J61CNUHzOSsSvJKM39y34dzWcyoOAA3woumKCWJ8x+Zx6zV94oqSyrnB
         igHkdp+x08uzQYWZ7BljP4w4B6P7gbvWTDgMiMkjCAZ9KoiINh6G9pcp5sbD1gIEtB
         w/LdL7mjZ7SCw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 23 Dec 2018 16:01:33 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel@vger.kernel.org, esr@thyrsus.com,
        gregkh@linuxfoundation.org, rms@gnu.org, bruce@perens.com,
        bkuhn@sfconservancy.org, editor@lwn.net, neil@brown.name,
        labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
Subject: Reason for RedHat purchase 30 pct over market cap (and some thoughts
 on Bradly Kuhn's recent public denouncement of RMS)
Message-ID: <21b1f9c4cd33320da680a6b5efc54837@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redhat has achieved "governance" over the Linux(TM), via systemd and the 
Code of Conduct.

You, contributors, are now treated as employees.

They are confident that you will not assert your property rights, since 
you attack those who do (See: Netfiter saga), and take it as an honour 
to sign documents pledging that you will not assert your property rights 
(prepared for you by your now-masters).

They know that you are psychologically bound to behave as hirelings - 
servants, and not as property owners.

Thus they can rest easy knowing the ground is, though made of sand, not 
in seeming danger of a tempest.

Because of you.
Because of your history of supplication.
Your enuich-like nature.

A nice example is Bradly Kuhn's recent blog posts 1) Excoriating RMS and 
2) showing how he himself is submissive to a woman he hired.

He's even angry that others still treat him with respect rather than 
transferring all the good will to the female figurehead everyone is 
supposed to now respect (for what reason? No, being an actual programmer 
is not required: sufficent is being a member of the "better" species 
that rules over the males under the anglo-american system that Bradly 
Kuhn and his kind uphold )

If I were them I would never donate another cent to the SFConservancy, 
and I would seek a claw-back of the funds that I did donate for improper 
use (yes this is possible under both California and New York law). 
Especially since they seem to have no in-house lawyers what-so-ever (so 
what is their purpose?).

We are supposed to be proud that his mind is as innocent as his visage 
(perhaps why he had to hire outside counsel to give him an incorrect and 
abundantly couched opinion)


[1] 
http://ebb.org/bkuhn/blog/2018/11/22/gnu-kind-communication-guidelines.html
[2] http://ebb.org/bkuhn/blog/2018/06/21/everyday-sexism.html
