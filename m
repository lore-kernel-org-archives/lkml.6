Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeFDERy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:17:54 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42018 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDERw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:17:52 -0400
X-Google-Smtp-Source: ADUXVKIFTgGd4D0UEwOryO85mnBB68mL6kEXIEBFkmQIVMPXUGSxLG6FEgCTqVBdEsuvmmlxtZm99A==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the filesystem
 from the tree.
From: Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <CF1B7A14-3C16-4CD1-8274-C6A3E0065624@dilger.ca>
Date: Mon, 4 Jun 2018 07:17:48 +0300
Cc: NeilBrown <neilb@suse.com>, Andreas Dilger <andreas.dilger@intel.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        lustre-devel <lustre-devel@lists.lustre.org>
Message-Id: <271C72E6-27C0-425F-B43F-16A37C638DCB@gmail.com>
References: <20180601091133.GA27521@kroah.com>
 <20180601114151.GA25225@infradead.org>
 <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
 <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
 <87h8mmrt6b.fsf@notabene.neil.brown.name>
 <58123CDD-8424-4E1D-A11F-0F899970A49B@intel.com>
 <87h8mjp5o0.fsf@notabene.neil.brown.name>
 <FE290581-D17D-4CEC-9AE2-B79DCBBD0823@gmail.com>
 <CF1B7A14-3C16-4CD1-8274-C6A3E0065624@dilger.ca>
To: Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w544Hwin012572


> 4 июня 2018 г., в 7:15, Andreas Dilger <adilger@dilger.ca> написал(а):
> 
> On Jun 3, 2018, at 9:59 PM, Alexey Lyashkov <alexey.lyashkov@gmail.com> wrote:
>> 
>>> On Sun, Jun 03 2018, Dilger, Andreas wrote:
>>> 
>>>> LNet is originally based on a high-performance networking stack called
>>>> Portals (v3, http://www.cs.sandia.gov/Portals/), with additions for LNet
>>>> routing to allow cross-network bridging.
>>>> 
>>>> A critical part of LNet is that it is for RDMA and not packet-based
>>>> messages.  Everything in Lustre is structured around RDMA.  Of course,
>>>> RDMA is not possible with TCP
>> 
>> To be clear. Soft IB (aka Soft RoCE) driver is part of OFED stack from 4.8
>> (or 4.9).  So RDMA API now is possible with TCP networks.
> 
> Well, strictly speaking RoCE still isn't possible with TCP networks.  RoCE v1
> is an Ethernet layer protocol (not IP based), while RoCE v2 is UDP/IP based.
> 
> 
Andreas,

I talk about RXE driver in OFED stack. It have works over TCP networks.
It likely to be RoCE v2 compatible as UDP tunnel use and exist for while.



Alex
