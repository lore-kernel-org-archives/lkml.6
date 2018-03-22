Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCVWiF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:38:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVWiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:38:04 -0400
Date: Thu, 22 Mar 2018 15:38:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com
Subject: Re: [PATCH 0/2] Kexec_file: Load kernel at top of system ram
Message-Id: <20180322153802.0763bb46978c0c1a3d3f11c0@linux-foundation.org>
In-Reply-To: <20180322033722.9279-1-bhe@redhat.com>
References: <20180322033722.9279-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018 11:37:20 +0800 Baoquan He <bhe@redhat.com> wrote:

> The current kexec_file ignores kexec_buf.top_down value when call
> arch_kexec_walk_mem() to allocate memory for loading kernel/initrd
> stuffs. This is not supposed to be what kexec_buf.top_down is used
> for.

OK, but why is this a problem?  When fixing a bug, please fully
describe the user-visible effects of that bug.  That helps others
understand the importance of the fix, whether it should be backported
into various kernels, etc.
