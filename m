Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeC2AlO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:41:14 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34103 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC2AlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:41:12 -0400
X-Google-Smtp-Source: AIpwx48Dc4hH61EBBZLRmSSTbDABBQ2P3aGAthOHDdC0gpDCNJyljs2bqcxopUEFJ9k3jbnV5di6+Q==
Date: Wed, 28 Mar 2018 17:41:11 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Mar 2018 17:34:21 PDT (-0700)
Subject: Re: [PATCH 1/2] perf: riscv: preliminary RISC-V support
In-Reply-To: <CAJ2AOiNQiTpJ9cBCb_fXVCyVNj9U-Xk3tUG=9toAC7HpQTRQvA@mail.gmail.com>
CC: alankao@andestech.com, albert@sifive.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, corbet@lwn.net,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickhu@andestech.com,
        greentime@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: sols@sifive.com
Message-ID: <mhng-98d52ac2-733f-48af-9a31-5717c7ee5d01@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018 15:31:30 PDT (-0700), sols@sifive.com wrote:
> Also, core IDs and socket IDs are wrong in perf report:

It looks like for this we need the stuff in topology.h.  I've cobbled something 
together quickly for Alex to use for now to see if that fixes other problems, 
I'll submit a sane version when we can.
