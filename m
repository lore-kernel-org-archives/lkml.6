Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A054C282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D5120861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548125695;
	bh=0Bc2Hya4AhZ1WFQa8qP8yHLVN3F+wu+za9vGUaYImqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uNVZGmpgu17AkT3yqTqLqd/GawvP5cxMoGDA0+uFu84drmhzasNQTmvxfC+ZUmQGe
	 yvks8KZKwCqp1L0wNKLQdVypzDfg055O/QkCsxEmCbzW38++jj9gRbjPqaLPqCvlfd
	 CeFpREZnVB1c9vjJXwHG9dalgtIbQzM+muI+ScsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfAVCyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfAVCyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:54:37 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02B720861;
        Tue, 22 Jan 2019 02:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548125676;
        bh=0Bc2Hya4AhZ1WFQa8qP8yHLVN3F+wu+za9vGUaYImqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ks7CkrCcEla97LkHgmyf5LVo6cY5frOTT6crYVBHMqOK4N7TtrgeXtO/9slosHnXE
         MfiEQ1TmlOMgFRbJ9R2jtfnuM42Vik88WgXSJG5e5lyvpIM0seANA8xpmfkG4C4vQM
         DRXfgINOXxzZaq3Sx3/8UEGZThwOehL2x37upjyA=
Date:   Tue, 22 Jan 2019 10:53:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Message-ID: <20190122025355.GA19233@dragon>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
 <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20190116105559.GM15808@dragon>
 <VI1PR0402MB28007817A29E6116D1FAFC2BE0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <VI1PR0402MB2800477D1F1FE0E78F1D8D33E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2800477D1F1FE0E78F1D8D33E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:31:46PM +0000, Ioana Ciornei wrote:
> > > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> > > platforms
> > >
> > > On Wed, Jan 16, 2019 at 10:02:01AM +0000, Ioana Ciornei wrote:
> > > > > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for
> > > > > DPAA2 platforms
> > > > >
> > > > > On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > > > > > Add the dpaa2-console device tree node for the following
> > > > > > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> > > > > >
> > > > > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > > > >
> > > > > DTS patch generally goes to the last in a series.
> > > >
> > > > Should I resend this with the DTS patch the last?
> > >
> > > You do not have to resend the series only for this.  It's pretty much
> > > a suggestion for future posting.
> > 
> 
> One more thing, do you have any other feedback on the DTS part?
> I think the best path for this patch set is through Leo's fsl soc tree but of course we need an ack from the DTS part also.

I do not see there is a hard dependency between driver and dts part,
e.g. build error or causing regression.  In that case, dts should just
go via its channel.

Shawn
