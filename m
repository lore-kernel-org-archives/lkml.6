Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeEMIrB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:47:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58338 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:46:59 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PM / core: Clean up suspend/resume diagnostic messages
Date: Sun, 13 May 2018 10:46:29 +0200
Message-ID: <2450217.aSupH1P1pj@aspire.rjw.lan>
In-Reply-To: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 26, 2018 11:36:20 PM CEST Bjorn Helgaas wrote:
> These are pretty minor cleanups to the suspend/resume diagnostic messages.
> 
> The first two are trivial.  The third may break scripts that parse dmesg
> output.  I looked at scripts/bootgraph.pl, and I don't think it is
> affected, but there may be others I don't know about.  Let me know if there
> are.
> 
> ---
> 
> Bjorn Helgaas (3):
>       PM / core: Remove unused initcall_debug_report() arguments
>       PM / core: Simplify initcall_debug_report() timing
>       PM / core: Use dev_printk() and symbols in suspend/resume diagnostics
> 
> 
>  drivers/base/power/main.c |   37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 

All [1-3/3] applied, thanks!
