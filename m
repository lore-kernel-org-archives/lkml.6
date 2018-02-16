Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966764AbeBPMfN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:35:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:50409 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeBPMfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:35:12 -0500
Date: Fri, 16 Feb 2018 13:35:10 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Colin King <colin.king@canonical.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] HID: asus: make array 'buf' static const, shrinks
 object size
In-Reply-To: <20180106155027.17561-1-colin.king@canonical.com>
Message-ID: <nycvar.YFH.7.76.1802161335000.13621@cbobk.fhfr.pm>
References: <20180106155027.17561-1-colin.king@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2018, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const read-only array 'buf' on the stack but instead
> make it stati. Makes the object code smaller by 26 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   14378	   2384	     64	  16826	   41ba	linux/drivers/hid/hid-asus.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   14296	   2440	     64	  16800	   41a0	linux/drivers/hid/hid-asus.o
> 
> (gcc version 7.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-4.17/upstream.

-- 
Jiri Kosina
SUSE Labs
