Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB00C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9690620882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="leBhB3kW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9690620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeIMLon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:44:43 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42220 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeIMLon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:44:43 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3EEA724E0553;
        Wed, 12 Sep 2018 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536820599; bh=HctmKa80FS49REToCIkh9engEjioxCLssssIg6xwgBA=;
        h=From:To:CC:Subject:Date:References:From;
        b=leBhB3kWH2p4b0ZG/U3uPBmGdFYFysqZHuv0uhZDzVUSS7E73wAEae5Fo9Mz7enrV
         4T+cR6X3G7X7CnSVlF53xyp0rdrAQdIJo0u8L6kJFuuPD5N7fynmpIoQG4zINEd5PC
         Qjv2v5R/t6e5hQmiSnqrxCSIYxBOcx7t+St+IIowlnKCocyb6Y58HtWBS4MUz+cgOr
         ypE8W/wMrr2OpqrJ9O8cjJ4XgsSFVOMgja0IGmIOK9avyEhuciSO4vDOkCCVpwUnSv
         hYw13bXERUbiOtwpYXYeXIP+gA9LCsWp7pkNzSEUi495cGnv+oJVySIdimDoOHraMc
         thnGXeXDa+NDQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 08ABD3E3D;
        Wed, 12 Sep 2018 23:36:39 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 12 Sep 2018 23:36:38 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 13 Sep 2018 10:36:36 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Josh Abraham <j.abraham1776@gmail.com>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: remove set but unused variable
Thread-Topic: [PATCH] usb: dwc2: remove set but unused variable
Thread-Index: AQHUSsS0IZp2wfB40U2wTqsBZDms6g==
Date:   Thu, 13 Sep 2018 06:36:35 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A769BC4@am04wembxa.internal.synopsys.com>
References: <20180912181610.GA31006@josh-ThinkPad-T460s>
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

On 9/12/2018 10:16 PM, Josh Abraham wrote:=0A=
> This patch removes a set but unused variable in hcd.c.=0A=
> =0A=
> Fixes warning:=0A=
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
