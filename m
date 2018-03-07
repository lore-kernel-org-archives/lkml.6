Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933890AbeCGQAx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:00:53 -0500
Received: from forward101j.mail.yandex.net ([5.45.198.241]:38112 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933555AbeCGQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:00:51 -0500
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1520437971.3731.22.camel@flygoat.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        James Hogan <jhogan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Date: Wed, 07 Mar 2018 23:52:51 +0800
In-Reply-To: <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
         <20170927151527.25570-4-prasannatsmkumar@gmail.com>
         <20180306000832.GL4197@saruman>
         <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
         <20180307143541.GN4197@saruman>
         <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-03-07三的 20:35 +0530，PrasannaKumar Muralidharan写道：
> Hi James,
> 
> Seems Jiaxun is interested in the board and is willing to help.
> 
> I have been told that Ingenic is focusing on IoT market and X1000 is
> intended for IoT segment. I think that they would be selling several
> 100Ks of chip over the coming years. But I feel Ingenic spends time
> only on maintaining their Linux port which is usually based on very
> old kernel version.

Ingenic is going to release their XBrust2 core with it's products such
as X2000 a few days later. Witch is a pure MIPS64r5 with MXU2(A
superset of MIPS's MSA SIMD instruction set). The newest kernel port of
X1000 maintain by Ingenic is based on Linux-4.4 [1]. After communicated
with Ingenic, they said they are forcusing on China domestic market.
But they're looking for partners to enter foriegn market. 

[1] https://pan.baidu.com/s/1o8MeYts (Well you can download from this
Chinese website, ingenic have a gerrit but I don't have access to it.
As my experience, it's hard to develop on Chinese-made chips wihout
reading Chinese documents.)  
> 
> > 
