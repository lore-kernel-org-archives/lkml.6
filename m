Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2378AC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56C22086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkzAPtg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56C22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeINBdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbeINBdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:33:10 -0400
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com [209.85.161.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461D520C0A;
        Thu, 13 Sep 2018 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536870127;
        bh=J7DCk9nceq9oh1NpPx9/2yCEBtqEge+qNVpiJYH2wkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hkzAPtg5mge2O1fWJBhNaYn4jgg21MRfnFt2AMcG+JPEOfvhzj7Bd6W+fXMP4v1BK
         TDuNia230XFVJpjqxpXYlozPccvEBnZQx5qcJxSeGf4sA4/gL3v2T/iebDK7ZF8Tcd
         olMK6rM+//Sl5qEDd9vAOnUvuiJ7aR8dPsmHOjwI=
Received: by mail-yw1-f45.google.com with SMTP id l189-v6so1725436ywb.10;
        Thu, 13 Sep 2018 13:22:07 -0700 (PDT)
X-Gm-Message-State: APzg51B848AWEeh4gxJxW+MIpMg/wqhk3rbhs/2mw5o2AsGUqscfa0Xb
        CtIICy4nKKqsTfylpB/CRB70p47MSruJUX1e/Zk=
X-Google-Smtp-Source: ANB0VdbUGN6/j9B5YKYui9QIThtKmFrO6HnxL95Ar/ft3h5wHDiGNGH51iBxeZROGIXvndwlr9U/JUqvyqSJhECQZPk=
X-Received: by 2002:a81:578e:: with SMTP id l136-v6mr4265671ywb.396.1536870126500;
 Thu, 13 Sep 2018 13:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180911123732.32579-1-colin.king@canonical.com>
In-Reply-To: <20180911123732.32579-1-colin.king@canonical.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 13 Sep 2018 15:21:30 -0500
X-Gmail-Original-Message-ID: <CANk1AXTxBtMEJo0NTW9g0GeMX8-RTcD_PJ2eyqkYyCtw-u_9Mw@mail.gmail.com>
Message-ID: <CANk1AXTxBtMEJo0NTW9g0GeMX8-RTcD_PJ2eyqkYyCtw-u_9Mw@mail.gmail.com>
Subject: Re: [PATCH] fpga: region: fix spelling mistake "partion" -> "partition"
To:     Colin King <colin.king@canonical.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 7:37 AM Colin King <colin.king@canonical.com> wrote:

Hi Colin,

>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in the documentation

I took a look, there's other misspellings in this doc.  I'd like to
get them all in one patch if possible.  If I have time I'll add them
to this patch or if you have time, you can.

Alan

>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index 6db8aeda461a..71beb85b56f1 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -484,7 +484,7 @@ It is beyond the scope of this document to fully describe all the FPGA design
>  constraints required to make partial reconfiguration work[1] [2] [3], but a few
>  deserve quick mention.
>
> -A persona must have boundary connections that line up with those of the partion
> +A persona must have boundary connections that line up with those of the partition
>  or region it is designed to go into.
>
>  During programming, transactions through those connections must be stopped and
> --
> 2.17.1
>
