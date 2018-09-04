Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA955C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D0B2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D0B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeIDIqK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:46:10 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40610 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeIDIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:46:10 -0400
X-IronPort-AV: E=Sophos;i="5.53,327,1531810800"; 
   d="scan'208";a="19296608"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 03 Sep 2018 21:22:56 -0700
Received: from CHN-SV-EXMX06.mchp-main.com ([fe80::c5f4:117d:550d:f375]) by
 CHN-SV-EXCH01.mchp-main.com ([fe80::9840:ffdf:ec5:1335%29]) with mapi id
 14.03.0352.000; Mon, 3 Sep 2018 21:22:55 -0700
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <stefan.wahren@i2se.com>, <Woojung.Huh@microchip.com>
CC:     <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4 next] net: lan78xx: Drop unnecessary strcpy in
 lan78xx_probe
Thread-Topic: [PATCH 2/4 next] net: lan78xx: Drop unnecessary strcpy in
 lan78xx_probe
Thread-Index: AQHUQ6lkB4mNjAbRaEqwM43G+H6wfqTfhedA
Date:   Tue, 4 Sep 2018 04:22:54 +0000
Message-ID: <0573C9D4B793EF43BF95221F2F4CC85159128E@CHN-SV-EXMX06.mchp-main.com>
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
 <1535994759-8938-3-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1535994759-8938-3-git-send-email-stefan.wahren@i2se.com>
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

> There is no need for this strcpy because alloc_etherdev() already does this
> job.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Raghuram Chary Jallipalli <raghuramchary.jallipalli@microchip.com>

Thanks,
-Raghu
