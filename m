Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02117C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB16720989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfAaBqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:46:53 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:17301 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbfAaBqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:46:53 -0500
X-UUID: d9f6569fa8304cca826d9b9cb9f06588-20190131
X-UUID: d9f6569fa8304cca826d9b9cb9f06588-20190131
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1939330871; Thu, 31 Jan 2019 09:46:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 09:46:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 09:46:45 +0800
Message-ID: <1548899205.6058.9.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: xhci: remove unused member 'parent' in xhci_regset
 struct
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Thu, 31 Jan 2019 09:46:45 +0800
In-Reply-To: <20190130071259.GC1204@kroah.com>
References: <1548814341-15116-1-git-send-email-chunfeng.yun@mediatek.com>
         <20190130071259.GC1204@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 08:12 +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 30, 2019 at 10:12:21AM +0800, Chunfeng Yun wrote:
> > The member @parent of xhci_regset struct is not used in fact,
> > so remove it
> > 
> > Change-Id: Ic6727c28f7200782fe4516bcb41c789b427318a2
> 
> No need for this line :(
Oh, my bad, I'll resend it, thanks


