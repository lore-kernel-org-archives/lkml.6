Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-4069134-1525427885-2-12166262539798156714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
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
    1525427885; b=EIvm+WgCkExQwHfwi2o/JoSYmwspH1erUvcyROw9buaYYouOEN
    pcnTFUvw6f7M2z9OQQQhQMtpcDtxlQNjayNorbuCKvLUQrPuGdbfnSej4jLV8eM9
    m0EcWAgqoO6jcW94JbJk/wlBzSdR8deWNrU18+Pm8ttFJPfo85AzVEqYJDLy6iHG
    C6SIdCamJ/lsM3d/vMmVrRiw+TSLo+2c7LU6zZeIDBOILpK4C/1ObsKikKAB0cGC
    livSb8G0lJ8cJqesG4jMJfzybCv1LOlxVAUiqGbXgSHwjXhGw+igyg3EZBG5hCHZ
    hedANY8x0HIupHpJH5MiIu5sDx5PDa/NZ16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to
    :mime-version:content-id:date:message-id:cc:subject:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:content-type:content-transfer-encoding:sender;
    s=fm2; t=1525427885; bh=iHf6al0Kr/8ycO28nF2DTxf5qlfj+OOrjhmyjgK
    7iok=; b=icLuU1XKh4YQJgl+OaXH9FWZWLUIarmDAn3TIZWhBQDoeObRFzNYcve
    J6C6tr87g4eIyrtTDKhA+YVVwqC9iu9yg+Mg4cWYF6mnLT+o2LQudyoomogzT1BE
    EXZJxpy1bX8B2M4BKuBTv97wH+wTF7bamKj/8vzkq2cK04alGEaie4lF/7PNf866
    2m1u+d7m9GWAu27E25nR+mys2Ck8pZ4rHYkDN1S5tepfJimnWBz32FGtAzL+Mxbm
    eSy375tHKNG6dilExW14w+4L5YZwNaI43bu3Lbs2TlATTNhGAQCIHSceS/PI1rs0
    phG05fkpcH+gTNNx4TkThlIlPIBGL/A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMTKZenJeW6nX3L4k2OQkBvFTh1mUlFRek7g3/5+Y31sFXR+KTeQ1xn74cycUftSdyb7VslnWbiG5tVMybakaOj3vnwFR/F9MLmsyyJagp/Q9p09C+qm
    ZfIXcoVebyfNOQqaesiENCrCK55ANNMdzU45RVptlS0twMqiHHVkKpFvzYrX/Swxr6Y9nxuPaxEanVHt8mUbs/7ETtremXmkxhpl+qbUWXjH20lEVTOeiVU6
    60pTaLI6hZYZV4GhdinNiQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=EIY8bSkbpr-BgZ2jaH0A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180503190431.GV18390@sasha-vm>
References: <20180503190431.GV18390@sasha-vm> <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
	<20180503144612.GJ18390@sasha-vm>
	<20180503165446.GB30522@ZenIV.linux.org.uk>
	<20180503173422.GR18390@sasha-vm>
	<20180503182039.GC30522@ZenIV.linux.org.uk>
To: Sasha Levin <Alexander.Levin@microsoft.com>
MIME-Version: 1.0
Content-ID: <8668.1525427874.1@warthog.procyon.org.uk>
Date: Fri, 04 May 2018 10:57:54 +0100
Message-ID: <8669.1525427874@warthog.procyon.org.uk>
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

Sasha Levin via Ksummit-discuss wrote:

> 	Cc: stable@vger.kernel.org # commit-id-of-(2)

Can you please not do this?  This screws up email address parsing in some
tools.

David
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
