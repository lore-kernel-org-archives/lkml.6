Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeBHHD5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:03:57 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33036 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:03:55 -0500
X-Google-Smtp-Source: AH8x225Ak21rNH7dt2cq6iISRohGb+a/4h/BardenO0g5i518KkskmwpTtMVW3H9RrjSmuG+FCdtvQ==
Date: Thu, 8 Feb 2018 08:03:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180208070350.mxirhg32zljp2e4k@gmail.com>
References: <20180206114048.6c8ced1c@canb.auug.org.au>
 <750091485.16756.1517921554396.JavaMail.zimbra@efficios.com>
 <20180206135512.GB22740@arm.com>
 <1815310787.16844.1517926010063.JavaMail.zimbra@efficios.com>
 <20180206141118.GC22740@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206141118.GC22740@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Will Deacon <will.deacon@arm.com> wrote:

> For the sake of avoiding the conflict, can we just drop it for now, please?

Yeah, so I resolved the conflict by merging the (already upstream) bits and Linus 
pulled that resolution. From now on the level of comments you want there is up to 
you! :-)

Thanks,

	Ingo
