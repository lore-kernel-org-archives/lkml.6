Return-Path: <SRS0=7usb=GJ=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477930-2-5700342703227958600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=7usb=GJ=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477929; b=UDG6bTurYRi9oFLN0LhvKT6Tr7slSpbwiQWse/Dmq0Jo8sf
    HpXMS6cTHvL16QJqQVn4atDPD7v+WjPh4jba90JMahyZywDgBO9aj5gWIm1+fG0H
    W4GQOC31wn0YaInXZU2/o73CWRZSx8Ehg3MmevlI5W2PQihzCmW3R6gbAiyxHbzd
    kYkuN7FSkWYMI+BxXz+yCN4EtjAhhD9RkNvEe4v7hd5l7TICLcSaXcv3iYDiRwtV
    xJIckK5pYrOUjsCHaVddyJXR7Px4+i08SFt4PNZvi2MFUvOE7BYtlObiMRc9wHHl
    xFNscUcHUVe+mXOn1SAYTgo5VzYS8bwfKXTRxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521477929; bh=KGOXxwjoPaeILIzlP9ccB/IxQ05OiKwsM6ueO0bz7Xo=; b=b
    n12b3354lk0fgOctwORYduZk9fh0RFUMJm2+NNwSHe5bO53rz9RQ7v1/A5UDMEZs
    QAaMRU39hYYMPblYpnAn1aShdqFQBR6Yp1y06IVY9IopcV5yx2RMY6lfQzxyjxIh
    tnagr11lDrH3m9uL6xH8gLuVjoasE4zXDRYFBt5pA/+NNQC6TuGWF1eAaAnCEsuA
    KX/Y9P0NjAN7XwXZ1vSa7VEeVmZ7WNEdmFgUwQzu1fiYTuob1BCOpr9ZhpKw7fqv
    t7tD9fu0uWoF7nKDTIMfvDuqfqyeYOVZOIBYn3Np8m+p/pV9r2NqJEfAIHhji7wU
    4oqWIdG9nKEVMGhz7/BqQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Th8udw/S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=7usb=GJ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepshffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefvvghjuhhnucfjvghouceothhjsehkvghrnhgvlhdrohhrgheqnecukfhppeduleekrddugeehrddvledrleelpddviedvtdemuddtugemtgdtledumedvtddtmeemvdemjedvsgegnecurfgrrhgrmhepihhnvghtpeduleekrddugeehrddvledrleelpdhhvghlohepmhgrihhlrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoufftufdtpeejuhhssgepifflpehgmhgrihhlrdgtohhmpehhthgvjhhunheskhgvrhhnvghlrdhorhhgqecuuffkkgfgpeehtddvgeenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uXSoyNvH;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Th8udw/S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=7usb=GJ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepshffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefvvghjuhhnucfjvghouceothhjsehkvghrnhgvlhdrohhrgheqnecukfhppeduleekrddugeehrddvledrleelpddviedvtdemuddtugemtgdtledumedvtddtmeemvdemjedvsgegnecurfgrrhgrmhepihhnvghtpeduleekrddugeehrddvledrleelpdhhvghlohepmhgrihhlrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoufftufdtpeejuhhssgepifflpehgmhgrihhlrdgtohhmpehhthgvjhhunheskhgvrhhnvghlrdhorhhgqecuuffkkgfgpeehtddvgeenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uXSoyNvH;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695C121737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELtR8WmJv+33U06M2my+oRYvML78zAjbpyVVKh0kxFgMmsi3u8DvQT1C3nu5zi1kbKWXCohvSg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Mar 2018 09:45:23 -0700
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 6/8] RCU, workqueue: Implement rcu_work
Message-ID: <20180319164523.GB519464@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-6-tj@kernel.org>
 <CAJhGHyA3zte-0MWGC+DrOptprHBRroCn8fHM678iVnb-1VStLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyA3zte-0MWGC+DrOptprHBRroCn8fHM678iVnb-1VStLA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Lai.

On Fri, Mar 16, 2018 at 02:01:35PM +0800, Lai Jiangshan wrote:
> > +bool flush_rcu_work(struct rcu_work *rwork)
> > +{
> > +       if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
> > +               rcu_barrier();
> > +               flush_work(&rwork->work);
> > +               return true;
> 
> A possible tiny improvement: check if it was already queued on wq.
> For example:
> 
>        if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
>                if (!flush_work(&rwork->work)) {
>                       rcu_barrier();
>                       flush_work(&rwork->work);
>                }
>                return true;

But this breaks the guarantee that flush_work waits for the latest
queueing instance.  Please consider the following scenario.


 1. rcu-work is queued
 2. rcu-work starts executing
				3. rcu-work is queued again
				4. rcu-work is flushed
 5. execution finishes
				6. flush finishes
				7. execution finishes

6 should happen after 7 but it didn't.

Thanks.

-- 
tejun
