Return-Path: <joe@perches.com>
X-Cyrus-Session-Id: sloti22d1t05-381307-1518537778-2-16837313801125542242
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H2 -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='216.40.44.37', Host='smtprelay0037.hostedemail.com', Country='CA',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='ISO-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: joe@perches.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518537777; b=Xz5GY/8QglKIA10p6Xg84s3xqRuQ4h56LB6XG/xm10c65/L
    5gLN3pUgjDpPkujWbrwF6cTbQEngcEI0kNbhnD02uStZRqvQZuDhPzvjbVla0Myx
    bKXJBQkZdINbIq64LRxIeUIrYaZWTLF3G0Qv3WbGj8lbvYJF6LabPMN5nGk8yl5b
    3oPANgq7G7H5cjhb2nRgNPJhDjnLGJunIxw9Uelbbh2uZAq5vBR+G8P/yms9fIdG
    U86B9U7THlU4+EK9JsLhL2jH/Fd1pfpm9JTDVKw4j91H6W4qzTdQSqdYqHwmy85W
    q48Szhru1T6VM0Vg2B1ymh2QOKYVWSNnmRf/stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding; s=arctest; t=1518537777; bh=eOWsiCs1
    Lo96dJ3eQeK5WKiHdbMx1xyYcBZb/P3f1CM=; b=oM+TP1eJnmKtTaZEvJ69x3jy
    rTcmz23BGtJale7fw3QNIFOvZjfiQO1CUlKlozy4a38fdqSu0Pg1pD7gAiwJF6I1
    tJ7sh+427t1RtejD/A1jPRvtJ74CjeC20Wu4iYaNh9xRc194wuyMo8kafly3yi6z
    wPU3xO5bWCIBtXX7H/3PkNWwjSZL6c2MHvV9Ao8SBRUOZc+xRDSsqJB/VzuyP0sO
    Amy1rJxVEFIQwkvUrsk+AgfeqTznCjNAaym17Ihq8+VhQoqHu60+vGmzGep+QpCD
    W4+1EPHw2kU/TF/x781sUyr6AAk0GMgdZ7aD/XHDym/IW8+FUMB9xDW6IbQgLw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=perches.com;
    iprev=pass policy.iprev=216.40.44.37 (smtprelay0037.hostedemail.com);
    spf=none smtp.mailfrom=joe@perches.com smtp.helo=smtprelay.hostedemail.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=smtprelay.hostedemail.com x-ptr-lookup=smtprelay0037.hostedemail.com;
    x-return-mx=pass smtp.domain=perches.com smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=perches.com;
    iprev=pass policy.iprev=216.40.44.37 (smtprelay0037.hostedemail.com);
    spf=none smtp.mailfrom=joe@perches.com smtp.helo=smtprelay.hostedemail.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=smtprelay.hostedemail.com x-ptr-lookup=smtprelay0037.hostedemail.com;
    x-return-mx=pass smtp.domain=perches.com smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2892:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6737:6738:7514:7809:9025:10004:10400:10848:11232:11657:11658:11914:12043:12048:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14799:21080:21451:21611:21627:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: class05_701e48d835a51
X-Filterd-Recvd-Size: 2408
Message-ID: <1518537768.22190.42.camel@perches.com>
Subject: Re: [PATCH v7 31/37] MAINTAINERS: Add nds32
From: Joe Perches <joe@perches.com>
To: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com,
 linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org,
 tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
 robh+dt@kernel.org,  netdev@vger.kernel.org, deanbo422@gmail.com,
 devicetree@vger.kernel.org,  viro@zeniv.linux.org.uk, dhowells@redhat.com,
 will.deacon@arm.com,  daniel.lezcano@linaro.org,
 linux-serial@vger.kernel.org,  geert.uytterhoeven@gmail.com,
 linus.walleij@linaro.org, mark.rutland@arm.com,  greg@kroah.com,
 ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net,
 jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Date: Tue, 13 Feb 2018 08:02:48 -0800
In-Reply-To: <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
	 <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-13 at 17:09 +0800, Greentime Hu wrote:
> Add a maintainer information for the nds32(Andes) architecture.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -868,6 +868,17 @@ X:	drivers/iio/*/adjd*
>  F:	drivers/staging/iio/*/ad*
>  F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>  
> +ANDES ARCHITECTURE
> +M:	Greentime Hu <green.hu@gmail.com>
> +M:	Vincent Chen <deanbo422@gmail.com>
> +T:	git https://github.com/andestech/linux.git
> +S:	Supported
> +F:	arch/nds32

This should have a trailing /

F:	arch/nds32/

> +F:	Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
> +F:	Documentation/devicetree/bindings/nds32
> +K:	nds32

Perhaps this should be

K:	\bnds32

as there are some existing uses of nds32 in the current tree.

or maybe case insensitive like

K:	(?i:\bnds32)
or
K:	(?:\bnds32|\bNDS32)

> +N:	nds32
> +
>  ANDROID CONFIG FRAGMENTS
>  M:	Rob Herring <robh@kernel.org>
>  S:	Supported
