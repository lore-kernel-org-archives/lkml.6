Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3237330-1524583167-2-14325674239884677583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524583167; b=L41zWTl80ZdOO4phgrxPs+ZnF5LTlrvGtci0Z2GtzsFHQFCBEu
    oKFxMBhYBWc3E0X0o7JlMyE3YswjuaY3YaMJxtOM8D++vMTDVgIRkpcitkyAkov6
    kaSXlrieQ8YT3FgCglyETAjz7ZCplXH2rJVZi1m7dKMsFcdxMvai6t3JTfmW7EvI
    igb2XHt7tjHltIho5ZRz3GxpYmyl1PkYniBqsXUPWm3/DXE5l5SupmF/ZV9V/r/n
    lSmZMfA6iQl4GC6Rxx3NB2tbo6RdXKZnpxAm/iJHuhgntheDHAcrE+ghqTim6yES
    O51qDvEFuaI4JxRntyzblpJNvCtfzEHIauCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524583167; bh=GX0rb
    i9wYTJfKyKQyWo2vUSDnio724eYtvItDqXZ/Lo=; b=LoYLhU+j/RAsv416dbZHG
    MMN78gzmQHSfa5uNiv+yhkwC+Hgh1ESaxZ08KIDu0zllcz7gDG7KIdzQGN0IoTMk
    xE76Jh5f/2wKdboIAAKx04dsPkWJJkjlJSo75QUqEg67Uj36S94KoVHWUvYI5el0
    RRvN+OTTjgyuMwIc6ooLclT1drbl1nTpzNoN4WjHfTsisOyMHiaCLx3wQXn4/i0j
    D91uYiO3ouBd7FUfiCHUMXkjzAdK7rTJdA/9wudA2pqbzdFFbI4G1ui/RdiwqIVX
    tYumH/dn/uGS0hi43bNPiY826NZUjw6nykmcmuOiqrxFD75UfoOKSikUHVKboxCH
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKqM20FMQDfWabEmelqvhx2DaaEHjC18OWqk6u1yE6I4fVsG/hu6UrbWECjlycA7IT3nN/TR4AUsvGI0ycybjFMCEEWG/VKJM5GyR05+4TWZ9gwfAPmw
    FDspuzA1mlbY+ZcSniIiriA6NDdKxLpC6BAPEunyASw9fIZmQHde7Ct15/2O6LDYRkBEEe/3Ilv5akRTyp60Z/b96Q1+IRTf7RzODPJKTXdHDA890aq4sFlI
    ApSG2pqJbr8StLRemWTYwQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=p4uSZcHfE69TkLBqYdMA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 24 Apr 2018 08:19:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: simplify procfs code for seq_file instances
Message-Id: <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
In-Reply-To: <20180424142304.GE26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2>
 <20180424142304.GE26136@lst.de>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, megaraidlinux.pdl@broadcom.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 24 Apr 2018 16:23:04 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Apr 19, 2018 at 09:57:50PM +0300, Alexey Dobriyan wrote:
> > >     git://git.infradead.org/users/hch/misc.git proc_create
> > 
> > 
> > I want to ask if it is time to start using poorman function overloading
> > with _b_c_e(). There are millions of allocation functions for example,
> > all slightly difference, and people will add more. Seeing /proc interfaces
> > doubled like this is painful.
> 
> Function overloading is totally unacceptable.
> 
> And I very much disagree with a tradeoff that keeps 5000 lines of 
> code vs a few new helpers.

OK, the curiosity and suspense are killing me.  What the heck is
"function overloading with _b_c_e()"?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
