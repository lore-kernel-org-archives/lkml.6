Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4351C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7316F2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7316F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeJRXEj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:04:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56662 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJRXEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:04:39 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 15627CEF9A;
        Thu, 18 Oct 2018 17:10:36 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2 2/4] nfc: pn532_uart: Add NXP PN532 to devicetree docs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181018144251.30028-2-poeschel@lemonage.de>
Date:   Thu, 18 Oct 2018 17:03:13 +0200
Cc:     devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Lei YU <mine260309@gmail.com>,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?utf-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F2B73CDB-434A-41F5-8A9E-3E4E76DB89C9@holtmann.org>
References: <20181018144251.30028-1-poeschel@lemonage.de>
 <20181018144251.30028-2-poeschel@lemonage.de>
To:     Lars Poeschel <poeschel@lemonage.de>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

> Add pn532 to the trivial-devices.txt binding doc.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
> Documentation/devicetree/bindings/trivial-devices.txt | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> index 763a2808a95c..c580be08a380 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> @@ -172,6 +172,7 @@ nxp,pcf2129		Real-time clock
> nxp,pcf8523		Real-time Clock
> nxp,pcf8563		Real-time clock/calendar
> nxp,pcf85063		Tiny Real-Time Clock
> +nxp,pn532-uart		NXP PN532 NFC-/RFID-Chip, using UART interface

is this really such a trivial device? It doesn’t require any GPIO to enable / reset the NFC chip?

Regards

Marcel

