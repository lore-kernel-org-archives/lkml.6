Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22106C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 00:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E379E2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 00:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBKABq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 19:01:46 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:45769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfBKABp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 19:01:45 -0500
Received: from mailone.linux-pingi.de ([217.245.111.188]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M72wZ-1h1U212qMB-008b9B; Mon, 11 Feb 2019 01:01:38 +0100
Received: from [10.23.200.0] (pingi.linux-pingi.de [10.23.200.0])
        by mailone.linux-pingi.de (Postfix) with ESMTPSA id 3285972005;
        Mon, 11 Feb 2019 01:02:13 +0100 (CET)
Subject: Re: Linux 5.0-rc1
To:     Paul Bolle <pebolle@tiscali.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
 <3578229a062d10331dd0b8cfabe4b59a10e4ad2a.camel@tiscali.nl>
From:   isdn@linux-pingi.de
Message-ID: <02380226-636a-ced5-bcd4-950ff01583e4@linux-pingi.de>
Date:   Mon, 11 Feb 2019 01:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3578229a062d10331dd0b8cfabe4b59a10e4ad2a.camel@tiscali.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ThGh/jcTnfyLaYvIBjX9yNlfExpwfjt3MybUATghZvjuCjzayXv
 UcUj+qJOejX3M3a2Eb/kMvyimnmV++qIWigKAgdbJeOCFfBTEN2weRokq9wUSDKiy6ST/NS
 kGYFMe1deVwRa3bgzIzsOyT3OeqKwBDo3DjMO1aol2RcBjnwv+0rL4WrkLGIwj2RkKPpnzK
 79zWs72TEcYEfk2MrH4Tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dAg0saJSz5k=:4PLUDVBhw15JNUU6bFrhdO
 n5rHYWBuM0/BHGMTDLW0qWsqu/sqYsclNywthT3Q9Vg7oZ2APGLy79MFRneGQlGxohRLOz6Jx
 P78O9xIPxEYfrNwaEQ/pqB38nuJYGVW8JgdGuUQkQa8oDJAnBejXQ1bwfIqgyGw/sE00zbQzU
 IRMQiUhky/qug7OEjtk3hTPIz7IBVhVTgfNYjhU56cb1zoyFmiNoSQyLOlO1DP1gXhHhz9GaT
 Qs2GqdtVvRWufQ738771SDViAJo0Mh7WcRsKUh0wh6dLxv461l37M1t2D1yNMQ4F5eUe8CcGY
 FCBNRGFZ321CjYvvEZ//Im6Ni77/AD4o6yDulUVVILhG4xMhCdCuIiiFrfdqSoQD+e/T94Jz1
 bwD2PAb+niAEBskDrFgW6wYYYGP/cKsWMONBCKFgduT/RsWRO4r2IAWMr99akMoXKU1TXZpf4
 Er1CW0Qvdmt12rFqx6jfBg0EYy5SzV+iGQn9+eATk+CC13j5Ss1t/K89SPhK0TkgWn/0F0TEw
 g0uAoFqnfxtfNeaoOocRkf7cPIv+kXizf11qywoumg6abiYgR8K7sx83VcaeN1/QO9NpJexEo
 xHAupYX/gR/5ThRzd7S90ljP1wIzBwwEH1rqqqbCJpKrn69rkTeUlLyd4RNrhLSCoXx9ABF2O
 NhxIQbj3cF9UcW1Gp2Va3T1y/FGEatv6+sayoGJKxlGJMBqQTyfgM4cVtfTBRZng6EYkFjTfm
 3gawV5HLv74Zz6TmV/lNjIww9z3FWLvCJRWu02vrrhAqiwDmkGdPK5N64v4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Am 09.02.19 um 20:42 schrieb Paul Bolle:
> Linus Torvalds schreef op zo 06-01-2019 om 18:14 [-0800]:
>> Nothing particular stands out, although I do like
>> seeing how some ancient drivers are getting put out to pasture
>> (*cought*isdn*cough*).
> 
> Just to let people know: the gigaset drivers will get my palliative care until
> a few weeks before September 1, 2019. Because at that date the Dutch consumer
> grade ISDN network (the "BRI" part of ISDN) will be shut down. So expect a
> patch to remove me from MAINTAINERS sometime during the v5.2 cycle.
> 
> That leaves just Karsten Keil to look after all the ISDN drivers. Karsten's
> last activity was in 2016. See commit 1e1589ad8b5c ("mISDN: Support DR6
> indication in mISDNipac driver"). Which is also the last commit apparently
> resolving an issue noticed by an actual _user_ of one of the ISDN drivers.
> 
> Perhaps Karsten could tell us whether there's any point in keeping the ISDN
> subsystem in the tree after September 1, 2019, and if so, in what form. I'm in
> no position to properly answer that question.
I still follow the kernel ISDN  patches. I very glad that Paul, Kees,
David and others handle everything without the need to jump in. I still
have some ISDN equipment running behind VOIP lines.
I do not think that here are so much direct users of BRI ISDN left, I
known only very few, but here are at least some.
mISDN is still used in embedded routers to emulate the classic ISDN S0
bus to use ISDN equipment on Internet based lines and last designs for
this usage are not so long ago (less a year ago, I know from questions I
got).
But of course ISDN is in palliative care and finally removing it is
maybe not a bad idea now.

Best
Karsten

