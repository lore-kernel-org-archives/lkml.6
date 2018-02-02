Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeBBS7y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:59:54 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:32860 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbeBBS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:59:46 -0500
X-Google-Smtp-Source: AH8x225X9WNQJLhppZdVnbAvK12ndbj0cSK1TI8CpTBOiawigdHbrerkU+2m6cp/2KmDkGyY/yj97GK7npTRxR3lxJ8=
MIME-Version: 1.0
In-Reply-To: <20180202185301.GA8232@infradead.org>
References: <1517438756.3715.108.camel@gmail.com> <20180202185301.GA8232@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2018 10:59:43 -0800
Message-ID: <CANn89i+FBn3fttEyU_znAd-+8BgM7VZogFeeZPA7_zubChFpBA@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benjamin Serebrin <serebrin@google.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 10:53 AM, Christoph Hellwig <hch@infradead.org> wrote:
> I've got patches pending to replace all that code with
> dma_direct_alloc, which will do the right thing.  They were
> submitted for 4.16, and I will resend them after -rc1.

I see, thanks Christoph !
