Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeCPX2h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 19:28:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeCPX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 19:28:36 -0400
Date: Fri, 16 Mar 2018 16:28:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] proc: fixup test for read
Message-Id: <20180316162835.d56e224942a774ad28c3af3d@linux-foundation.org>
In-Reply-To: <20180316232147.GA20146@avx2>
References: <20180316232147.GA20146@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2018 02:21:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> /proc/kmsg can and will block if read under root.
> 

This fixes
proc-shotgun-test-read-readdir-readlink-a-little-write.patch.  It helps
to point that out, so that reviewers won't be scrambling around
asking wtf.
