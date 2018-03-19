Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484876-2-18084498312923755347
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484875; b=uprxBwDoWNcRhWKQgtWfs+swQo8dJEsyOTybnl6zN8zZ6Pb
    nMzK/xNlYW8fwqs+H2RjMv6OQCrRKpNeLZZ5YD7cz4h5XZqyTyeAMTY2tGIzXNWd
    bxeLDxAQmen0WYnISGO9U23enMoAQXMJun5JMpOAm7h3KOWOF0X2d/7Sa8AJXzGz
    nJTBuexLtiK4HmKpBU3ibCZv8Tp8idElkX/mnlmhW4s7Ji9VbTXWXQ1k8HFvUOL0
    uXN0l6k5ht+j2t31qsNK0YMWzE+z6rHDQ3Cz31XeeQPQrmMzdjpjpN+ewhV0002Q
    0s9PktFiEb5/gaWr/QaAVyauNxe8z2C/iL2536Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521484875; bh=HV6E7oIQRQVh/b8MLi0FOBWE7EuZ8vOODAFANL
    S05sI=; b=ncdTGt2qrBEMLO9ZlzV8Tn7GhC+ygWVDuYIdfTBpNrbTeG2rvhh0vC
    ar2lEFEbpuPOoZ9IH5ba3oPJCzLbvwu7ai3Rj1nP9a8iT3/rlbXFpYkLMBM3XeZu
    wW3HycMDO4TQN1XUg65XKaGIDX0QuKLMd5VriO2aF1GtrYWy9jJDg4n2SgT+8tsI
    gBJ6zkstwS9KGAYKIH3H80yeIdIgPUBBifaoCE650SeoL9DLUd0cb+MgEGZd9Pwc
    8q0RSw5ILH8RBYz8YA2KC5h8UuhxVanHbGqEmZ+FnKGpOF8Y8YIiWLEeF5YRTM6A
    sWeDHdcxfK0ifYTKBfCvXkEUQZXRMXiw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegjfhfhfffkuffvtghsphejsehttdertddttdejnecuhfhrohhmpeetlhgrnhcuvfhulhhluceorghtuhhllheskhgvrhhnvghlrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvddtledrkeehrddvudeirddujedunecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefleejtdenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegjfhfhfffkuffvtghsphejsehttdertddttdejnecuhfhrohhmpeetlhgrnhcuvfhulhhluceorghtuhhllheskhgvrhhnvghlrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvddtledrkeehrddvudeirddujedunecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefleejtdenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970295AbeCSSkv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966869AbeCSSkr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 19 Mar 2018 14:40:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F903217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELviI+7pf7N7C6YyYbHVveilVf1iJ9bO3Jg/dLEtatRgb2HXyiuc5UY51hQNTIFqfpw8cfPenz1yNHvAQJW1DpI=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-21-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-21-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 19 Mar 2018 13:40:05 -0500
X-Gmail-Original-Message-ID: <CANk1AXRA81cSJchjzHmzG8QZMZETEppTw7BW3of++20VFcQ3Qw@mail.gmail.com>
Message-ID: <CANk1AXRA81cSJchjzHmzG8QZMZETEppTw7BW3of++20VFcQ3Qw@mail.gmail.com>
Subject: Re: [PATCH v4 20/24] fpga: dfl: add FPGA Accelerated Function Unit
 driver basic framework
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

I acked this back in v2.

> On DFL FPGA devices, the Accelerated Function Unit (AFU), can be
> reprogrammed for different functions. It connects to the FPGA
> infrastructure("blue bistream") via a Port. Port CSRs are implemented
> separately from the AFU CSRs to provide control and status of the Port.
> Once valid green bitstream is programmed into the AFU, it allows access
> to the AFU CSRs in the AFU MMIO space.
>
> This patch only implements basic driver framework for AFU, including
> device file operation framework.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

Alan
