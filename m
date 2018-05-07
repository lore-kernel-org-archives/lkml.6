Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeEGJFR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:05:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeEGJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:05:15 -0400
Date: Mon, 7 May 2018 11:04:43 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86: Convert mce timer to hrtimer
Message-ID: <20180507090443.upr4gif6mcnwt357@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504111459.24825-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 13:14:58 [+0200], To linux-kernel@vger.kernel.org wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> mce_timer is started in atomic contexts of cpu bringup. This results
> in might_sleep() warnings on RT. Convert mce_timer to a hrtimer to
> avoid this.

After an additional review I got to say that this patch can be dropped
as it is no longer required.
Sorry to bother you with this.

Sebastian
