Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5873C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4147208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qca.qualcomm.com header.i=@qca.qualcomm.com header.b="zkrrek7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4147208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qca.qualcomm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeIYMwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:52:54 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:16477 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbeIYMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:52:54 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2018 08:52:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1537858010; x=1569394010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XIxDgzKR5ltseloWCTyqFhqRp0Kbjp0ORMsdAorSuoY=;
  b=zkrrek7XTUDwM3cnV//MVvrTAyB+PFL2eheOkyWqOfZ/FfGI0h6L3L75
   Use8Tfvf/mEtxKQ/1CdPSM9eBjbpHULVFUSHmNCIs6kwCwgXxSlL8wJGu
   lhe8LZLrZGO3fptM3IDcWVdLusdlFvh4lp6R1QGswrQYvWy7tAXGxXCUV
   Y=;
X-IronPort-AV: E=Sophos;i="5.54,301,1534802400"; 
   d="scan'208";a="1216936"
Received: from ironmsg01-ams.qualcomm.com ([10.251.56.2])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 25 Sep 2018 08:40:36 +0200
X-IronPort-AV: E=McAfee;i="5900,7806,9026"; a="5564470"
Received: from euamsexm01a.eu.qualcomm.com ([10.251.127.40])
  by ironmsg01-ams.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Sep 2018 08:40:36 +0200
Received: from euamsexm01a.eu.qualcomm.com (10.251.127.40) by
 euamsexm01a.eu.qualcomm.com (10.251.127.40) with Microsoft SMTP Server (TLS)
 id 15.0.1365.1; Tue, 25 Sep 2018 08:40:34 +0200
Received: from euamsexm01a.eu.qualcomm.com ([10.251.127.40]) by
 euamsexm01a.eu.qualcomm.com ([10.251.127.40]) with mapi id 15.00.1365.000;
 Tue, 25 Sep 2018 08:40:34 +0200
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     Philip Li <philip.li@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>, "lkp@01.org" <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [0-Day CI notification] 0-Day CI test service will be unavailable
 from Sep 30 to Oct 8
Thread-Topic: [0-Day CI notification] 0-Day CI test service will be
 unavailable from Sep 30 to Oct 8
Thread-Index: AQHUVJqpnX9ssyO6JUWN8UTXi4Z1Og==
Date:   Tue, 25 Sep 2018 06:40:34 +0000
Message-ID: <875zyu3wrl.fsf@qca.qualcomm.com>
References: <20180925043238.GA14135@intel.com>
In-Reply-To: <20180925043238.GA14135@intel.com> (Philip Li's message of "Tue,
        25 Sep 2018 12:32:38 +0800")
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.106.107.6]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Li <philip.li@intel.com> writes:

> Hi all, this is Philip who maintains the 0-Day CI test service. Thanks fo=
r
> subscribing to the service. We will have site level power down during Chi=
na
> national holiday, so the service will be unavailable from Asia Pacific Ti=
me
> Sep 30 5PM to Oct 8 5PM. We will recover it as soon as we can. Sorry for =
any
> inconvenience caused during this period.

I so much rely on the 0-day reports that being without it for a week
sounds horrible :) I hope you get it up quickly after the power down.

--=20
Kalle Valo=
