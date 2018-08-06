Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2663BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D525421A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJnQ6StK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D525421A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbeHFRYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbeHFRYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:24:40 -0400
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com [209.85.216.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF43A21A56;
        Mon,  6 Aug 2018 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568507;
        bh=ESQjGEI5PGW7PE4gaTHvUdHk0/agU9lq0+5RsgFmsZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jJnQ6StKTz74D3T0Z4UyHTMg/cyFlWGMHwwpXCW4hSbbQBeuhmjoyMAdjc88eK3nI
         sZaSkVoas7B63XhuwdCjfi4jFexaEi7J9tbky90RANv73e1FXJB8V7Lgm+mKch1eAK
         1r39QWSIl4weeQzzRKf/tdepgW/ZkBo8+SHMapSQ=
Received: by mail-qt0-f181.google.com with SMTP id b15-v6so14152639qtp.11;
        Mon, 06 Aug 2018 08:15:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlE2ZMe2AAjQOj5TUd21VxntFFAa05r+vdr+06h1KIIcAvR3C+Xb
        9H8y4lN3P6y3iKmoOa2hC8/x21saBw1CtCJydQ==
X-Google-Smtp-Source: AAOMgpe//wKERl/pGMnDQnhURHagtn6KPVZjvY8uIMPwFDXXnfQ54AJVwQbnBMWSnXr+jTlVdLJQqLF6qS6iCvkeo+w=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr15441740qta.60.1533568506083;
 Mon, 06 Aug 2018 08:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-7-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-7-songjun.wu@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 09:14:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyuFsfXsG7g10D5g1uLXrFHJ9rdHc97AP9G+pj88v+xg@mail.gmail.com>
Message-ID: <CAL_JsqLyuFsfXsG7g10D5g1uLXrFHJ9rdHc97AP9G+pj88v+xg@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] MIPS: dts: Change upper case to lower case
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> All the upper case in unit-address and hex constants are
> changed to lower case according to the Linux conventions.

It is DT conventions, not Linux.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2: None
>
>  arch/mips/boot/dts/lantiq/danube.dtsi   | 42 ++++++++++++++++-----------------
>  arch/mips/boot/dts/lantiq/easy50712.dts | 14 +++++------
>  2 files changed, 28 insertions(+), 28 deletions(-)
