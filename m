Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1748992-1525317017-2-5740368540649556234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525317016; b=Nzsxvx1KnzNwAZw3CE6QcAxZF0EUH5LLUQNxbCVQrxYhkClUU0
    vRfNoLGWnWmbCeBszmIhhrOPJ7Yq+eXm52i25fBac46Iw0MkTxJdujLtDY8ZqX9k
    x90fB6wT1PxWesKhHC8SoeaElqn0kzbE6mf5Kcsrau1ly7DsGO7DI7430qbQG8mk
    pdOggS62qmjTr3XN4v6zMpdrvcLDBkwA1JDKBXx8fAo9SKPvYDIJXZydAi8ly9W0
    F67nN14DySTkYTeyv2A0KxosBb8pEfJwPHinOpnwRpB5H74B2Eo44M2lZab9BnVJ
    f90d0bRkHm6fpZ5V6Tg0pm1z15aQ99jo14Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525317016; bh=xTxoE
    14S3zstv1r/XSkN0923UuZcx7QmFOtLodE4rTw=; b=XOS7q5WOK3q11OpTZ7R6l
    4eP59msV/uj7/Lx/J/xGGkUgyQrd5i5IuT7pYbRAyEFJTz0wr4FILyjJ62fTmy3T
    jr0hYn3X73qtpGyPtM8/MWiF0lpdrJiKja5te8vX7NlpkVr89oMuDySfIbPpJxw0
    u/+DP/UzuSuTJlIxVptJi/PwBH6RgoMPTiHBuWgmFsSEJmnniFBHAI4wnVIF4Gj1
    6Reehozna93S9fyz/nGBk+83Y031jbAeOB2sIaQ/f+rpzOrNIIoyLIntPY4i0fzw
    149b9XqKY+0gyWSHQUB+zyTQkchCdyLaEaa17zfeyF5GyXyboM5ErVIgySoTGHEQ
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=smPARqz2 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=mit.edu header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=smPARqz2 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=mit.edu header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIv60eKDyKorWQZBmm9be7LiANJ0XMP5ywyF8CtzHZfp+9WRFL+EdwJ6AW2QYRFEmPSR0PcHYp0HUEih3vChOR1MQeN+Sx0v+UfgpUN6zBtrNcYmTbi1
    SfrumKjlOx2GS3vbcqHvGpfnkeuBmP8tIVOT5ExPmc+f6iqkoaklEEuaHO6pqlqrgPzLmnADekTy8flXT6khwWUNswZ/xd4Po8II3/efFRWkH3mKWhcQHvuZ
    7kHXJ7lEsww8BwS9KKYf8A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8
    a=xjgWLC5gxg7xP4NrmvkA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Wed, 2 May 2018 23:10:00 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20180503031000.GC29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180503020550.GP2714@sirena.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
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

On Thu, May 03, 2018 at 11:05:50AM +0900, Mark Brown wrote:
> On Wed, May 02, 2018 at 07:46:34PM +0000, Sasha Levin wrote:
> 
> > As you said, the regression should be fixed "asap", not "immediately".
> > It should go through some sort of review and testing the maintainers are
> > happy with, but unfourtenately it doesn't happen now.
> 
> Doesn't happen some of the time.  It's not like this is a universal
> problem.
> 
> Especially for driver specific things there's at times no realistic
> prospect of getting useful independent review of fixes, the hardware
> isn't always widely available and if the fix isn't a pure software thing
> at some point you just have to trust the judgement of the vendor.

And sometimes the Demon Murphy will cause a regression fix for user A,
to cause breakage for slightly different hardware belonging to user B.  :-(

   	 	      	       		 - Ted


_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
