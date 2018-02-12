Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936012AbeBLOl5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:41:57 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41945 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933843AbeBLOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:41:55 -0500
X-Google-Smtp-Source: AH8x225FsHp+oQr6bl0LCQmXOZNDIVT5PDKYXTP2muP4C8FZ7No6pX5hqqCTlZT59O2VD3XI2wcN6Q==
Date: Mon, 12 Feb 2018 08:41:53 -0600
From: Rob Herring <robh@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] auxdisplay: Move arm-charlcd binding to correct folder
Message-ID: <20180212144153.duvhxyg2ej3jx4bd@rob-hp-laptop>
References: <20180131140255.50268-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131140255.50268-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 04:02:55PM +0200, Andy Shevchenko wrote:
> This is a follow up to the commit
> 
>   00846a4425d3 ("auxdisplay: Move arm-charlcd.c to drivers/auxdisplay folder")
> 
> for Device Tree binding.
> 
> No functional change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/{misc => auxdisplay}/arm-charlcd.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{misc => auxdisplay}/arm-charlcd.txt (100%)

Applied, thanks.

Rob
