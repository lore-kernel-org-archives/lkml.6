Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeDDPVg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:21:36 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51447 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeDDPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:21:35 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "shea@shealevy.com" <shea@shealevy.com>
CC: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v6 04/16] arc: Switch to generic free_initrd_mem.
Thread-Topic: [PATCH v6 04/16] arc: Switch to generic free_initrd_mem.
Thread-Index: AQHTyco7FIRfbXhcEkmsj8ztRF8FTKPwnByA
Date: Wed, 4 Apr 2018 15:21:33 +0000
Message-ID: <1522855291.4851.34.camel@synopsys.com>
References: <20180329113207.30674-1-shea@shealevy.com>
         <20180401145931.7932-1-shea@shealevy.com>
         <20180401145931.7932-4-shea@shealevy.com>
In-Reply-To: <20180401145931.7932-4-shea@shealevy.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD4C5BA1424CA448B3D92DCD8B7089FC@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w34FLgda025205

Hi Shea,

On Sun, 2018-04-01 at 10:59 -0400, Shea Levy wrote:
> The first patch in this series added a weakly-defined generic
> implementation, which is functionally identical to the
> architecture-specific one removed here.
> 
> Series boot-tested on RISC-V (which now uses the generic
> implementation) and x86_64 (which doesn't).
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>

Boot-tested on ARC, thus...

Tested-by: Alexey Brodkin <abrodkin@synopsys.com>

-Alexey

P.S. Note Vineet is out this week so please wait for him to return
next week to ack your patch.
