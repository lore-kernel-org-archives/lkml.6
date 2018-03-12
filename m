Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeCLJx5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:53:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752568AbeCLJx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:53:56 -0400
Date: Mon, 12 Mar 2018 10:53:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180312095336.GB9431@pd.tnic>
References: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 04:27:03PM +0100, Maciej S. Szmigiero wrote:
> +/* 4k */
> +#define UCODE_EQUIV_CPU_TABLE_MAX_SIZE (256 * sizeof(struct equiv_cpu_entry))

And you came up with that max size how exactly?

> +/* If a patch is larger than this the microcode file is surely corrupted */
> +#define PATCH_MAX_SIZE_ABSOLUTE (16 * 1024 * 1024)a

Same question here.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
