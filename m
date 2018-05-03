Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2626299-1525357996-2-10973595345128872047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525357996; b=kjn+86I76UW/5vNpCJnpuKpYH+/LSh0AZY2d5tmT6Jq2wqC+BV
    +YClwZXrMFqEXjsqexN9uZenBe9c6kTBm0PtTzrfnYkr97TOVMi2RP+1e/brYPWo
    oo17/oUNkehx9cx4GzgeCjNbdqI0InB8c9s4iUFh++3FupyoXPZ3JhIlM/DKiP3H
    mr78YgrlDTSPKie40v5RGldeiaU2h22AYfalGuPIx1mgcEY+LR+wslVUL/bycFjT
    fbGu3mwYmBbjDWbW/eSZcpkxmXku854AfvKyTAnh9tO49e6Za3uD3U5c507d9FlF
    8o2uGmA0NHlX/ANWZ//DpeYj1vSTjo1U0n5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:to:date:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525357996; bh=1t+7A
    46EHWfT+0iuc6JtpxrIpEuYh6r+mpi/VYNReGE=; b=V/A/5TbH3WvOsUY0w6syp
    +ZPr1jic35SdS84RzoyvHtJZ7YpyKlvXBvSD7WEYPRFPK0GR9fk2NMJILXyQ0d0V
    jizF3xnv6tdX1374HqDJXbDhcEhURBZya0Ny5p05kTBowXCZQ/OO05GpePjYpd2z
    z58gLTU8TnyZX3Ae65QRgDtUQPIicN0G3MsJIrhYwRD59hOYcQzFbrQvlKZIQcq9
    M8x2BueYCeMi1UrtVrxkRC3N7+RNcOCfzrSfnHg37mtsHliokjCbm3r1OtPQvGx9
    Lfgjt5T9zpqwTamGEeMNfoYthrp9UM51VfoDtr3cUuJSWQ6YDpwXzmiLWOr5xgFX
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=hansenpartnership.com header.i=@hansenpartnership.com
    header.b=UhAWc7Ag x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=hansenpartnership.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=hansenpartnership.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=hansenpartnership.com header.i=@hansenpartnership.com
      header.b=UhAWc7Ag x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=hansenpartnership.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=hansenpartnership.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKY/e30z3u9uLPrCAS/x7UH67a1y7iU2MdIawmBIniJeAQF3N2Kbk7zNMh36qdidRr023QMzJ9A7BRlorHtF9Q6uAYMF8VbsXKDHAF+sSATDgx5IFNiS
    1BQzelhlNiSYEtoOzuFx1rh1stPC16tKo7P2k3KvHBUdTdiVIppPad/vpL3Xy8SBSv+HcKv3mBnMZTK/840WnCzezNtxz6ceDcU+G9JS+qdFmgGJVpOEtYvd
    Ts2lu9wtiGYIJvfDbihW2w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=H9lRN1t6z1KyuoJBbxcA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Message-ID: <1525357984.3225.12.camel@HansenPartnership.com>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jani Nikula <jani.nikula@intel.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>
Date: Thu, 03 May 2018 07:33:04 -0700
In-Reply-To: <877eol808s.fsf@intel.com>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org> <877eol808s.fsf@intel.com>
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
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

On Thu, 2018-05-03 at 14:08 +0300, Jani Nikula wrote:
> On Tue, 01 May 2018, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> > Post -rc3 or -rc4, in my opinion bug fixes should wait until the
> > next
> > merge window before they get merged at all.
> 
> What are -rc5 and later for then if not bug fixes? Baffled.

They're definitely for bug fixes, but there's a spectrum: obvious bug
fixes with no side effects are easy to justify.  More complex bug fixes
run the risk of having side effects which introduce other bugs, so
could potentially destabilize the -rc process.  In SCSI we tend to look
at what the user visible effects of the bug are in the post -rc5 region
and if they're slight or wouldn't be visible to most users, we'll hold
them over.  If the fix looks complex and we're not sure we caught the
ramifications, we often add it to the merge window tree with a cc to
stable and a note saying to wait X weeks before actually adding to the
stable tree just to make sure no side effects show up with wider
testing.  So, as with most things, it's a judgment call for the
maintainer.

James

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
