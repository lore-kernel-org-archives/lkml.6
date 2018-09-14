Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78504ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BC220833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CynIGLW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BC220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeINWtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:49:11 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:40772 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbeINWtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:49:11 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EF31C10C07C9;
        Fri, 14 Sep 2018 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536946422; bh=lB508quNrRYeHSV6+exx6tNFCyY3ys/UuepnJnpwvlc=;
        h=From:To:CC:Subject:Date:References:From;
        b=CynIGLW28Y1RLwMTz+riqfQwD/VQvLThov1VJwbWgPytHmgn+fq5nKklpdOrE6pFT
         r0CGD/PO0ib6wGS6fl8d+/AqzITuYKgpDqbxMDrcSrVg0yPUo1dWMtmt+oioMy+evS
         efpMimt1n0p9ziqkIg/S07wR9KxA47HT8g8TmpqeaF5WFPeSDM6yuuLUWnd+rbAXd1
         brdgBHmKhS6SyVxjDG5vU9/sv/cnV0E6cvX85puUvOqZB32UsRSJyPHW6+Oo4BpE/2
         miOAcObBF8kpoF4+6MERi4F/GnynfHmcjpU8kZgqris/w69uUoQp3BrYMpq9HsJb5u
         gcoKsyveHrW7Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id B8EA6577A;
        Fri, 14 Sep 2018 10:33:41 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Fri, 14 Sep 2018 10:33:39 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Colin King <colin.king@canonical.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: fix spelling mistake "entires" -> "entries"
Thread-Topic: [PATCH] ARC: fix spelling mistake "entires" -> "entries"
Thread-Index: AQHUTB3t4Q8GT4j7kEKFzY9rBbPAgg==
Date:   Fri, 14 Sep 2018 17:33:38 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B095203@us01wembx1.internal.synopsys.com>
References: <20180914112727.4276-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 04:27 AM, Colin King wrote:=0A=
> From: Colin Ian King <colin.king@canonical.com>=0A=
>=0A=
> Trivial fix to spelling mistake in Kconfig=0A=
>=0A=
> Signed-off-by: Colin Ian King <colin.king@canonical.com>=0A=
=0A=
Applied !=0A=
=0A=
Thx,=0A=
-Vineet=0A=
