Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCVW2d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeCVW2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:28:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1792183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 22 Mar 2018 18:28:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace-cmd: Documentation: Fix title markers
Message-ID: <20180322182829.7c8d38f8@gandalf.local.home>
In-Reply-To: <20180321160334.16050-1-tiwai@suse.de>
References: <20180321160334.16050-1-tiwai@suse.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 17:03:34 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Fix the title markers that aren't aligned with the previous lines.
> This was caught by processing via asciidoctor, which is picker than
> asciidoc and aborts as an error.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

Thanks, Applied.

-- Steve
