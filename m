Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D311FECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B43C206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B43C206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIWUsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:48:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeIWUsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:48:25 -0400
Received: from theta ([188.102.175.194]) by mrelayeu.kundenserver.de (mreue002
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MFDEx-1g12la3Zql-00GHSj; Sun, 23
 Sep 2018 16:50:37 +0200
Date:   Sun, 23 Sep 2018 16:50:50 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     Edward Cree <ec429@cantab.net>
Cc:     unconditionedwitness@redchan.it,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-Id: <20180923165050.56674786772aaa0985f5ba53@christoph-conrads.name>
In-Reply-To: <a9db544f-db9d-d6c4-67d8-43db2eb591fc@cantab.net>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
        <20180919081812.020f19e3@lwn.net>
        <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
        <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
        <20180920041846.GA4418@1wt.eu>
        <206423b0a199c1f12e61364d6e687e09@redchan.it>
        <a9db544f-db9d-d6c4-67d8-43db2eb591fc@cantab.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YGb875kx0ioqGHdmcXFFuouQEAkz4wj9UsyGAqZ/0MYstgziF4g
 9NXZQ/aFI0qh1RyGMkrc7QtbGIec9yLeMdxDHfkuZT9p4fKOlYLCWGQf/pfgeRhgILMh+tB
 YniWWt1s2W0Ls3DHGttddhOlHWGfQqLWYtnhK+JtUyFkilNxNM89V0CQSBeO+V2OIOlhCml
 9p/UWFvpJWBuSaLk13gwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a2l75YPFg30=:ejgF2Cxbb3a4BeDO+ATB/F
 +Z11/hLoLZoXKyG0o4HKvZUvlf6xGKsQi+jiBx+uRPBaWNlDjpnQt/zhogwyMBlWA/ni1PtSi
 YOp61+VjmA7DL8YSMydtm6eR9pUKuWBLKXFkgnUTESTbET1V7BwnR85e0SUr4z1TKKcIWFdAm
 2VJrWMbapHVnNUX03YFUJerH1lmQyoLZ3qvx5NKRJevxNgJPaYejffNGUzJk4U09g0VNbb6ST
 GzwlfNpUY/6JVIjpwWOKOHfYMaOwRTUXezm4syXpd3gH8s/zKN+5wS0NayjRqY+JMnsOMaBu8
 PwfjMVA/Exf4MNhQGhfi/LQmD7VIkO7X5TA8j+fRYutAMtnODc8SSq5o/ed/wKO29KK+nbrTn
 lb9E22P6LmSK/03he8gZY7T0PbzDhGbfr+9D8U/qfNT8hDD94mZPFgDtsBWgCbbi6j+k34gAm
 MYMaNk681WUVb/k4q0AX3U0C78Xw7EptBG2/OwjKpCuq/tjt8FUkpseGXtDmARq/XdrjnSWQs
 rld6rzslavkD1byWvvrAMoDTueM18Iwvbm5OQwEoTCh7Vey5ihgdiMuoB3JVPF5jSbY2vUZaH
 0Sa8JtaD+2x8Z/s5Gk1nRwXMO9mWpk0bQv0mAL3n8D60hSQNfHHauzCTduG3IZs/V4xiYo9qF
 4BhyZWBCigxPQpqqY85IRnMvLigrZqhrCAoUpB0EjWgpEwdaKFctWWkNsk5fCKkD3naNn3ECi
 kGASzZs095x0q6+A
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Edward,

> I know others have already said it, but:
> This is legally nonsense.  The only way I can revoke someone's rights to
>  my code under the GPL is if they violate the terms of the GPL.

this aspect of FOSS licenses has -- to the best of my knowledge --
never been tested in court. Actually, the Free Software Foundation felt
compelled to clarify this point in GPLv3 and there is a thread on
StackOverflow acknowledging the possibility of revoking a license [1].
Finally, revoking the license may very well be possible in some
jurisdictions but not all of them, e.g., Australia [2]. There are 195
independent states in this world and I do not think you can make such a
broad claim if it has never been legally contested before.

By the way your e-mail is violating the code of coduct.

> This is legally nonsense.

You are not empathic towards others and respectful of differing
viewpoints. 

> In short, "unconditionedwitness", please shut up.  You're not helping.

The comment is derogatory if not downright offensive.

[1]
https://law.stackexchange.com/questions/832/is-a-copyright-license-by-default-revocable-or-irrevocable
[2]
https://web.archive.org/web/20091024034824/http://www.ilaw.com.au/public/licencearticle.html

Sincerely
Christoph Conrads

On Thu, 20 Sep 2018 23:57:15 +0100
Edward Cree <ec429@cantab.net> wrote:

> On 20/09/18 10:27, unconditionedwitness@redchan.it wrote:
> > Contributors can, at any time, rescind the license grant regarding their
> > property via written notice to those whom they are rescinding the grant
> > from (regarding their property (code)).
> 
> I know others have already said it, but:
> This is legally nonsense.  The only way I can revoke someone's rights to
>  my code under the GPL is if they violate the terms of the GPL.  If I
>  were to do so otherwise, then _I_ would be in violation for having
>  distributed derived works of the kernel without a GPL, not to mention
>  the obvious reliance/estoppel problems.
> 
> Moreover, even if I _could_ revoke the license, I wouldn't want to do
>  so; it would be ridiculously petty in itself and the precedent it would
>  set would be destructive to the entire open-source community, about
>  which I care deeply.  It is _because_ Linux and other open-source
>  projects are so important to humanity that I spoke up about what I
>  perceive as a threat to it.
> 
> In short, "unconditionedwitness", please shut up.  You're not helping.
