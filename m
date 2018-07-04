Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB40C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D9C240F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mork.no header.i=@mork.no header.b="ZL+PeDG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D9C240F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeGDQ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:27:29 -0400
Received: from canardo.mork.no ([148.122.252.1]:47147 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752435AbeGDQ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:27:27 -0400
Received: from [IPv6:2001:4641:0:2:4172:2f86:7bbb:7cf7] ([IPv6:2001:4641:0:2:4172:2f86:7bbb:7cf7])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w64GRMo2019629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 4 Jul 2018 18:27:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1530721642; bh=dYBzvm6ScL6L4grDeqoR2BDOb9ZEnmmqP7H64PbdsWU=;
        h=Date:References:Subject:To:CC:From:Message-ID:From;
        b=ZL+PeDG1fplnY+SFFDtjTJQroKsCVM31qrOht0lSBHsFvHeyZ1mr8QmXrZT5F7lb2
         vjk1t25YYogq8usXkeeE4fg0YTwOKLYeuW6aks8KQ2ckB/9Sm8JKcf6r/TswJGkmcL
         hWc5eUJKEyxGtLZ5V7gtCeFXUR9zvMRZI5G/DzSI=
Date:   Wed, 04 Jul 2018 18:27:20 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <1530720768-18349-1-git-send-email-vucnikm@gmail.com>
References: <1530720768-18349-1-git-send-email-vucnikm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] qmi_wwan: add support for Quectel EG91
To:     Matevz Vucnik <vucnikm@gmail.com>
CC:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From:   =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
Message-ID: <30495A1F-1CC9-48AE-9C33-3800C812305B@mork.no>
X-Virus-Scanned: clamav-milter 0.99.3 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 4, 2018 6:12:48 PM GMT+02:00, Matevz Vucnik <vucnikm@gmail=2Ecom> =
wrote:
>This adds the USB id of LTE modem Quectel EG91=2E It requires the
>same quirk as other Quectel modems to make it work=2E
>
>Signed-off-by: Matevz Vucnik <vucnikm@gmail=2Ecom>

Acked-by: Bj=C3=B8rn Mork <bjorn@mork=2Eno>
