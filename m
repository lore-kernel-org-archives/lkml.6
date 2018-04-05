Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeDEPMt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeDEPMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:12:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C5F21857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AIpwx48YLaMzhBVH/9i4RQV9yzmhjUWWbf0YhtaAabzBE+bZnDltXRKji/ELim33+K2NepFlGKkcWz4A2u9Iv5SXLaQ=
MIME-Version: 1.0
In-Reply-To: <1522782152-27300-3-git-send-email-p.pisati@gmail.com>
References: <1522782152-27300-1-git-send-email-p.pisati@gmail.com> <1522782152-27300-3-git-send-email-p.pisati@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 5 Apr 2018 10:12:05 -0500
X-Gmail-Original-Message-ID: <CANk1AXTBNubsYm=psFRpL+q5oEckfyjdOfzmr-DOn69XCOCmbw@mail.gmail.com>
Message-ID: <CANk1AXTBNubsYm=psFRpL+q5oEckfyjdOfzmr-DOn69XCOCmbw@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 2:02 PM, Paolo Pisati <p.pisati@gmail.com> wrote:

Hi Paolo,

Looks good, except that I have to fix up the calls to
fpga_mgr_register/unregister since my API changes didn't go in.  I've
fixed those up and pushed to a branch on my kernel org git repo to let
the robots do some testing.  I'll post (v11 with those fixes) after
that is cleared.

We're too late for 4.17, expect it for 4.18.

Thanks,
Alan

> This patch adds support to the FPGA manager for programming
> MachXO2 device’s internal flash memory, via slave SPI.
>
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Acked-by: Alan Tull <atull@kernel.org>
