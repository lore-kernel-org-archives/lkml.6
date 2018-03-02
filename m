Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936168AbeCBHgx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:36:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53978 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935717AbeCBHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:36:51 -0500
X-Google-Smtp-Source: AG47ELtVpg85tcIJQRdFErgjR1QjlCfMDZKJv2JG9rrEKbmxbt1WlkzQpWEqs5zVV1cQDxhvW/bkOA==
Date: Fri, 2 Mar 2018 10:36:38 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, hpa@zytor.com, dyoung@redhat.com,
        x86@kernel.org, ebiederm@xmission.com, douly.fnst@cn.fujitsu.com,
        vgoyal@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export value to tell if 5-level is
 enabled
Message-ID: <20180302073638.muyzw7ei2oc2yoyb@node.shutemov.name>
References: <20180302051801.19594-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302051801.19594-1-bhe@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 01:18:01PM +0800, Baoquan He wrote:
> Userspace utility needs to know if the corrupted kernel is in
> 5-level paging mode. So write 'pgtable_l5_enabled' to vmcoreinfo.
> It covers below three cases:
>   pgtable_l5_enabled == 0 when
>   Compile kernel with CONFIG_X86_5LEVEL=n
>   Compile with CONFIG_X86_5LEVEL=y while cpu has no 'la57' flag
> 
>   pgtable_l5_enabled != 0 when
>   Compile with CONFIG_X86_5LEVEL=y and cpu has 'la57' flag
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
