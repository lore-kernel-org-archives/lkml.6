Return-Path: <SRS0=7usb=GJ=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479569-2-4639978202007978638
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
    t=1521479568; b=UP1U16jWTfqOZXGsHtZyG0c0Af1Yex5JxopmElF/rhXIEnj
    yjf7fleymhd3/6edSPh3pzVNI77/MyLwxNmYszJnpcUhcrhaDTO1HyieGFvfSxeu
    eXXSSIOyqU/GipReAkqJAD1Hy3ELcqG782oVvWoY46D/6vQt9N2LxDxQ22zGsy/M
    KBvD727fyRK0Rvuj/Ksq1GA5wqEQDHqsgn/7OX/AY4nPgXhEMHWr4ce3JAerLr16
    V9LTi/aTk2QiUmfFKEIP+uGEJC3IF1NqCuS/Zkg1ME/L/8a3cnNv506czX2Q9EbO
    Kmwd0MApbquKrK43OWyuQg7185+H8zeOHiUX1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521479568; bh=7YPcQnTICttJyVdai9c9Kw8sceizF7NFMTVIRvzcYhU=; b=F
    AWsj2xD5XTw/BzsKbZRBJ9iTET6LP26Nb4xPhdRoNQkVSOobsSG7zzSgM8AdCEA2
    ki93WTey/rRb8a8VKMmJySAiDcbgHsitPoPCw4o4IQ683XtMUYzK4zLq5PW/5HIP
    aKyfJYL+miWQOhE2y/w1bWHcQo/Blt5GYMWZouGFvdpxPivfdF3Bdu1sAl59ISVz
    y1vDsS0Afi5oImVJKqT504cLhmzSAnJ/SpcSUebC1VVFpCalz/8z67DcR/lhDcLl
    S0okDOcSxAhk8fBgCmZjRKyEMl9IUMQPjh5pv1I6ADEHNeunJJhSLHwTT6rJlQko
    FkiFRd18lUK4EZ9xZa63g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hanaW28O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=7usb=GJ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgvjhhunhcujfgvohcuoehtjheskhgvrhhnvghlrdhorhhgqeenucfkphepudelkedrudeghedrvdelrdelledpvdeivddtmedutdgumegttdeludemvddttdemmedvmeejvdgsgeenucfrrghrrghmpehinhgvthepudelkedrudeghedrvdelrdelledphhgvlhhopehmrghilhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoefutffutdepjehushgspefilfepghhmrghilhdrtghomhephhhtvghjuhhnsehkvghrnhgvlhdrohhrghequcfukfgkgfepfeelgeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gjXvyI5i;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hanaW28O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=7usb=GJ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgvjhhunhcujfgvohcuoehtjheskhgvrhhnvghlrdhorhhgqeenucfkphepudelkedrudeghedrvdelrdelledpvdeivddtmedutdgumegttdeludemvddttdemmedvmeejvdgsgeenucfrrghrrghmpehinhgvthepudelkedrudeghedrvdelrdelledphhgvlhhopehmrghilhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoefutffutdepjehushgspefilfepghhmrghilhdrtghomhephhhtvghjuhhnsehkvghrnhgvlhdrohhrghequcfukfgkgfepfeelgeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gjXvyI5i;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A2C2178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELviRrh9RigFgJTutULtdjEy+BFdumAF5fRqZvSV01uVak7DMxswr1WL6JETo1SWtItH+PrNiA==
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Mar 2018 10:12:43 -0700
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180319171243.GE519464@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314194515.1661824-8-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:45:15PM -0700, Tejun Heo wrote:
> Workqueue now has rcu_work.  Use it instead of open-coding rcu -> work
> item bouncing.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied 6-8 to wq/for-4.17.

Thanks.

-- 
tejun
