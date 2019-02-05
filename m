Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C86FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D5320844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e7P1dUrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfBEQoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:44:20 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:43918 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfBEQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:44:20 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 6570E24E2856;
        Tue,  5 Feb 2019 08:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549385059; bh=VJ+lLsZ2Qzdrap6dipPJuWZmGsr/3zBuPWH7afvW75U=;
        h=From:To:CC:Subject:Date:References:From;
        b=e7P1dUrO2zoXfjQALOs6tnBYsDXptDRYSSj+V4d5u1oT3UyoE+BAg7m5uvH9BS4c6
         cYuUI9vJOU72SJiEi9vk/pb9+1Hze22JdYQAIjy0UYW1zhfIn+dxraGJpl7VULXhF9
         JFbv1NxpFhcYuKeCXpw7OauRXxHDYJKbb8dUmSCx0cDAvSLcoIYK6A8kdIsd38OapB
         afMStJlmXuJHWrGqck2mdrO1AR1jbeQAOy9Mpvsf1NW07rbnGgZ2qhzMzzIN7wxqLv
         3mhVQu2H4sTfvSmiCz7rK2yVBydlW8Z1psV77tTf7qS8SvK18gyRxG65XevKD/0GS9
         kdVr0IdkMRXfQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 95275A005D;
        Tue,  5 Feb 2019 16:44:18 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Tue, 5 Feb 2019 08:42:29 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "clabbe@baylibre.com" <clabbe@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 2/2] arc: hsdk_defconfig: enable CONFIG_ARC_UBOOT_SUPPORT
Thread-Topic: [PATCH 2/2] arc: hsdk_defconfig: enable
 CONFIG_ARC_UBOOT_SUPPORT
Thread-Index: AQHUvS1W/qxlIHeYE0afZ24Gfv1vzA==
Date:   Tue, 5 Feb 2019 16:42:28 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642EBE9@US01WEMBX2.internal.synopsys.com>
References: <1549355535-22052-1-git-send-email-clabbe@baylibre.com>
 <1549355535-22052-3-git-send-email-clabbe@baylibre.com>
 <1549366931.27724.26.camel@synopsys.com>
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

On 2/5/19 3:42 AM, Eugeniy Paltsev wrote:=0A=
> Hi Corentin,=0A=
>=0A=
> In case of devboards (like HSDK) we really often disable bootloader and l=
oad=0A=
> Linux image in memory via JTAG. Enabling CONFIG_ARC_UBOOT_SUPPORT by=0A=
> default will break it as we will try to interpret some junk in a register=
s=0A=
> as a pointers to bootargs/etc which aren't set by anyone in case of JTAG =
using.=0A=
>=0A=
> So it isn't a good idea to have CONFIG_ARC_UBOOT_SUPPORT enabled by defau=
lt.=0A=
=0A=
Right.=0A=
=0A=
It is difficult to accommodate everyone's needs (often conflicting) in a si=
ngle=0A=
defconfig.=0A=
Can you folks create an out-of-tree defconfig or some such.=0A=
=0A=
-Vineet=0A=
