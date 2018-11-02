Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54631C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2C12081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2C12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeKBWlA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:41:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:7458 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBWk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:40:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 06:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="277800362"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2018 06:33:49 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 2 Nov 2018 06:33:49 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 2 Nov 2018 06:33:49 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.84]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.199]) with mapi id 14.03.0415.000;
 Fri, 2 Nov 2018 21:33:47 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     Rob Herring <robh@kernel.org>, lkp <lkp@intel.com>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild-all] make[3]: *** No rule to make target
 'arch/mips/boot/dts/brcm/bcm93384wvg.dtb', needed by '__build'.
Thread-Topic: [kbuild-all] make[3]: *** No rule to make target
 'arch/mips/boot/dts/brcm/bcm93384wvg.dtb', needed by '__build'.
Thread-Index: AQHUcYk70DTujmdwNEO89qaCj6t5vqU67Q4AgAGRJ5A=
Date:   Fri, 2 Nov 2018 13:33:47 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E6624951322036@shsmsx102.ccr.corp.intel.com>
References: <201811011054.ZGhrqvwa%fengguang.wu@intel.com>
 <CAL_JsqJG9AjQVLSLZg_H4-Msq5h8xhtSQqbBikfKXMfD7pwjqA@mail.gmail.com>
In-Reply-To: <CAL_JsqJG9AjQVLSLZg_H4-Msq5h8xhtSQqbBikfKXMfD7pwjqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGI1MGVjNmUtMTFkNi00NGY2LTgyOWYtYjI0NTJhODRiY2ZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZTZaenBvMkN0R2wxK2FOcmFvWU5xRHNVeUVQdEhqN1cyUTJhU1pRMGVjWW0xb1FnQmdXTkh2T1Awc2t1OXBoUCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [kbuild-all] make[3]: *** No rule to make target
> 'arch/mips/boot/dts/brcm/bcm93384wvg.dtb', needed by '__build'.
> 
> On Wed, Oct 31, 2018 at 9:18 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Rob,
> >
> > FYI, the error/warning still remains.
> 
> I replied on another one of these reports that these failures need to
> be fixed by using "CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y" instead of just
> "CONFIG_OF_ALL_DTBS=y" as specifying kconfig options on the command
> line ignores any select or depends AFAICT.
thanks Rob, we will update logic to handle this

> 
> I partially fixed these in some cases by making 'all' only include
> 'dtbs' target when CONFIG_OF_EARLY_FLATTREE is enabled. I'm not
> exactly sure why mips and xtensa still fail.
> 
> Rob
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
