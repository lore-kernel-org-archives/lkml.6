Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeBHSAK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:00:10 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:40725 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeBHSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:00:04 -0500
X-Google-Smtp-Source: AH8x225sdd7cZBMxrP8sLBBHJ0RZOBfqeq6HPop8/wyXLLV36Pe8StVSIIlFpvPLxoknJIulIMJ0pA==
Date: Thu, 08 Feb 2018 10:00:01 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 09:57:58 PST (-0800)
Subject: Re: [patches] [PATCH] RISC-V: Enable IRQ during exception handling
In-Reply-To: <20180202094528.GA31249@lst.de>
CC: zongbox@gmail.com, albert@sifive.com, patches@groups.riscv.org,
        linux-kernel@vger.kernel.org, zong@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-3166ddba-8a8a-4f7d-b13c-3f87801d401c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Feb 2018 01:45:28 PST (-0800), Christoph Hellwig wrote:
> Looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, I'm still working through my FOSDEM-related email backlog.  I'll target 
this for the next RC, as it seems like a small enough fix.  It should be in the 
next linux-next.
