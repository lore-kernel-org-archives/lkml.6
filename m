Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-3450219-1525816296-2-990037230431840411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525816295; b=C5wZ/FhvWjoJm+QTZl5YEib59zMDN8hpruURMbQPjF9cuzciRT
    nYzp7Np+iLq4POwfqWpSCWr3AXQj7n4xstussDsZIRjo3UAVcTrNrBypbh47ITCI
    4l81TQ+DNWiu2+wF686MuvGYpKKtQsV2QCAiKWmow/r16VnQU3PUq3svQTORa19P
    X4GPHR3InNdefRlnDtp9IBzpfck5DbKFICdpFE2jLwHTywNwoeLyLkoSuCpBbJQf
    bFopE6ckFG7KmXmSWxRJChi9jjttZohz836sFPN6uB+frK7sRWOTc+B6USBD0Ymj
    i+wlkGesAbWQxStNVvOxbaJ5Hzz6x65T1AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525816295; bh=8sZW2
    WX/wYIaSHEnrvZqJAcapH/HgRGNZMOZt+aOozk=; b=UNOyMcP8e5UgXxNIeDvaj
    yZl5xxdMMrh88KQzN9XP1GrqXGPbS75XZUysUZI5lij4e/mjctXO2IZSVBzpd1P/
    tO/1sGJjxOoh9GIQ6xvrEOkka77GoeWZ0yR9yv13BLl6UqyCcLBE5yfJJgQ/za7o
    kWSrtz6TMaYXDxL5IgYITr3xX7vaDQzofBY2zQPlsnZuDyxA+2P4xPoliiyxDR76
    yQV9lyvgsQcx/+yKndIfWjYpXvdtv9uCb2skFzR0Kp9V4dfdhk/MoMwxy+s2WpRf
    9umW3U30821HF+CQq2mtkTvbNFQM9YOEYqBsKcBsmlK9cKJMboviT+6JnhMpxtkG
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=wtUHaXLx
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=NNdck+mr;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=wtUHaXLx
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=NNdck+mr;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIrF12oaqgIqGMZynZq2QSZDycpd5BkwUPC6cz8/XYCf8Ot5iwKivPywtQVvXSZHBq4nlQEVWfI7LusSpT8yJ0cd0P7sNxN+GgTyYMvrGuHp0OfM/n4J
    JvSaaq5ukVoUb3aBExXE1KPbGEj95miCncYl7ByHieFUjDo3tx6vx8pX9xPnLVDFJfJmKim3WFkvSFRyvarkywq+vTGLve37glKYJVdGRH+sxodJrRHMlW5d
    LHd+eRz6U0fc6b19xf9LRQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=wCXprHnjtRepXGjx8sAA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZq3kLrOvb3dMpNxMptVa2NT6Cq+H0VOd+t4ZT45NldopXM7iUyI320Mfy1StDd8jZDPmZ0rDj/Seb29m2sLcdY=
MIME-Version: 1.0
In-Reply-To: <20180508214339.GE8514@sasha-vm>
References: <20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
	<20180508202912.GC8514@sasha-vm>
	<CAFhKne-aDcMKD8FjfROGZ-=ffmq3Xa+7n0dm8uvzKJ_7WO-qCQ@mail.gmail.com>
	<20180508205505.GD8514@sasha-vm>
	<alpine.DEB.2.02.1805081357451.31825@nftneq.ynat.uz>
	<20180508214339.GE8514@sasha-vm>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 8 May 2018 14:51:18 -0700
Message-ID: <CAPcyv4jTmvYDz=2Fc1HmopqK1R=eNjCvbqT3VCkeC8VEwNjjnw@mail.gmail.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: David Lang <david@lang.hm>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, May 8, 2018 at 2:43 PM, Sasha Levin via Ksummit-discuss
<ksummit-discuss@lists.linuxfoundation.org> wrote:
> On Tue, May 08, 2018 at 01:59:18PM -0700, David Lang wrote:
>>On Tue, 8 May 2018, Sasha Levin wrote:
>>
>>>There's no one, for example, who picked up vanilla v4.16 and plans to
>>>keep using it for a year.
>>
>>Actually, at a prior job I would do almost exactly that.
>>
>>I never intended to go a year without updating, but it would happen if
>>nothing came up that was related to the hardware/features I was
>>running.
>>
>>so 'no one uses the Linus kernel is false.
>
> My point is not that "no one ever uses Linus kernel" but that no one
> takes one of those kernels and plans to stick with it for 3 months until
> the next one comes up, even if there are updates relevant to that user.
>
> Yes, some users will use a .0 release until either Greg releases a
> -stable, or until the next -rc is out.
>
> What I'm trying to say is that there is that the .0 release makes some
> people rush poorly tested commits in it even though the .0 release is
> not significant in any way.

I think we should take pride in our releases, so I disagree that it is
insignificant. If a maintainer is rushing things into late rc's and
breaking things then they need that feedback, not de-emphasize the
importance of ".0" releases. Could the bar be raised higher on late
fixes, perhaps. I otherwise think the message is already clear
"changes at -rc6,7,8 had better be worthy of and coming in late and be
accompanied with good explanation".
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
