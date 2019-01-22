Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E66C282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2919721721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548126055;
	bh=PFYvwxITMZJrnktk0T8+WI58+cAq0GqRCLh1zXapyeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vEK11F2BBXGLq7T7kiH6whwwESCFZcTesWcPqfOwXwop9gmNlGPd01jHVP5r4plhu
	 hotsnNkZS6qXfCN7vpPDkNx6gT319t7+I3ggg5+QwSD7ru2BgKa41Rug35KA4ipl+r
	 1yY8y2icx6plLv7k5XRBpOJiMXoXDbht5AUr/6d4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfAVDAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfAVDAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:00:52 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA1622085A;
        Tue, 22 Jan 2019 03:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548126051;
        bh=PFYvwxITMZJrnktk0T8+WI58+cAq0GqRCLh1zXapyeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABnSorKqMVdTg/SYPylHgac4p9JabI3zzRcctl6dej4AiHLaCiW0GcPECXeiqHuIc
         85WjLLBazN0m9VTVGgmfrVGoV+k5oXieDQSLvGm/MWVx8RJkvE2OrudbinRYIb7QWX
         ielok1+XIN7Hq08DY4mbTp5PJW6DTvxL0ZUuqYoA=
Date:   Tue, 22 Jan 2019 11:00:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.tropschug@ebs-systart.com" <a.tropschug@ebs-systart.com>,
        "m.bittner@ebs-systart.com" <m.bittner@ebs-systart.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190122030011.GC19233@dragon>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
 <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
 <20190116101441.GH15808@dragon>
 <20190121060950.GA8713@Mani-XPS-13-9360>
 <AM6PR04MB5863AE2A3DD74882BEC680CA8F9F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5863AE2A3DD74882BEC680CA8F9F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 07:57:20PM +0000, Leo Li wrote:
> > > So it seems the compatible of the boards below are missing there.
> > >
> > >   ls1021a-moxa-uc-8410a.dts
> > >   ls1021a-qds.dts
> > >   ls1021a-twr.dts
> > 
> > So how should we proceed here? The above mentioned boards are lacking
> > compatible in dts files and I guess that's the reason they didn't get
> > mentioned in "fsl" binding file.
> > 
> > Should I just go ahead and add the compatibles for these boards and list
> > them in binding file?
> 
> Please go ahead and do that.  One thing is that the moxa-uc-8410a board is a 3rd-party board, not sure if it should belong to the fsl binding file.

The fsl.yaml is designed to contain various boards using fsl SoCs, so
it's fine.

Shawn
