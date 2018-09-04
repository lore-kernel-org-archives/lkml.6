Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13672C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10AA20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10AA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeIDIwl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:52:41 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62595 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeIDIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:52:41 -0400
X-IronPort-AV: E=Sophos;i="5.53,327,1531810800"; 
   d="scan'208";a="17134853"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Sep 2018 21:29:26 -0700
Received: from CHN-SV-EXMX06.mchp-main.com ([fe80::c5f4:117d:550d:f375]) by
 chn-sv-exch03.mchp-main.com ([fe80::9916:1afa:df82:7a64%13]) with mapi id
 14.03.0352.000; Mon, 3 Sep 2018 21:29:26 -0700
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <stefan.wahren@i2se.com>, <Woojung.Huh@microchip.com>
CC:     <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4 next] net: lan78xx: Switch to SPDX identifier
Thread-Topic: [PATCH 3/4 next] net: lan78xx: Switch to SPDX identifier
Thread-Index: AQHUQ6lkx4ZgI85Q5kuCL2/ljWwcN6Tfh6kA
Date:   Tue, 4 Sep 2018 04:29:25 +0000
Message-ID: <0573C9D4B793EF43BF95221F2F4CC8515912C3@CHN-SV-EXMX06.mchp-main.com>
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
 <1535994759-8938-4-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1535994759-8938-4-git-send-email-stefan.wahren@i2se.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.215.7]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2015 Microchip Technology */

Can we merge both in single comment line?

> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (C) 2015 Microchip Technology */

Here too.

Thanks,
-Raghu
