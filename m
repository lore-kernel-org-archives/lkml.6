Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-437838-1525248686-2-7014321546883669722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='ch', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525248685; b=FeH08uEJwZAZASDwMncnUloXk98i57zsIHp4dX3ojiDnDbCLxp
    OLq7+dtjzGSe0sjXwU1BMbxnc/WrFGuIRvIRBLLAqZTRXry0LXZLNRTzc3Pmw0+Q
    Pb0qAD4Hatf2fz8ES1Xdy3dODOChaRageHf/b+XEnQIfF6wa3ZMAm+9akIwZlF6E
    Nh101LDN3YMSp8ZcWVdv6q7Gpqdc2jlrRe1+TAU1owdRegLz3WL8gF6Wng+RT6O9
    2v+JglvHQ/1cj1iOMSl7k3Afgat7RVf8TQ00IVUaTy45IBk+qLXYSrXn1ivnT5Sr
    lPPWz2WlGKN/hZJV2qjAqeBRjuWgGzNTxtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525248685; bh=i1Ki3
    KJfA0+28fu514D7yQyKqxgPpJZf/sjr0EwQO3k=; b=NU7ZOgNw6opsETIJrvsyo
    mnYWI30kPyEd57+2c/VpJ/REWyz2R4eX5QOHPRxm9NuDSxVpUYol0Z6gHB1EcbWj
    aZ4WmHlUCO+Di71YQtOJPbdc5PsSikkLS4yK26yoNk47Uz6sDXRbBOMZkN94+o//
    mv50cpEbGXtXUbBeyc3H0x+yxcqgtzSui9c2WI0QOgPwthHuU3cTFgw5hIvZHRep
    mAIDJmd198m4fkwoJfsaitWI9uQS/DuvkYpVfIOF1EQQoZYo5UFw2/RdliKiNvCr
    WXLsS2cMKp7fuYbmK/UVEN+9oV7Yi59invnTX1OCpCp0FPM1HhtPEIi7p14cZVRS
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=ffwll.ch header.i=@ffwll.ch header.b=J3IHp1CL x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=mMYC1AFg;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=ffwll.ch header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=ffwll.ch header.i=@ffwll.ch header.b=J3IHp1CL x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=mMYC1AFg;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=ffwll.ch header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJs/DmVZExs0qzGGPoHYAVLiNXW8CcS/tOA21fOrx3e93l5ACkERn9/DrrIC1yjBekoO1PBmCHBvlSpyarAOhAOQWjkfMUlfnUbKtVHNuQBDrzwNFtdB
    ceHDUZ15vVBt4bm4oxlh3FChwXppFyB65+l+jAIKoYd+GeXs24GMGfOiGLjtsptsK8G7FFgxay9R4ZCqDP8wY4eQXDw3RObAravvvmg5GIJUJ/d+9gzi3CCn
    UgaONQgYRbma5fTgtsu4+w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=25-AhOLfAAAA:8
    a=ag1SF4gXAAAA:8 a=wf3fzFuKtu0kt1mKvbQA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=dnuY3_Gu-P7Vi9ynLKQe:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZqxloLHi/bTcgqJ+2PIjBLtzWHW62wr6pGryVjqXQpkHf2eBSzjMABdc/5olVBTuyzaWiLJ+DmlJ5baO/y3f+Q=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <20180501211551.GI2714@sirena.org.uk>
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 2 May 2018 10:11:14 +0200
Message-ID: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
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

On Tue, May 1, 2018 at 11:15 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 01, 2018 at 04:54:48PM -0400, Theodore Y. Ts'o wrote:
>> I do think it's about AUTOSEL, because when I'm dealing with a
>> regression, I want to get it fixed fast.  Because the alternative is
>> the merge-window commit getting reverted.  AUTOSEL seems wants perfect
>> patches that it can cherry pick once, as opposed to a case where if the
>> user confirms that it fixes the regression, I want to send it to Linus
>> quickly.  I do *not* want it to marinate in linux-next for 1-2 weeks.
>> I would much rather that *stable* hold off on picking up the patch for
>> 1-2 weeks, but get it fixed in Linux HEAD sooner.  If that means that
>> the regression fix needs a further clean up, so be it.
>
> We've had issues with the automated testing systems in the past where a
> maintainer has had a policy of letting things percoltate for a week
> before sending to Linus and there's been a bug that caused a substantial
> set of tests to fail to run (generally it's something that had unnoticed
> dependencies in -next so wasn't caught there) - we essentially end up
> not getting the affected bits of test coverage for that period of time
> which is not helpful.

So much agreed. For our CI we carry a constantly rolling set of fixup
patches to keep it working, because regression fixes sometimes take
too long. And too long here for our needs is measured in days/hours -
developers start screaming pretty much immediately when our CI is down
:-)

Ofc I prefer if all subsystems ramp up pre-merge testing as much as
possible (and with xfstests and stuff like that I think filesystems
are leading here, if not consistently). But given the huge scope of
the kernel we'll never reach 100%, and oddball regressions will be
inevitable. Once a regression has crept through it imo really should
get fixed asap, with no unecessary soaking times - get a better
CI/kerneltests in place if you feel like you need to soak stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
