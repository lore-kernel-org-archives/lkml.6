Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8FDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AD820685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAJQRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:17:13 -0500
Received: from muru.com ([72.249.23.125]:33080 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfAJQRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:17:13 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BA52A80E7;
        Thu, 10 Jan 2019 16:17:18 +0000 (UTC)
Date:   Thu, 10 Jan 2019 08:17:09 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2] ARM: dts: omap3-gta04: Fix graph_port warning
Message-ID: <20190110161709.GZ5544@atomide.com>
References: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com>
 <CAL_JsqLhGGx_amtDSZh3OJ+Tq-Oziu450NOt4Z+aoQMt-JY46Q@mail.gmail.com>
 <20190109213903.GV5544@atomide.com>
 <8674356B-8688-49B6-AB72-16A991124A73@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8674356B-8688-49B6-AB72-16A991124A73@goldelico.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190110 05:31]:
> 
> > Am 09.01.2019 um 22:39 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > * Rob Herring <robh@kernel.org> [190109 19:38]:
> >> On Wed, Jan 9, 2019 at 1:02 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>> 
> >>> From: Tony Lindgren <tony@atomide.com>
> >>> 
> >>> We're currently getting a warning with make dtbs:
> >>> 
> >>> arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning (graph_port):
> >>> /ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
> >>> address error, expected "0"
> >>> 
> >>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> >>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> 
> >> Acked-by: Rob Herring <robh@kernel.org>
> > 
> > Nikolaus, care to reply with your Signed-off-by since
> > you also edited the patch?
> 
> Sorry, I forgot (too busy with other topics)...
> 
> Here:
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks applying into omap-for-v5.0/fixes.

Tony
