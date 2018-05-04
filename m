Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-74247-1525436928-2-10557093994757439584
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525436927; b=IO9KcLUb5hKCXfodd7YQadSluoUnnOGIqbGLIZ+2IfkQFLIKZr
    bBsLjKiUAYu61cFEL8gDMCgMAOP79TMWIxze3va4sPiwp7hYKvMfe+ZoIWPgLJ+h
    Y8uxsKjI4wji9GWAoy5hOajwkxn63Lxs/r2MxfqS+IZSLjCoKi3rOLO5DORvNH5m
    ftf6AMHMqJ3QmVENu0MvoiuUhwQEqoGroorU0YsnDpYUM6oZQnd/VNmV2CZA9c2O
    Kdc29F/9ECFDaQFLK9fHNawMpb2gX43c1SaAEXy1FPu9cH4fYlNstGPSTo4hlbG+
    qMHW7i0lwzNQrhOZGsNzrBxSnXyzPLoYsf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:in-reply-to:references:date
    :message-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525436927; bh=vWEa3
    43746C9CQKBRhqY5gZ1+zK4skUMXdNonVFHs34=; b=edT8/oFNZgnL9dr+0SF3C
    NB8GDm1+pSr8MPL4d6iaRuPpLQgiJBeYppAr5qOv8KAKh+84uI4rirnUZb8u+lR/
    KckGKcj6ypPS2abp9qALh335Rg5tst8cxkb9/wXfnxcLCEG5n1k1ePU3VDlcYZn5
    GjfOrdgA5Txu8JiYaeIqjxI3hRTAL+3ryRxn7LcPE5imn62HkaCXEbcnICrtyr2R
    2o/qiuo1SgBoL4SwPU8r+7kogIJmvPNRinTAVgHtC1+4nZn4jdSZOqQ2GreOz+x6
    OaJih2WLr5zr/0yKQg3iEuVB+GzM2wfT8yK5zUKI20Dfr+XY91nXyixPvyyysA4x
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
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
X-CM-Envelope: MS4wfKUIzqHCi21rjvzus1gMDxgeCnbXfKHrvbmCJZ9pHSo/noEKIEa4hsOUORUrqAKD7NgKTMLBJk8e3IOf3XPiZVPnL/P3yXxBGnSNFr09jYpByzfs7BYn
    pQxD6DEhx8nTZPOEIHwJ3Ny8FxQB1l/T1NTy0oSDg4tWUbn2XNq6V+06LDtrzYuI8xlMzPWwd8JX0ljNgwbQPB7whsycU+aqXiAt2gopDmh59OSMqq6mQBfM
    7tlU+319ZoejkkSluvGuBQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=WlhSJogrsaN7um2xiokA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400"; d="scan'208";a="52398756"
From: Jani Nikula <jani.nikula@intel.com>
To: David Howells <dhowells@redhat.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>
In-Reply-To: <8669.1525427874@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180503190431.GV18390@sasha-vm> <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
	<20180503144612.GJ18390@sasha-vm>
	<20180503165446.GB30522@ZenIV.linux.org.uk>
	<20180503173422.GR18390@sasha-vm>
	<20180503182039.GC30522@ZenIV.linux.org.uk>
	<8669.1525427874@warthog.procyon.org.uk>
Date: Fri, 04 May 2018 15:31:17 +0300
Message-ID: <87fu377gbu.fsf@intel.com>
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI
	autolearn=ham version=3.3.1
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

On Fri, 04 May 2018, David Howells <dhowells@redhat.com> wrote:
> Sasha Levin via Ksummit-discuss wrote:
>
>> 	Cc: stable@vger.kernel.org # commit-id-of-(2)
>
> Can you please not do this?  This screws up email address parsing in some
> tools.

This has been documented since

commit 8e9b9362266dd16255473c080d846b13e27247bf
Author: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Date:   Sun Dec 6 12:24:31 2009 +0100

    Doc/stable rules: add new cherry-pick logic

in v2.6.33 so seems like there should have been enough time to fix the
tools.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
