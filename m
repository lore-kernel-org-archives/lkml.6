Return-Path: <kernel-hardening-return-11950-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226mgNEleCVUq2NlTDqBzwvGqhXgTos8kICaSZzi/ieB2PxfHFGI8FoSUevc6vpP89ggKf7y
ARC-Seal: i=1; a=rsa-sha256; t=1519597593; cv=none;
        d=google.com; s=arc-20160816;
        b=ViP8SVq4H3P4S905hJ0aufC8miXo5b0aSavcuxoBTtwYFuCth8nN4CbCvugVKsKT1M
         VVkyHWQX4S6/3mRDCJ/0z9kws/vBLPDXtVlyHSdmnUCjXl18z0aoAYqaIlz8O6Xh7hK7
         CAzi7xU55q0SlffetF+xnpk/83wal9tJSILbCX6K9xyV3hxHiCV4++Xdny+OCJjkURju
         FuyFqjvXLmey1Nm1hAegMdLUpul0S5Km5wGQ0T1KOnZfQQYXSkUVjJQMRUmV0RMWL5fk
         jwyRQQqRSQrvlC4DEhfoNsibY1UZPJN4+4vY/BDk4S8BPZsgtje4IijNxHLM/efT5z4T
         4wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=OSxJygUmw6FXk7YGv7CFLyJa6Vd4IQSYbi1gIj+/utI=;
        b=r7tZaEcqcohRIivnetdc+5RqLT9o1N0n6uhgZ5ByQ3evHBnlgMON0otbbQNPipofjp
         o7bt1nmLGE0icBlKJByQGNtrADtHVsZean2Mne/KhJnjqM1fHBcnQ72SANXaaDVQCTl0
         5wqA8oGhQpI4syCZk1NkHiExKleDF8yafz0VM9FtG8G/AfgDfImC8neTHAjzZR6vrNKE
         H/gFiMoUoI3fGCAxO5DKD0EEobBoUgYHdKQqffwyiYqMuu6k1MZ7RD72KptCOHa4u+f7
         z9cPWaD1C4dGr9Ncitv2bw9WSDmMKe67q2AA6PkUFT0Ebir5kGmqBFeTWcEtYvYHtIp5
         1UIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=Ow313TrB;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ewMcRHom;
       spf=pass (google.com: domain of kernel-hardening-return-11950-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11950-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=Ow313TrB;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ewMcRHom;
       spf=pass (google.com: domain of kernel-hardening-return-11950-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11950-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:BjiTWpXjnNtPNKcrT5pOKUaTmpwLswYRqZZJ13PbTpd3b7DrobpQ-A>
Date: Mon, 26 Feb 2018 09:26:10 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: LKML <linux-kernel@vger.kernel.org>, tycho@tycho.ws
Subject: Re: [PATCH] MAINTAINERS: Add list, tree, and maintainer
Message-ID: <20180225222610.GB2808@eros>
References: <1519544153-10360-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519544153-10360-1-git-send-email-me@tobin.cc>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593357581130073785?=
X-GMAIL-MSGID: =?utf-8?q?1593413566685016904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 25, 2018 at 06:35:53PM +1100, Tobin C. Harding wrote:

Please drop this, v2 coming with different (improved) subject line.

As may be apparent, I have no idea whose tree MAINTAINER changes go in
through?


thanks,
Tobin.
