Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38957ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0C221480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BkirTCt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0C221480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeIXLtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 07:49:01 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47916 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIXLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 07:49:01 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B2CDA10C1B7F;
        Sun, 23 Sep 2018 22:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537768116; bh=IoRalXqWCpKStuxNRuQwzo96ai/5f9mHti7oLAFVGL0=;
        h=From:To:CC:Subject:Date:References:From;
        b=BkirTCt/N8ZjuVsFjdiI3ZiLCEfdDxnYntnskFShsEJuN69DH1eYFgQFiJiPkChA4
         27tGrWeBbwlyP38LeU52uogrboPSQem6cp8mAcSc/6zdj7qkdJXIfqmCCDALw09OPE
         UtSpT6sFsHi6T+4TeNFNY3BOnn8ZortQkL8yQ2Hhn7k4pLqB5pWnrALk9TQ8VgOCb8
         X0PHOw2Sh9iXxXJqr5CQ0igxKe6ezb8bh7qxXmwFdv8ifcHA55BRGzo2GTwIHF2MhY
         7Qv4YviTamYuDJn71Wmk5T0vWoISUsOBEvL9hSMDs6pSJbimJhMcHhMPckaazVsLLp
         ZHh9A6RptP37Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 83462544D;
        Sun, 23 Sep 2018 22:48:36 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Sun, 23 Sep 2018 22:48:36 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 24 Sep 2018 09:48:33 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Josh Abraham <j.abraham1776@gmail.com>,
        "minas.harutyunyan@synopsys.com" <minas.harutyunyan@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: remove set but unused variable
Thread-Topic: [PATCH] usb: dwc2: remove set but unused variable
Thread-Index: AQHUU6fADWAQ1VQbckOw3LwUeN7/Cw==
Date:   Mon, 24 Sep 2018 05:48:33 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A76F5B9@am04wembxa.internal.synopsys.com>
References: <20180924014135.GA27711@josh-ThinkPad-T460s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.57]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2018 5:41 AM, Josh Abraham wrote:=0A=
> This patch removes a set but unused variable in hcd.c.=0A=
> =0A=
> Fixes gcc warning:=0A=
> variable =91data_fifo=92 set but not used [-Wunused-but-set-variable]=0A=
> =0A=
> Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>=0A=
> ---=0A=
>   drivers/usb/dwc2/hcd.c | 3 ---=0A=
>   1 file changed, 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c=0A=
> index 2bd6e6bfc241..5f23b933cafc 100644=0A=
> --- a/drivers/usb/dwc2/hcd.c=0A=
> +++ b/drivers/usb/dwc2/hcd.c=0A=
> @@ -1328,14 +1328,11 @@ static void dwc2_hc_write_packet(struct dwc2_hsot=
g *hsotg,=0A=
>   	u32 remaining_count;=0A=
>   	u32 byte_count;=0A=
>   	u32 dword_count;=0A=
> -	u32 __iomem *data_fifo;=0A=
>   	u32 *data_buf =3D (u32 *)chan->xfer_buf;=0A=
>   =0A=
>   	if (dbg_hc(chan))=0A=
>   		dev_vdbg(hsotg->dev, "%s()\n", __func__);=0A=
>   =0A=
> -	data_fifo =3D (u32 __iomem *)(hsotg->regs + HCFIFO(chan->hc_num));=0A=
> -=0A=
>   	remaining_count =3D chan->xfer_len - chan->xfer_count;=0A=
>   	if (remaining_count > chan->max_packet)=0A=
>   		byte_count =3D chan->max_packet;=0A=
> =0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
