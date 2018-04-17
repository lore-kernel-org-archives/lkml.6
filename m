Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeDQRWs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:22:48 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:38228 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbeDQRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:22:45 -0400
Date: Tue, 17 Apr 2018 19:22:36 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180417172236.GA17342@light.dominikbrodowski.net>
References: <20180417130702.01575029@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417130702.01575029@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   Added back original compare to not miss 32bit kernel syscalls

s/32bit/32bit and 0-parameter syscalls.

Looks good otherwise.

Thanks,
	Dominik
