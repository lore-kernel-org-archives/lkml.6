Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEMTXU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:23:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeEMTXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:23:20 -0400
Date: Sun, 13 May 2018 21:23:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] x86/mtrr: Convert to use match_string() helper
In-Reply-To: <20180503211217.47822-1-andriy.shevchenko@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805132119510.1582@nanos.tec.linutronix.de>
References: <20180503211217.47822-1-andriy.shevchenko@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018, Andy Shevchenko wrote:

> The new helper returns index of the matching string in an array.

new helper? match_string() is in tree for 2 years.

> We are going to use it here.

Are we going to use it ? When?

"Replace the open coded array lookup." or something like that would be more
appropriate.

Thanks,

	tglx
