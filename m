Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1509659-1525305996-2-8037710492817426525
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
    1525305996; b=TJli+LErYVhCNeZZBALOpHtWvWgkjzXVVtJ4IO8LB4/RHkvHuZ
    2DJPcD5GCRthlsFLFqX4+JgFSMiIaW7IOK3fMeh915+gE/t42Z9MGvMEaic6HQ0l
    YXFUcNE6tzaR37rbub6bSxGRkAwcR8XSJG15/1LnTyr80cmyfT+D/WO/zFkSqwKS
    lWRW31BlgjjbaE2FEAoL46HtQq+s4A4UsRTjlt1SBtc2beVaYEfVQoGIHZPhrZc5
    dajJTl9IIR2bOd2K2+9AyeqVXDY+t/PnGdZMLeoBc7ztEsPgRIAZzkwMGbvl5fv7
    nELE0bKr2y9uX87bEpHFGW8PSAcYdIdgVDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525305996; bh=xuEMw
    pDxooqZGEiAvH7Gk4WeI6yhP7v10ss++0GHuuE=; b=lcDpnpiQTvBQl6V23nm5d
    nVDzYcLaWjvhxrLFlSsO5izmrbpZXV0YtW9EiEw0o5Gzw/NvDsOjMV5L0ipO5Jby
    JJIu9ceVadlwd1oOmJ4NhW8CFPcU5oYJUpM/ra6nF+uaBQUYZvXa+YHzkGef18Ph
    5LGOYnqiFX+eIPvmnawxuTSXQfnkU/F+osjlVc0X0OV7Fu2IyO4YibciDodRWLsV
    N8w1bh1wYLzDFbcc9agK69mZ43wBZhgZMpN1UlXizB0pKcjCubSZ5Cxyw8lYuAjd
    06ijnBdoUL8HUQOZPagArxKv3ePNiICn+vgMyPVTvPnq4tCJeeS/5KbmIySoICup
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=InN8RrjC x-bits=1024
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=InN8RrjC x-bits=1024
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
X-CM-Envelope: MS4wfNI1IoHEKdDmT7sJUyUAxHwXpgeg1xNNCiRl5lAU7sF46+ixzQOolHblHNGWwLOYo5MBMqk2GeXUuLFC7FO/uGuybVhLV4XWDN3eE7/4kFtAVr+mZ9uw
    WXuqU5b324CqLPm/yf5gnY+Y+wIUcGPQtIy/81NwVGn/+xsdrso1UgmKmvfAWt7c6kbjShEu2INyLdzLbbxua6cetZa0iXhc9zpoUDhP5qEDtJisXMls8wwy
    pA/doTG9UevSPU4GqAmdlA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8
    a=JJOic9bdfBe1OjzAEOoA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Wed, 2 May 2018 20:06:20 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20180503000620.GA29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
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

On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:
> 
> Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
>   - 245 carry a Fixes tag,
>   - 196 carry a CC stable,
>   - 395 contain the string "fix".
> (non-mutually exclusive)
> 
> That leaves us with 200 commits not falling in the bugfix category.

Some non-bug fixes are allowed in -rc2.  So perhaps what might be
interesting is to look at v4.16 (which is completed), and look at the
distribution of commits:

	* regressions fixes (for bugs introduced during the current
		release cycle)
	* "normal" bug fixes
	* commits which don't touch code (e.g., spelling or
		documentation-only fixes)
	* other commits (features or cleanup fixes)

at each rcX level.  The historic "standard" has been feature commits
in -rc1 and -rc2 (tolerated, but ideally should before the merge
window), bug fixes / regressions in -rc3 and -rc4, and after -rc4,
regression fixes only.  It would be interesting to see how well we
have been holding to the historical ideal.

It would then be intersting to use Sasha's analysis to see whether
there are more bug fixes caused by regression fixes versus normal bug
fixes, and whether or not they are common when fixes come "out of
cycle" --- for example, a non-regression bug fix in -rc5 or -rc6.

Because if that last is the case, then the prescription is very simple
and not controversial --- bug fixes found post -rc4 should be held to
the next merge window.

If the concern is regression fixes which require one or two tries
before they are fixed before 4.16-FINAL is released, then that's a
"life is hard for AUTOSEL" issue, and I suspect Sasha will find that
there is rather less sympathy for holding regression fixes for an
extra week or two.
 
If the concern is bug fixes that show up in -rc3 and -rc4, but which
aren't hitting linux-next first, then holding bug fixes in linux-next
for a week makes sense, and if that means that a bug fix found post
-rc3 needs to marinate in linux-next for a week, and then it then
misses the -rc4 "bug fix" deadline, we can have a discussion about
whether bug fixes should be allowed in -rc5 after a week's marination.

My personal opinion is "to hell with it, just wait until the next
merge window" --- but this can cause more work for the stable
maintainers since a lot of bug fixes would then land in -rc1.

Cheers,

					- Ted
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
