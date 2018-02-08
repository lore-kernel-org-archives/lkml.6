Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeBHPbS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBHPbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:31:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7878B2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:31:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Vladislav Valtchev (VMware)" <vladislav.valtchev@gmail.com>
Cc: linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        y.karadz@gmail.com
Subject: Re: [PATCH] trace-cmd: Make the build messages to show only file
 names
Message-ID: <20180208103115.762f6ee3@gandalf.local.home>
In-Reply-To: <20180208091820.4920-1-vladislav.valtchev@gmail.com>
References: <20180208091820.4920-1-vladislav.valtchev@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Feb 2018 11:18:20 +0200
"Vladislav Valtchev (VMware)" <vladislav.valtchev@gmail.com> wrote:

> Currently, the typical trace-cmd build messages like "COMPILE <file>" and
> "BUILD STATIC LIB <file>" show file's full path, instead of just the file
> name, as it used to happen before the full support for out-of-tree builds.
> This simple patch makes the build messages to look exactly like in the past
> by stripping the directory part of each file path, before printing the
> message.
> 
>

Thanks, applied!

-- Steve
