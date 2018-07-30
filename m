Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C5416256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B9420857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DtcGemKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B9420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeG3SXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:23:25 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40649 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeG3SXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:23:25 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 93D0C10C05D8;
        Mon, 30 Jul 2018 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532969254; bh=e9Pn6eAKVzcNz8wuIwqGc/8Ik1oaai3lJfLi9R32QdI=;
        h=From:To:CC:Subject:Date:References:From;
        b=DtcGemKrWWcmfxsbjS112K23TlZ0VUzg4iZJbTqRFvEUIY4kI8I228a9DTmSFQMcA
         DsXsl7pMja8mXVMxC4j+CewxLhCdXA6fsxmTeBbOmjrVBcggOIhcE9onncjwBJxQ1P
         O50Ye0BZOsVytXscJRCRyo4yoln4eaVPx0vrHYm3+VVqFkQ1oT57yiQyHWbgl4oMAg
         CkNgqSHCVx0j+5nO9+iwN8WR4JpCaCepjAD9mO70R3NXiqoOlXHzFtOFvDDGIk7WFN
         3zEzXme+4lDwLvj1y8+8pmjK1Os69O2uKl52qiSrjrrdY8hXPqU+Ati/s++fCHBj43
         m9AjFxZBx3avA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2F8783A31;
        Mon, 30 Jul 2018 09:47:34 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Mon, 30 Jul 2018 09:47:33 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arc-current
 tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the
 arc-current tree
Thread-Index: AQHUJuHSBble61r5mE2spp6XMOEQDw==
Date:   Mon, 30 Jul 2018 16:47:32 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08828A@us01wembx1.internal.synopsys.com>
References: <20180729121351.26912f3c@canb.auug.org.au>
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

On 07/28/2018 07:14 PM, Stephen Rothwell wrote:=0A=
> Hi Vineet,=0A=
>=0A=
> Commit=0A=
>=0A=
>   fa52704e2816 ("ARC: add SMP_CACHE_BYTES value validate")=0A=
>=0A=
> is missing a Signed-off-by from its committer.=0A=
=0A=
Thx for the report Stephen.=0A=
=0A=
This is now fixed/pushed.=0A=
=0A=
-Vineet=0A=
