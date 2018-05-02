Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-945659-1525275181-2-5540118728225446780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525275180; b=mEtaJ/A0WXq3zk4uSuN8S54Wv9DnPOlj6Aowws8YTeAK665vVv
    gUdsXob/VrcbioWyI0yBgswc+NX1UGJz7/4X8+/J54I4nfjfhBP3ZQiFBGJ4FNWi
    ISuWRE7HiDmw9hE8uf39j8xNtn3CRPyC13QUV11ycnKm2T9UIKGbZgH/h2R2Hx5d
    XGNNbTMffzAkAcZ7zrmJ0HodOFQ5YbLcGhmBMW1U+r6LTQSOo2u0pEVSXIyqI/DU
    efBmFsjvSIhgQeQtnoUwEISlAw9LlIhZ+hnLuF1J2p6k/O9/fX8tPcbMNV+nfdT2
    GCr48FFHaJPI/pZ0onc2t/AVnD5pJbbxY0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525275180; bh=a+bF5
    NEmCgEmSBmLS16Ssf9bP6NTOWr/yv+9oO9BMPQ=; b=Q8/9ONGeTX7L4N8o47TBw
    FOuNXBsxPs9SV+MimEYGNEuoGVF+96MmbYcUtJLa8eU2ETkaLJOt5QITzE9YmmWb
    aPLcdtBwUiB6BZWuQg3INxyUxt4TI/GgVwZYBUzg8zbnQ7A1ntdy4VYdJb9xzcwK
    of3kB7FoyaXWU52qDsT3NE+5IbzygK4F6veUZY57ELQhuPQ9Hh9vqZqVkvjJ55ty
    aL23gqPiQFX2jvz2spLjRZQzGhmZyD8TijuCDNOiCnsHdtFFmO6vv41Wn8pJFoh9
    0q97E8yMh2GHz5OQik+FkB/wGTJYY78Zou54ZIt96CqGKpUDocBrKoE43BSR63wj
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=YcYoanBN x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=lXdCt4EK;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=YcYoanBN x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=lXdCt4EK;
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
X-CM-Envelope: MS4wfOYiCxN5y3fApGnb23G5QoSNW9nQZQhXIHceVAnB9d5dkxcGyzOVC8ho+3ej4GST+rSc5LfiGCGBXhoEMSww38KUoqEbGYWXh9EHhfzwT3RRnilpKvPK
    mSjrdXLkWV05JG3t5GUQ57czWmX3oZxbZIcNJg2oNGeZnkjYn65IFMhOZ6rbhw26Fv6Ww9X2ceZbV/ybId1fZ+d4pdbxzJgJSVh1jl4zfBR/WXFkqBDQDsDh
    B/ChbhKE7yFLx3j7C4TpLQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=tBb2bbeoAAAA:8
    a=ag1SF4gXAAAA:8 a=uOzsrhemMssQ0ScqTuMA:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZr+uNluorhf5UOvNsYrHJ6a4TcLA65+kWg0Dd0DKWXHfRfcV7RLd0nwJLl9lgTBVMJLKCcEaCIWZRWaViUkmt4=
MIME-Version: 1.0
In-Reply-To: <20180501163818.GD1468@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 17:32:38 +0200
X-Google-Sender-Auth: feKfOLjKYh0z9IeaM_OjQb1mTUk
Message-ID: <CAMuHMdW7dzsfwBr3fAZADA9NK4osuHqMDvXvN+MrV4u098vbAw@mail.gmail.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
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

Hi Sasha,

On Tue, May 1, 2018 at 6:38 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> Working on AUTOSEL, it became even more obvious to me how difficult it is for a
> patch to get a proper review. Maintainers found it difficult to keep up with
> the upstream work for their subsystem, and reviewing additional -stable patches
> put even more load on them which some suggested would be more than what they
> can handle.

Thanks for your work!

>  - For some reason, the odds of a -rc commit to be targetted for -stable is
>    over 20%, while for merge window commits it's about 3%. I can't quite
> explain why that happens, but this would suggest that -rc commits end up
> hurting -stable pretty badly.

Aren't more -rc commits targeted for -stable because they are bugfixes?
Ideally, new features are supposed to be merged during the merge window,
while -rc commits fix bugs.

So they can be categorized like:
  1. Plain -rc commits,
  2. -rc commits fixing a bug:
       a. in the same release cycle,
       b. in a previous release.

2a assumes the bug was backported to -stable, too, doesn't it?

Do you have statistics for which categories are most buggy?

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
