Return-Path: <kernel-hardening-return-12239-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELthponc297MYZaob0MD9nc6qJE15G3gZMn6VUQFxc5Kd3VkKJ2DJ1dgd3s6841cma2llXEd
ARC-Seal: i=1; a=rsa-sha256; t=1520529197; cv=none;
        d=google.com; s=arc-20160816;
        b=PkynIXBYc9j2lE8moDCsUu9rsWnOoqkPpFUBGI8DkB3NROdjDuMsKs0GIFYFO5lam/
         9Az6XapVbg3KbEYahlpGHWinUh/2j56DmeYl9NifaUNH8ijEMG2OYFXAPCM2bVVsqgzg
         ezP9vK0FE2KuoCKAgWXUPajIMjPJg5OlEo++LTi1SPVpxpcNxwBTUC5uVonXSEdqz5Th
         YOAK0y0WonzmIUnGr/RpIXKQQyinspR4OET/KTHg1dUP5Wovmez5Xc4UFMPtaJlnyt/n
         8vdqq0x6CkswojZLfYl9d9GWkjHGDVSj/YtsybFkm+b9ipav8cJ/R/56UKycjHTF+Zzf
         6Urw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=znhENCwYMgS4p9wmcUv2tv3RaNMWv7queH2+hBX8FI0=;
        b=rJ7QTO9QYJRNNruQCtJ5AEggaJpCe31nNA0icbEVi3fTb1kqNY7IBA/Q8GiAwo7oDt
         1GLugaqaDWkg1wwu/jLkyODYB29pHW85nBigEgcncxkaohIqc88F/uOk1gm7da0cSmCK
         jXBVOyIU2lOrQAJLK53zEeOj6/YMW6wCFjFeUJbZpKDod43v2zC/a5VlZevgw/4qmgXg
         W+/6cQYXQq5GyqN+nLHv6BkWWVlQPoKmVbuHkpHn3If7ggIgFjujSZf+xGHwWajAf96d
         uO3bad1Jb1F+Q/NPAsEvoQKA9DN19b+0xjDoniwKo9e0EA0sXssVCl9Gug7r96TJDjkJ
         Lkzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=1wyjG4pb;
       spf=pass (google.com: domain of kernel-hardening-return-12239-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12239-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=1wyjG4pb;
       spf=pass (google.com: domain of kernel-hardening-return-12239-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12239-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 10:12:53 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-ima-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] ima: drop vla in ima_audit_measurement()
Message-ID: <20180308171253.vbkkn4gqkyobei7v@cisco>
References: <20180308170051.30840-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308170051.30840-1-tycho@tycho.ws>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594389722092015419?=
X-GMAIL-MSGID: =?utf-8?q?1594390424221990426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Whoops, seems the IMA list has moved since I last sent a patch. I'll
resend shortly.
