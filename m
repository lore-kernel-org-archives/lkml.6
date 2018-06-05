Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeFETW2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:22:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46667 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeFETW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:22:27 -0400
Date: Tue, 5 Jun 2018 21:22:25 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Joe Perches <joe@perches.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spdxcheck: Work with current HEAD LICENSES/ directory
In-Reply-To: <7eeefc862194930c773e662cb2152e178441d3b8.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1806052122120.1584@nanos.tec.linutronix.de>
References: <7eeefc862194930c773e662cb2152e178441d3b8.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018, Joe Perches wrote:

> Depending on how old your -next tree is, it may
> not have a master that has the LICENSES directory.
> 
> Change the lookup to HEAD and find whatever
> LICENSE directory files are used in that branch.
> 
> Miscellanea:
> 
> o Remove the checkpatch test as it will have its own
>   SPDX license identifier.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
