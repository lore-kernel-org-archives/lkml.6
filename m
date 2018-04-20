Return-Path: <kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3113896-1524774839-2-2375037394140826980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524774838; b=CVGB+VYDL2rL/vSP6431+gLgy5MxF1sQYS+OMqrPmgsfJuxim+
    7xphTp9D6LBbc+lg6mJkS+g1Qy2Rty099L+iacJr0h9rmbCk/MtTOCEYQo3P/PC3
    8KTDbFdCk+zIciHW7492ZRCqTBGBqvRqGVP2Hsz0NVNDX7L3PuuW5CuyebG37b8I
    PqpTUyBWFXOrOLOIm1L+qoBBUNDgjIVKHP/3YucCE/BQCfcqE4zuStJ7E7ojfbqb
    y04sP8yRyUMv2s2UHlJzOiSKPcudmVOhOmVzILO/pMcTZVADdysjlD/GiQuTvU78
    8RsMlBaZVGO5i6Id1woe9/f7+fVCsdpLpTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=fm2; t=1524774838; bh=a2nQgF1BIZjf
    lSTWtHClBvLgykEB7uCUI3bH32+8+iU=; b=P08lKg/qf58Mb1vDksb+ErT6xlaD
    6GCF8BgkRWUSORC0lfW9gUMPKPMNHKUtMTby67t2mqoCEE41LCY1DtbsWJ3/5b8K
    7W/HJ2Gd5H8ETVeZngKfh2/ZaIavdjate4TFWX5In3c0Yg6AbewbFtZFgxKtsH1f
    BKJy2cmRCyuRRGHbLUJuaxv+7G2jCAhfhu5BhWDIjBpgsxswYic/926VBEKeD3Rs
    iftSvIF1jHnSO9p7e6gonBSUGkMKjvvP+4FqtE9+FeUpgafFBDnJTYT2eV3p9i+8
    6vnczzZuXb3ajo2FdnDdduNWmPU8Bh9AjMSsixjhlQ3ANzZKtmt9D+4CZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=nYhv9pwY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom="kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org" smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=nYhv9pwY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom="kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org" smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
X-ME-VSCategory: community:mailing-list
X-CM-Envelope: MS4wfPELnADZLYA/S+5j0ZDgPtKqxeb80sXMPsrorc0ezLgxuP7Qn4tDBdjixzlqTva+ym1nsT3EAS5I9rqV4n4cmUOF2+w6uBOQ1Qt28evz2iaNS43G/nCp
    AfZWbwqLpkAigONyDjd+cFq1eMRrmkjswv0P2i9VpR8S7DH2Ks1WQ4QJ3aenlXpXZGv8dmut3Jxu/aZyBpq48P+nBhtzFAW5xjsZ8k9FVS27zjFSLUc+Wdj1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=SiqW3_QkAAAA:8
    a=uct0b3CG0GzomzXBII4A:9 a=a8Iqh0uOV4UO7RXl:21 a=4QC2Fp2xHbueQGBm:21
    a=CjuIK1q_8ugA:10 a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
Date: Fri, 20 Apr 2018 18:51:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Philipp Klocke <Phil_K97@gmx.de>
Subject: Re: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG
 case
Message-ID: <20180420165139.GP4064@hirez.programming.kicks-ass.net>
References: <20180416085426.24157-1-Phil_K97@gmx.de>
 <20180420075717.GB4064@hirez.programming.kicks-ass.net>
 <34572fee-36d0-36e1-ba6d-f098b145aba4@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34572fee-36d0-36e1-ba6d-f098b145aba4@gmx.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailman-Approved-At: Thu, 26 Apr 2018 16:28:11 -0400
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, der.herr@hofr.at, lukas.bulwahn@gmail.com
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 06:29:07PM +0200, Philipp Klocke wrote:
> The gain is stopping a warning that clutters the output log of clang.

Well, you should not be using clang anyway. It is known to miscompile
the kernel.

> To improve readability, one can drop the ifdef-structure and just keep
> the right shift version, like Nicholas suggested. This will have a (very
> small)
> impact on performance in CONFIG_SCHED_DEBUG case, but when
> debugging, performance is no problem anyways.

See that is two bad choices.

> > Also, if sysctl_sched_features is a constant, the both expressions
> > _should_ really result in a constant and clang should still warn about
> > it.
> No, because clang only warns if the constant is neither 1 nor 0.
> (These being the 'best' integer representations of booleans)

Then won't something like so work?

#define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))

That forces it into _Bool space (0/1) and per the above rule will no
longer warn.

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
