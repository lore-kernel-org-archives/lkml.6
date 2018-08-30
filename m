Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433BEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5B620666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5B620666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH3FJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:09:46 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22720 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725758AbeH3FJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:09:46 -0400
X-UUID: af9c8fa33953486cab518cd4528a13c2-20180830
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 34517731; Thu, 30 Aug 2018 09:09:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 30 Aug
 2018 09:09:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 30 Aug 2018 09:09:53 +0800
Message-ID: <1535591392.32173.30.camel@mhfsdcap03>
Subject: Re: [PATCH 1/6] usb: xhci-mtk: resume USB3 roothub first
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 30 Aug 2018 09:09:52 +0800
In-Reply-To: <f144173b-6131-21cf-1ead-60d938ac289a@cogentembedded.com>
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
         <f144173b-6131-21cf-1ead-60d938ac289a@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, 2018-08-29 at 12:13 +0300, Sergei Shtylyov wrote:
> On 8/29/2018 5:55 AM, Chunfeng Yun wrote:
> 
> > Give USB3 devices a better chance to enumerate at USB3 speeds if
> > they are connected to a suspended host.
> > Porting from "671ffdf xhci: resume USB 3 roothub first"
> 
>     From commit 671ffdff5b13 ("xhci: resume USB 3 roothub first").

Ok, Thanks

> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> [...]
> 
> MBR, Sergei
> 


