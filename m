Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeBSTw3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:52:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932078AbeBSTw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:52:26 -0500
Subject: Re: [PATCH v3 2/3] s390/char : Rename EBCDIC keymap variables
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <4e0d31cf01c9fff5fe177338f14b1ca3f6871fb5.1519053920.git.alifm@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <250077c8-ccef-fbbc-1d53-8a5cc3984243@redhat.com>
Date: Mon, 19 Feb 2018 20:52:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4e0d31cf01c9fff5fe177338f14b1ca3f6871fb5.1519053920.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2018 16:47, Farhan Ali wrote:
> The Linux Virtual Terminal (VT) layer provides a default keymap
> which is compiled when VT layer is enabled. But at the same time
> we are also compiling the EBCDIC keymap and this causes the linker
> to complain.
> 
> So let's rename the EBCDIC keymap variables to prevent linker
> conflict.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
>  drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
>  drivers/s390/char/keyboard.h  | 11 ++++++++
>  3 files changed, 61 insertions(+), 48 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
