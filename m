Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2465973-1525347830-2-15124416598389900988
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='uk', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525347830; b=KpkAhZ1qV3oj5UAEYUH3jFRdnw+1l03y0aVQGMBoJgKqJybOMc
    SWXkWwrF0ni5lXPD9dGJTBMfWi+v6R9Mb8BAOjQI9RlZPe4BLMr7OBxGxzXPp74U
    1kpT/FMo1kyl3upCTAXaTuEFqB3Y5lBiV1L0Fkj3Gv8tdNOBTp1SWytdz8WDlU8N
    hJTQc5JBxcMiUe5i1q/KL5YhICh6qrh17Le9zn2uZ+84IPZxFEp2wMSgWVUGOalG
    phKMPY0ZJQcdn/og1btGuuwaEPpJgc9bHFuBtpKq7uRUO0ltUDZtVetocLRlhQYu
    j/jAaS+0UwBVpiP/FPvKdpBpYGBvY7bOVbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525347830; bh=46cct
    BfadRxNi+UVeth7Mpln6BZL4DDUlx+9copM7w0=; b=df6eAHDMSC6uy/S9ijFVx
    iuh3NWC4L/xkCxnKSM1W0bD4667B1n7MJvySw46OuoARmrz4jz/2b2z+riPquvNR
    3g+VJ6AVtYWm4v+befsARXLE0eiC3t1B1DsBgU7nghdDp/Jce2RPC0N/cUSKN2D4
    akzQnmp4gnGRBUM33Y11yjXz+L+yz3m5/UrfZDkuIVrNcqniG4f1acZeCfZokBWT
    ONa9Syzci/Ei8C+PTALC3OSgKJmfbThYb0EjcjlDsD1tesWWOAXxTBAkQh8Fu2/x
    6Bc0LT/WvCvv56kVcxUQt/hw+5A/CNNG2pj9GyIZkPbMHqMR90P3flFGPEjYo0O/
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=zeniv.linux.org.uk
    header.mx.error=NOERROR header.result=warn
    header_org.domain=linux.org.uk header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=zeniv.linux.org.uk
      header.mx.error=NOERROR header.result=warn
      header_org.domain=linux.org.uk header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEey0WNxJrTLJTVkYF37+BEM9ugcQmyQd+Sybe26BIq2I43ABvPAk+ef9MKzjvgvgwOi8v7tQGaBMa2KmYZ7OgVyoXpyFGs4/IXE6gkVpdKYoP8veSwZ
    owxVg2me7vWhAWEwEAShlHAVUiMb+zl81rnFUrVKTgVDrCs3ncGAIjSKVa/xPjarm92VIVCHmdbx28SNJVqNMw35FvT+k9XuDPLYmKrN75OTZ+AXw05Y9Vxs
    J1Q3t2jwPsm+87asJFwsOA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=J-eUGf7BhME-wBjmNmAA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 3 May 2018 12:43:35 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20180503114335.GY30522@ZenIV.linux.org.uk>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Remote-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED
	autolearn=ham version=3.3.1
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

On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:

> Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
>   - 245 carry a Fixes tag,
>   - 196 carry a CC stable,
>   - 395 contain the string "fix".
> (non-mutually exclusive)

BTW, what about situations when we have a fix naturally split into
a series of 2-3 massaging equivalent transformations + one-liner fix
in the resulting tree?
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
