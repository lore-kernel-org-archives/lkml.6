Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2980787-1525373924-2-8921607881468733718
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
    1525373923; b=LT43L7oU9qJ7SqM4TJS4XSEqbvfFyuhgM0SiYjhQ4X3FrYadlY
    Wswn1djbaBrhaDLBvkrDhcFGm2H+dBk8XaSArrtqq6UtkwS8FEZ/HC0Yy7I5wobl
    9vqzPEz0ZhiNq+wgrdt8qB1lWrgGxC3hNEeybiXfmWbodjf1f9ZmO+u4Cn/KUKjE
    2fmG7ChDl4gOoPtY79Chg/zP38Boyz6cfU0TYzzOkViD1/lC9+e4sJQlvjtKH+z8
    VSO/79nyHkq1sMXpvKZ2q6ianGF3F19jb9EgzgBQrKRbVzP69VAmW8rozOz/aaY1
    Lqc1mzOOnAIQdFh4zGrY0FWsjZHF+/w8JEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525373923; bh=WdOHf
    jOWUU2mmvWYuYr0G2tezb82vl9plTfvnCvnAcQ=; b=GgHuFSc1pHa8KN/Zm0Eah
    ppQLSbwE+gC8pY+vEuLHrtKCyMqvsqHEFCAPGbe4dCyhzWWW1H183rPDCoDe9kYI
    BNUZWMUlY93/3sQSibmP+duxzDWq6loCk07SiOVN09tjBlvmkginK6AzGTwglNib
    t0QjNYRbohU15ODDlP1lAkeDWop3u3+CK4htTeLYI/ku193lcxiPdfU+DE2Kaol2
    qDWseObok97CoOE3KehnipJcGEzAWG1oQ0KGmkhis7N3UUfXyUmF6p9HwuSEM0Ww
    b4NnCAp7Cd4wlFpVZgTIqmgy4sRJp7f142MIVmG0nlpJpO7baV3vs+TWQ2bAjaKU
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=D+Nxoctb x-bits=1024
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=D+Nxoctb x-bits=1024
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
X-CM-Envelope: MS4wfJfNv2OnalyQc0Rr4/OahWV5EYtJmP6ytHjs8VDvs/eNd4V2sDKwL6Cz0rysRliFAExJm9ki2tAHY8mo3Pw+yPtmS9Unial8R5pqwwwj7Z5HWkwDbZx5
    pEAqZLpU4Y1GPk7jpzCiIuU3PJNna6MQv/QMS0tEbNUhGP7pOUMS8gud+tGM/RFIFPHXM1t8qw0vRfFIOh3Af/QF3ucSmDt0V2BRObgU7q04P4jXGBmORP+P
    JdhEaKGkutVlncSfcGiz0Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8
    a=5-1Uoe_gF7J5TNT_fdAA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 3 May 2018 14:58:28 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jani Nikula <jani.nikula@intel.com>
Message-ID: <20180503185828.GG29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
	<877eol808s.fsf@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877eol808s.fsf@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
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

On Thu, May 03, 2018 at 02:08:51PM +0300, Jani Nikula wrote:
> On Tue, 01 May 2018, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> > Post -rc3 or -rc4, in my opinion bug fixes should wait until the next
> > merge window before they get merged at all.
> 
> What are -rc5 and later for then if not bug fixes? Baffled.

Regression fixes?

Note that if people stopped introducing regressions to the kernel, we
might actually be able to release the final version after -rc6 or even
earlier.

There's nothing which says that we MUST have -rc7, -rc8, -rc9
releases.  If we were actually disciplined in our testing and in what
we push into Linus's tree, we might actually be able to go to a
two-month release cycle, or perhaps even slightly shorter.

But if people insist on trying to fix bugs, and those bugs fixes
introduce regressions, then we end up with a longer release cycle,
which causes people to want to stuck more bug fixes, or worse, even
some feature commits late into the development cycle, and it becomes a
vicious cycle with releases taking longer and longer.

	  	  	    	    	 - Ted
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
