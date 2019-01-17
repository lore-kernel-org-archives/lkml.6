Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14762C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00F820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DFjrH/bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfAQUxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:53:01 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:59106 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfAQUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:53:01 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E090424E09A1;
        Thu, 17 Jan 2019 12:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547758380; bh=lDzq70cb6IvF3R3DvKmgmdn3mJzChoRiXfzffEa4x7o=;
        h=From:To:CC:Subject:Date:References:From;
        b=DFjrH/biofY2TFVVE4QuGIrhHaDw0U0MvCoanNfvb1U8DA4JlLVtGk7R2AnVBAquo
         RLWkFJ2/OtVSfew3WwgTDnj3PqxilzxYx3L4aiYpbt6MvtDqBWNS3gP7/W5OjeOHqN
         ipW3qVFflBjMHWdrIErgaU2WTrd2rkaaAgbupxUJzsdgMzRIaUaUpx/87AcXJGvwJY
         YUzacUHj6SyR48C4LPqm7SO1XqOEoAlY3SiGsMyLsa2llCSkvF41jH+Y/zE5IswJvC
         1Oq1YMRjYBS9M+5FaA5/deMXeFpvsYr74ZMBfaiIYwKw4vJQ8Oq9nJ6snFngRvil4j
         v7ffkvfkvV3xQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 41B835AB5;
        Thu, 17 Jan 2019 12:53:00 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 17 Jan 2019 12:52:48 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: linux-next: Fixes tag needs some work in the arc-current tree
Thread-Topic: linux-next: Fixes tag needs some work in the arc-current tree
Thread-Index: AQHUrqPiSgzi2OhFxkietuZyhXRwng==
Date:   Thu, 17 Jan 2019 20:52:47 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464292E3@US01WEMBX2.internal.synopsys.com>
References: <20190118073257.5809b05f@canb.auug.org.au>
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

On 1/17/19 12:33 PM, Stephen Rothwell wrote:=0A=
> Hi Vineet,=0A=
>=0A=
> Commit=0A=
>=0A=
>   8e542d2a28c9 ("ARC: adjust memblock_reserve of kernel memory")=0A=
>=0A=
> Fixes tag=0A=
>=0A=
>   Fixes: 9ed68785f7f ("ARC: mm: Decouple RAM base address from kernel lin=
k addr")=0A=
>=0A=
> has these problems:=0A=
>=0A=
>   - SHA1 should be at least 12 digits long=0A=
>=0A=
=0A=
Thx for the report Stephen. Now fixed and pushed !=0A=
=0A=
-Vineet=0A=
