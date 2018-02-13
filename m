Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518532748; cv=none;
        d=google.com; s=arc-20160816;
        b=YsadkRbB6a6vMMOybBgd2Ma54qIi77FLqWAS3g2eMMAEWiz0potea9B2DMXjFkb1Lc
         mCLTyFXo9o80MKoOEZAAqI50f+CnxmDCD2g97UqFAt6C+OsMh2cDarLsQtp57dF90KH5
         5wZz0EBevkV8IauAxnpfSIllZWjgJf8xOupBMmQv0iDoKhBlCAO+ZKrx8CUasWcTHqMQ
         L2BSrYnYLTcSxPcShAtCNPYZVLYZbF/2aQJ8YGZL5jokTcYJ+Z+G0X2pUN3/o3ONWJhr
         wPnLUu/o1JjlNtz2KI6ALHHSgP3QWox6E5VMAduCfA4QsJci9d1zvz8CvAIHM4u2roqL
         cDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=x1idchx8EWtAeFtM0S0pLAvT/q8V713TQwlca0EutLY=;
        b=nPLaP7r4YhC21P2Vr/4y+A9c9bh6izB99xEfO8+s3j+VAYRBZ4y/TZxIq//4QAKAyl
         /6Iw1+/Qr8mObYUqMGTeqvVUrqBAVbDTA2P58QtDOVS1x1WaIyPKwY3kqzqSf7Db60Ep
         iVuRig9xCmGov3fRlyUxCUZ8f/J7u3FhwsWquqxorkUinlVamei/REAP1v6UDkIj20Jj
         /IXXjIAymQbfpEYEIEQC6qeMpwmodjx4IQb53v1OLkSB6m27lSS9ypYV5xoyGTscScUT
         rtO988oNYW0UsGm/NSCuFLiXKk3jx5vNht+mnoejbLIfB8z89ARHxAt3Ee/QTgTkr0Dd
         JX+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oTUFJHgh;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oTUFJHgh;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AH8x226jiop0Kqj8LS21m6WOLE9BoXrm0yauZllcuiCitioTp4QF+zMzJ2EUwAwFmW4EIxWnh68A+g==
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Feb 2018 06:39:05 -0800
From: Tejun Heo <tj@kernel.org>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] libata: transport: cleanup documentation of sysfs
 interface
Message-ID: <20180213143905.GL695913@devbig577.frc2.facebook.com>
References: <20180213112159.GA24306@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213112159.GA24306@mordor.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592284598676313404?=
X-GMAIL-MSGID: =?utf-8?q?1592296995295428520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 04:51:59PM +0530, Aishwarya Pant wrote:
> Clean-up the documentation of sysfs interfaces to be in the same format
> as described in Documentation/ABI/README. This will be useful for
> tracking changes in the ABI. Attributes are grouped by function (device,
> link or port) and then by date added.
> 
> This patch also adds documentation for one attribute -
> /sys/class/ata_port/ataX/port_no
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
