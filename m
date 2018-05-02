Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-945659-1525275169-2-13252112079916225161
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
    1525275168; b=AhaOtx7m16cB3hgJ3wVq5pVLPt0EYZXF87Fl1EvToJsY3cqU0y
    b5xnpovL2p6iEQ4CDF71QQCfEGclPk2kgD56G27ZxGygodG4El9LnZYQd+mm13YP
    7yCFMfUiXGNM+9OdfCOTm6NkSNh/BkNkU5D5fIeO+t2txeyvUf7tvh4b2jor7aBY
    L/AQOBGugtmPzWMcHMC0pO+p3vea3mCODbrBc3RaAjMk+I9tV83XIf4wDBZ5tH7X
    4293/N5rEZycS1oeStj9nPbYS669PhsZVuSDlpeMnaXW2MU7Gj5WG3c4b7Gycnsr
    UVv+yD5vFpW90srtwBZhoXp1tYvfoywOXKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525275168; bh=a+bF5
    NEmCgEmSBmLS16Ssf9bP6NTOWr/yv+9oO9BMPQ=; b=cZijLBJGFoC84Bn0qZTbw
    4JSrGVEaUE8KIUDhMHJUUkx8aBXYIN75zAMg7Yt+fqDvccZRO885LcQEsWwvRGZP
    24tQjZfu12fhUMn/5oeF+4bS1vPs15BvNhsuc1auzEN/qXDlk/xyIRpQO6pOFc/T
    e+Pi7cbfhtOwGNhsRyPZjmnjbI2KO1UgAW1+tn3YG5liXSwPVF7HAdqyx5X5tCLT
    rz5xyf1C6dkQEXtjkbZoRupTtE8/cqOPauEMYGu/KGPXoJEak6K2P5QzXDW59ChU
    Qgh32xf9WPgtQylpgB6PJ9/fQWGWyVfJCYhlUHLxi1UejApW2FYvaTAU0G7oqRKr
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=gwZpmYel x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=V0EM6SXt;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=gwZpmYel x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=V0EM6SXt;
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
X-CM-Envelope: MS4wfEHvLvVjE0c7wXF57DdQlfCOg5bEdg5+fgWvPrii7ThPSq2jT/I4D00NW8SJ7yOisrRh7biL7D0cFiQtRtTZ/hc8jrDoRrggSpcfAFCx7BnNs6tqFzm8
    CIw2OrTEGoaIVSFxRdukp5WDjT0fMaCKxZ4LOeZpEHKrjQd4BKXxdnzZtWR0/8LCiwd704AXiKHySup+dgGKrYPjKJOWo0KG2QAQotvlNpPC52QvAqAfCWwq
    1r+FTvny9uFt6kuCXGFewA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=tBb2bbeoAAAA:8
    a=ag1SF4gXAAAA:8 a=uOzsrhemMssQ0ScqTuMA:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZqfXpeTn+47lD4y5tWxX3s8kxS5nLxvy8jdXM9tV1S1l/9DOkv9SlZ38y2oTA/ePjZRWXJa92eE03E7vOjJHiI=
MIME-Version: 1.0
In-Reply-To: <20180501163818.GD1468@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 17:32:37 +0200
X-Google-Sender-Auth: yKZcbUhrD1nFSbexT65tVjo71_I
Message-ID: <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
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
