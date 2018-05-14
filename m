Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-519562-1526287229-2-2222766558785109693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526287228; b=WZ9q7xVrfhWGtjMNTw2zaddLG6PTddkJTjp416qv7in8i350zw
    pUNybvhaPrlKs7KPOiGMniofXcUgHHUe4H2DN1O8HQFNYMuY411UcXZPmejPHyVM
    Qw6g4Ixmqb3WYav8YHMgBKAD4yO2P4TUq6MSCYPakPWzmVrgMawiZUJQp/kQY2jL
    T1sxBf3J96+BOzXkzRlCutB28M8mZzJUyzMf0XXLLIPYyV27xrDofED1asMNUfmy
    IAk9SZitbKRIv3DG0FMcDE9xp1whEJkkwEVSvZZuVScGLZOoCFFLEB63oyivRpxY
    iKQahqAOn79lUQxW9QCy4/PjVbSfdbzVYfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526287228; bh=InbgS
    adQi9nrELm4ALgZHGw9L0A6PsofOQKFZ6XVOdE=; b=O9MlpNL+TDNB0xuIpFMsE
    HgDUHwUxEyp0yjZASF/5605MiByFhSh2jZKjP6JFxVBjk48Z538OYOmfOAUPYh6K
    UAGcIR8Qowe7ehundFZcGxhXG72CX2QFUJJUPmBDZ+hcnhvYY+IYgyRImIXu0m55
    uK8Cq1jXs/E5L4M+jI0Ff6BTl8EQLAamBMkxk3GmhDSPrQdHTYFGJ/EaTb3jYVjP
    ZPWdyNn6Jh1402J6HjC4pXvqB5iUTjElvlosNnyAggRA+EbHaoe4ku3HnGtgbSNj
    VtMXJSWCa0oKG3sS4AQK/bM+ipIsm4KQmkuhZlsJ5UtStk1gdhFGI3DsRwEKMhON
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=AyL9mW1K x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=nEFy3hC7;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=AyL9mW1K x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=nEFy3hC7;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAJjKtZuTf4DBt3LnQBCxlgirbfmcr1ZtgJUnDQN+ezpQZFmF0nozKqTxceF/Esl13ch/553d5MXIqrDwEKo6eenAZj3bRKkSQsFLaPkZ6fEPCo3DVuz
    fQ3r6ES8DcEgCiMuM+tcZPt0fnasUpQof3y6D/vZe3jeDC9hHNcuVnRC8nVqxfvfjmwGnJorf0CovGlr9KteKB/cqv9XjiOb7lnAwPheEDfIty0k4SWIBJO/
    8lMEFecH1W28WBPvQP7g8w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=P-IC7800AAAA:8 a=tBb2bbeoAAAA:8
    a=yMhMjlubAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=ag1SF4gXAAAA:8
    a=m0UzyB_5TSSWBd9akEgA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=Oj-tNtZlA1e06AYgeCfH:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZoKdf64jUGNOGjkAsIO+h4pCuJl8ynQOmbAhIR/S8PrpFDpIFV3SFcmcd6tZowaZiure8/3g0acpBd8cp19+u8=
MIME-Version: 1.0
In-Reply-To: <20180514103428.55285a70@bbrezillon>
References: <20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
	<20180510164722.GH8514@sasha-vm>
	<CAMuHMdWDNjsba29id4Svjy_tauKivWDUixub3qf82Nx_6rYueA@mail.gmail.com>
	<CAMuHMdUHK=kmJB-=G-Y7YEneZityMzi5YZ3nJFD6uCs61bOaiQ@mail.gmail.com>
	<20180514101237.5df1e0d7@bbrezillon>
	<CAMuHMdWQTOioXPmWX+_jetECpp9=SCK_BfWq9kJ7xj3WTnB_ng@mail.gmail.com>
	<20180514103428.55285a70@bbrezillon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 10:40:10 +0200
X-Google-Sender-Auth: fB5kAFAc_uZh9jX4O8wS-EksXT0
Message-ID: <CAMuHMdVwA6jK1fPu3Dzc4-+_kWv1yTNvOGJP811Fdyrrnbc18w@mail.gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris,

On Mon, May 14, 2018 at 10:34 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon, 14 May 2018 10:29:04 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Mon, May 14, 2018 at 10:12 AM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Mon, 14 May 2018 10:00:30 +0200
>> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> On Tue, May 1, 2018 at 10:00 PM, Sasha Levin
>> >> <Alexander.Levin@microsoft.com> wrote:
>> >> > On Tue, May 01, 2018 at 03:44:50PM -0400, Theodore Y. Ts'o wrote:
>> >> >>On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:
>> >> > What's worse is that that commit is tagged for stable, which means
>> >> > that (given Greg's schedule) it may find it's way to -stable users
>> >> > even before some -next users/bots had a chance to test it out.
>> >>
>> >> I just noticed a case where a commit was picked up for stable, while a
>> >> bot had flagged it as a build regression 18 hours earlier (with a CC to
>> >> lkml).
>> >
>> > Also, this patch has been on a tree that I know is tested by Fengguang's
>> > robots for more than a week (and in linux-next for 2 days, which, I
>> > agree, is probably not enough), and still, I only received the bug
>> > report when the patch reached mainline. Are there tests that are only
>> > run on Linus' tree?
>>
>> Have your received a success report from Fengguang's bot, listing all
>> configs tested (the broken one should be included; it is included in the
>> configs tested on my branches)?
>
> Yes I did (see below).
>
> -->8--
> From: kbuild test robot <lkp@intel.com>
> To: Boris Brezillon <boris.brezillon@bootlin.com>
> Subject: [bbrezillon-0day:mtd/fixes] BUILD SUCCESS  fc3a9e15b492eef707afd56b7478001fdecfe53f
> Date: Mon, 07 May 2018 20:05:52 +0800
> User-Agent: Heirloom mailx 12.5 6/20/10
>
> tree/branch: https://github.com/bbrezillon/linux-0day  mtd/fixes
> branch HEAD: fc3a9e15b492eef707afd56b7478001fdecfe53f  mtd: rawnand: Make sure we wait tWB before polling the STATUS reg
>
> elapsed time: 49m
>
> configs tested: 142

But the failed config (m68k/allmodconfig) is not listed?

BTW, my last report had:

    configs tested: 178

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
