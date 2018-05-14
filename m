Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526286979-2-11962084782476716947
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526286979; b=miGc5KNi/mhIGbbR02xoV2RUSQH09Hg7wmU8HO2QUBQRMpwT1Q
    7nrarP6rpUPg1XJqClR9vas2ZWhf5PhZ3DodS+pmB+E/7GU6DyiciOSvXRnZre7s
    ht2cm6hF/swyJQPNfOzbI+EpgcCJ40tMauIt5mN0vyDPTqTSuRanDOxvQFmGquOC
    jjyjlNsUy35xRROF/LkW70dUB8Md4U/ZIHrKYRya2iSmYgqi9HR40dp2XJrvcG5P
    lBxTW1RcICWd+VAJe+v8nDGpZt3ZmwAZzBZM8yOBZ6X5HmEJIKVhpyuwQDVd9uMV
    HlQ6D8tmWEafWINFDAT1trnCd3X0I7I+8WVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526286979; bh=j9zmC
    BYyVtY098ybXBjRkhL+VMBk5VOrUKmi3J6mqT8=; b=OHnuztIvWLp2pKXFTg4uT
    SMwZqgRfuXRebqqQ9WPx+Wz2aUq6UPDDZWhRbm0i9uT5SkkzBsereVg6xy5QAMLT
    gdhQgKqyDiiZKx/MDW6TQ130k7Pevkg4aKeycS3dYRn71E7szPrvvQvGwwKeja2A
    YLTlqJd+ODEWZgImMJckmt60xcga2oRfg+l9iu9wI3x4JwEu7q5tsZfbgDWLLEAV
    oP37MENMhAN0kWUApchDxuEpEeK5fuYRLJPfB1mOxTqavpzuvJJLFwEJSCBzshH8
    3dfMieAj3Ia+kdohOKCKPejsYkKto+pfwGqti++6UPcgz1nANZLYm3+IodroFJ20
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=dY/B6USP x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=DmULoUQC;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linaro.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=dY/B6USP x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=DmULoUQC;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=linaro.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNRHkrRVl0kngsoLLps7P33CEc0JIGhARUyRiJOmBq+PSFGLocdGVaego7c1IAkwoBFslQ7Tb2Njs6mkD43L6l6Ur1xgypXuHLQxPc4L6bm/loRLEBPg
    XGAIpQlQXvqnZ+C9dnPxfUJcc5SUGf1ONcCs/4u0VGdrj5zW5xYjEpSq3gPgE2khDtp+c9RbwUM9tVANqNgp0WcIjbqsjjwxkhtViirmf6EbSmQNVoa67XqD
    AZS+SoUKi8OWfev/puMnvA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=rOUgymgbAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=InFfsBCemfMe4_SdI7MA:9 a=CjuIK1q_8ugA:10
    a=MP9ZtiD8KjrkvI0BhSjB:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZpdgcFQnSEhmaQ2vtECEFnZro5vpYO2fnXK8477NO8BmjHMLKQJEilRpI75rygGyoS0clmPcs1UdUYBzRXCDzU=
MIME-Version: 1.0
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 May 2018 10:36:04 +0200
Message-ID: <CAPDyKFrhRtLUFfmNNg0iPtJ+Tj5ZzDq6EsYPFc=PY7CmqkFX-g@mail.gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
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

On 9 May 2018 at 12:47, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
>> > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>> > > I think this is an excellent idea, copying in Stephen for his input.
>> > > I'm currently on holiday but unless someone convinces me it's a terrible
>> > > idea I'm willing to at least give it a go on a trial basis once I'm back
>> > > home.
>>
>> > Since Stephen merges all -fixes branches first, before merging all the
>> > -next branches, he already generates that as part of linux-next. All
>> > he'd need to do is push that intermediate state out to some
>> > linux-fixes branch for consumption by test bots.
>
> Good idea ... I will see what I can do.
>
>> True.  It's currently only those -fixes branches that people have asked
>> him to merge separately which isn't as big a proportion of trees as have
>> them (perhaps fortunately given people's enthusiasm for fixes branches
>> that don't merge cleanly with their development branches) so we'd also
>> need to encourage people to add them separately.
>
> I currently have 44 such fixes branches.  More welcome!

Great!

Stephen, thanks for picking up the idea so quickly!

I will ping the kernelci folkz to request them to include your new
fixes branch for daily builds.

For mmc, please add my fixes branch according to below.

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git fixes

Kind regards
Uffe
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
