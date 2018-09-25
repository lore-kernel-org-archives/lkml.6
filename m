Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A893C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D96620877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D96620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeIYRp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:45:57 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:58653 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbeIYRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:45:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6BB25180622D7;
        Tue, 25 Sep 2018 11:38:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jail58_4c958fbbc2a24
X-Filterd-Recvd-Size: 1898
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 11:38:46 +0000 (UTC)
Message-ID: <828b6ebc79b606c3d5304540e66b1f9e47dd30e6.camel@perches.com>
Subject: Re: [PATCH 3.18 104/105] IB/nes: Fix a compiler warning
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Date:   Tue, 25 Sep 2018 04:38:44 -0700
In-Reply-To: <20180925113214.GA1783@kroah.com>
References: <20180924113113.268650190@linuxfoundation.org>
         <20180924113123.002918395@linuxfoundation.org>
         <6f7ca3c205bada768c3918b1feacbbd5ce23a64d.camel@perches.com>
         <20180924175902.GB19402@kroah.com>
         <6d6f31c87b0c9b1a551d352439183c8c9c4df04c.camel@perches.com>
         <20180924223952.GA9157@sasha-vm> <20180925085558.GA22609@kroah.com>
         <086cc82aed26b082fbe5eefc0eeae2ec634e4a1a.camel@perches.com>
         <20180925113214.GA1783@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 13:32 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 25, 2018 at 04:11:38AM -0700, Joe Perches wrote:
> > On Tue, 2018-09-25 at 10:55 +0200, Greg Kroah-Hartman wrote:
[]
> > > No warnings is great,
> > 
> > I believe that is not necessarily true.
> 
> For me, it is essencial.
[]
> > Change to a new compiler version and new warnings could be
> > added somewhat arbitrarily.
> 
> That's true, and is why I am stuck at gcc7 at the moment, as gcc8 does
> horrid things to older stable kernels :)

Your statements conflict.
