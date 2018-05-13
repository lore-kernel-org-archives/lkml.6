Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeEMNDe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 09:03:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49218 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeEMNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 09:03:33 -0400
Date: Sun, 13 May 2018 15:03:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Joe Perches <joe@perches.com>
cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/6] x86/early-quirks: Rename duplicate define of
 dev_err
In-Reply-To: <8fb4b2a77d50e21ae1f7e4e267e68691efe2c270.1525878372.git.joe@perches.com>
Message-ID: <alpine.DEB.2.21.1805131503050.1582@nanos.tec.linutronix.de>
References: <cover.1525878372.git.joe@perches.com> <8fb4b2a77d50e21ae1f7e4e267e68691efe2c270.1525878372.git.joe@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018, Joe Perches wrote:

> dev_err is becoming a macro calling _dev_err to allow prefixing of
> dev_fmt to any dev_<level> use that has a #define dev_fmt(fmt) similar
> to the existing #define pr_fmt(fmt) uses.
> 
> Remove this dev_err macro and convert the existing two uses to pr_err.
> This allows clean compilation in the patch that introduces dev_fmt which
> can prefix dev_<level> logging macros with arbitrary content similar to
> the #define pr_fmt macro.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I assume you want to take them as block, so:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
