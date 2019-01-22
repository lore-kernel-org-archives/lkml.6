Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E64FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8BF2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfAVK0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:26:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:18936 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726752AbfAVK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:26:20 -0500
X-UUID: 5dcffc7a92c24f98ba8b95a748ad2e53-20190122
X-UUID: 5dcffc7a92c24f98ba8b95a748ad2e53-20190122
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 213331354; Tue, 22 Jan 2019 18:25:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 18:25:52 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 18:25:52 +0800
Message-ID: <1548152752.24552.17.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
From:   Sean Wang <sean.wang@mediatek.com>
To:     Loys Ollivier <lollivier@baylibre.com>
CC:     Sean Wang <sean.wang@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 22 Jan 2019 18:25:52 +0800
In-Reply-To: <86imyh13kb.fsf@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
         <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
         <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com>
         <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
         <86imyh13kb.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 219F940BE4EC650BDC4D949AD58ECD2AA3A36865E4A51A9CA58055DBBBB831A92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 09:47 +0100, Loys Ollivier wrote:
> On Mon 21 Jan 2019 at 18:44, Sean Wang wrote:
> 
> > On Mon, Jan 21, 2019 at 9:29 AM Loys Ollivier <lollivier@baylibre.com> 
> > wrote:
> >>
> >>
> >> On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:
> >>
> >> > On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
> >> >> Add binding for Mediatek-based GNSS receivers.
> >> >>
> >> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >> >> ---
> >> >>
> >> >> v2:
> >> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> >> >> Moved current-speed as an optional propertie.
> >> >> Removed the status line in the example.
> >> >> Added "mediatek,mt3339" compatible.
> >> >>
> >> >>  .../devicetree/bindings/gnss/mediatek.txt          | 39
> >> >>  ++++++++++++++++++++++
> >> >>  1 file changed, 39 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> >> >>
> >> >
> >> > Reviewed-by: Rob Herring <robh@kernel.org>
> >>
> >> Thanks Rob,
> >> If there are no objections by others, I'll stop sending these two patch
> >> (1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
> >> on those two.
> >>
> >
> > Hi Loys,
> >
> > Thanks for adding the first GPS device driver. It's really nice to see
> > more device drivers added to upstream support.
> >
> Hi Sean,
> 
> Glad to know you're supporting this initiative.
> 
> > Do you mind send the series again with Cc linux-mediatek@lists.infradead.org 
> > ?
> >
> The series already has linux-mediatek@lists.infradead.org in Cc. Does it
> need a resend ?
> 

It doesn't need a resend, it's my mistake. thanks for clarifying soon.

> > Sean
> >
> >> --
> >> -L
> >>
> >> _______________________________________________
> >> Linux-mediatek mailing list
> >> Linux-mediatek@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 


