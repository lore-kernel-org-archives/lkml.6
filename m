Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379FCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4DB214DB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IB0xFeMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4DB214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeLERN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:13:56 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:38818 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLERN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:13:56 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 24FF424E16F3;
        Wed,  5 Dec 2018 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544030036; bh=DWXJNEU1sR1ZEEzw7Uqqi5gJAcVn2mDg7j4zlIH83BA=;
        h=From:To:CC:Subject:Date:References:From;
        b=IB0xFeMryrBGdQ+yhbS33YxDYoB64wQjbQybZLNAMQ5pTP3FJkLjgZFbv+2hhkZIX
         eqdeLELe1cpb9AW7OD+voivZ0dMIPccA1g9qLotoowULDDUXtvtfQD7LpOEIgJ2kXo
         vHVB5L3a+r/iW7EcrZDJCkUdjfMIt3FMKjewreVLEul2orZYE+Jk8Rx2VdAVLdDfMl
         FSm/C89+VnOiIlbTbnWX1deKu1jD6VYDa/LO2fEZ5+Y3RjZ2r/n2Lrn69saFen19GL
         XTxTiXDmmWtUUOOE+uKoMNkNqggN1rWnVYFIosWCsBaJGflq6HVPfWLEmqAV9HeUFs
         4zh3IqP0uD/fQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id F36A730FC;
        Wed,  5 Dec 2018 09:13:55 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 09:13:55 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/5] ARC: perf: fix description comment
Thread-Topic: [PATCH 4/5] ARC: perf: fix description comment
Thread-Index: AQHUjLzjZ5gYwzzQWk6w3ya36JgiMw==
Date:   Wed, 5 Dec 2018 17:13:55 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641B8F6@US01WEMBX2.internal.synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
 <20181205170609.18690-5-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 9:06 AM, Eugeniy Paltsev wrote:=0A=
> Fix description comment as this code doesn't belong only to=0A=
> ARC700 anymore.=0A=
>=0A=
> Also while I'm at it, use SPDX License Identifier.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
Maybe squash this into trivial cleanups 1/5 ?=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
