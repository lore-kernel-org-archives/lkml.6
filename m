Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1622249-1525307923-2-1019981554912494883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525307923; b=RtJLjG8xWotN2H8UaHRppXp/wog08MTt8yZrFJP9uhswIBoQYh
    +cVR0rfXeQ5l+J6j8bRJDXVDkhpzpa222QKGKqEv2QIqegsGAXxAsEJJHu5Npf+2
    LquqFWpNdmUt6sVrAIPHguRReBFhln+fkPBP47V/9fsL5vzWyZatoJfoZE8vQrJK
    5H7POIeNId60eM2r0Ca0sOvoSUiUAesd5Dov6uBH+FXximO7O4sJF5lj3fYOFNux
    1UKIxbSv86QhuEx+rTcj+zJQErLtLfTzPsN4lO/PSv34n4bJ0xS9GsOTstymm9G8
    Ba+5IHRUqpTse8nYYfyaGoGqf+BXws0UCncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:references:from:message-id:date
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1525307923; bh=RsE5wHILJwSvkWD/YeMh0Ww0QYwG0yjH97MsAW+iZdo=; b=N
    PEwzqNOd862op5xEMc7M7V/wBEmoVkT8QOCUjz2YhbztPj2FXmw0TBAyqg5eFxBB
    psHIZA+4UyB9i4XedNXnFbsNmzaSZI6u6jehE0iujMSoHe7V3a0Pl4zTeXsPQyEG
    wfQ+Fs+e6ylE1/yT3DTqhEKexnUcnqpWuj2+MI2VdzR7BMRcf6e9eii5XleXcek1
    ltziMWq3IQxeAGAAKyVxTWro+wOHZkMfiuo8sdqV8Rhb5aQ31y7gfp+Fkln28YNs
    EvaCxIHZc6qoiS9kahm7gskWrqOoewJycJ2R0X6yaTrtOIBxjqdDfAT5AsqTC9XY
    k5dDmpD5YTJnov+6iTL/Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=vbwH9B1Z x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=U/02V2d7;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=vbwH9B1Z x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=U/02V2d7;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGpeHX0MKbWu65RyfKV2Q1NvsgfosvU+SHUeUm4YUUlh8YI8+FRwYbbsnRBgIFCv1bauZwDIV2FwXkoK60QQbEEVxSCvwCLhUXwtZKkgd3gW95qVIUEk
    vuLky8Ex7ZnO94ZmbjVC0LtqD7SV5lwJ3qpUPS7k6hij7ENsbt0Iwil3huFtAWDqihO/7HmqBbCKMm9bMgx9V8fzm5gmHJRPYI9c8ncameBjXgfs1fvbseJN
    JJPjNGKfPsnIABAKsSg5EQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=smwF0j5rLd9gHIm0iSkA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZoOLHSmYXilgARa0FArZg7W0IcL6utsPyAYRaKGmZPb1YxxgodO1smOWY7n50zSYVWGJSn/6w==
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
Date: Wed, 2 May 2018 17:38:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503000620.GA29205@thunk.org>
Content-Language: en-US
X-Remote-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, FREEMAIL_ENVFROM_END_DIGIT, FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE autolearn=no version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/2018 05:06 PM, Theodore Y. Ts'o wrote:
> On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:
>>
>> Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
>>    - 245 carry a Fixes tag,
>>    - 196 carry a CC stable,
>>    - 395 contain the string "fix".
>> (non-mutually exclusive)
>>
>> That leaves us with 200 commits not falling in the bugfix category.
> 
> Some non-bug fixes are allowed in -rc2.  So perhaps what might be
> interesting is to look at v4.16 (which is completed), and look at the
> distribution of commits:
> 
> 	* regressions fixes (for bugs introduced during the current
> 		release cycle)
> 	* "normal" bug fixes
> 	* commits which don't touch code (e.g., spelling or
> 		documentation-only fixes)
> 	* other commits (features or cleanup fixes)
> 
> at each rcX level.  The historic "standard" has been feature commits
> in -rc1 and -rc2 (tolerated, but ideally should before the merge
> window), bug fixes / regressions in -rc3 and -rc4, and after -rc4,
> regression fixes only.  It would be interesting to see how well we
> have been holding to the historical ideal.
> 
> It would then be intersting to use Sasha's analysis to see whether
> there are more bug fixes caused by regression fixes versus normal bug
> fixes, and whether or not they are common when fixes come "out of
> cycle" --- for example, a non-regression bug fix in -rc5 or -rc6.
> 
> Because if that last is the case, then the prescription is very simple
> and not controversial --- bug fixes found post -rc4 should be held to
> the next merge window.
> 

Holding up even fixes for severe bugs for 4-6 weeks ? Seriously, that is
unrealistic. Holding up the fix for the next SpeckHammer because it was not
ready before -rc4 ? I don't think so.

Even when not counting severe problems, you are adding lots of additional work
for those who do and want to rely on stable releases to merge in bug fixes.
Sure, I am at times annoyed having to deal with a regression in a stable
release, but it very much beats digging through various mailing lists for
pending patches to fix CVEs, or for crashes seen in the field, just because
they are held hostage by some restrictive process. Even worse, I'd end up
picking the regressions anyway because I can _not_ wait those 4-6 weeks
plus the time it takes for the fixes to show up in a stable release.

Really, that just makes the situation worse for everyone. We would be much
better off by further improving test coverage.

Guenter
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
