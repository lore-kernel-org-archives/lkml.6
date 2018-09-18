Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28829ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF27C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF27C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeIRRrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:47:43 -0400
Received: from shell.v3.sk ([90.176.6.54]:53170 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbeIRRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:47:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1FC8DB93E6;
        Tue, 18 Sep 2018 14:15:20 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id M3tDyAnrbc81; Tue, 18 Sep 2018 14:15:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C5A30B93E8;
        Tue, 18 Sep 2018 14:15:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TOv2qfEv_OLz; Tue, 18 Sep 2018 14:15:14 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0F385B93E6;
        Tue, 18 Sep 2018 14:15:13 +0200 (CEST)
Message-ID: <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
Subject: Re: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Tue, 18 Sep 2018 14:15:12 +0200
In-Reply-To: <20180917175753.GE2471@sirena.org.uk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
         <20180917113559.11101-2-lkundrak@v3.sk>
         <20180917175753.GE2471@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 10:57 -0700, Mark Brown wrote:
> On Mon, Sep 17, 2018 at 01:35:55PM +0200, Lubomir Rintel wrote:
> > This is the SPI controller found on Marvel MMP2 and perhaps more
> > platforms.
> 
> I'm missing patches 2 and 5 from this series.  What's going on with
> them, are there any dependencies?

Sorry, I was not sure how to Cc people properly. I haven't dealt with a
patchset that spanned multiple subsystems before.

I thought it might have been a good idea to add individual people
suggested by get_maintainer.pl in commits' "Cc:" tag, while passing the
lists to --cc argument of git send-email.

Should I've Cc'd everyone on the full series, even if only a patch or
two might be really interesting to them? How do I decide whether the
recipient needs to be in the commit's commit message (as opposed to
just --cc on a command line)?

https://lore.kernel.org/lkml/20180917113559.11101-1-lkundrak@v3.sk/

> 
> > Changes since v1:
> > - s/ssp@d4035000/spi@d4035000/
> 
> As covered in SubmittingPatches please put inter-version changelogs
> after the --- so they don't end up in the commits.

Will do. I was actually not sure about that, so I took a short look at
the git log, and it seemed to me that commit messages with the
changelogs are quite common.

Thanks you,
Lubo

